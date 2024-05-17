# pip install pyyaml

import os
import configparser

import numpy as np
import psycopg
import pandas as pd
import sqlalchemy
from sqlalchemy import text
import requests
import yaml
from urllib.parse import urljoin

config = configparser.ConfigParser()

if os.path.isfile('../config.ini'):
    config.read('../config.ini')
else:
    config.read('../config.SAMPLE.ini')

schema = config['cdm']['schema']

print("Reading concept table...")
# Open a connection to the postgres database:
pg_con = psycopg.connect(dbname=config['cdm']['dbname'],
                         user=config['cdm']['username'], password=config['cdm']['password'],
                         host=config['cdm']['host'], port=config['cdm']['port'])

# create SQLAlchemy engine for official pandas database support
engine = sqlalchemy.create_engine('postgresql+psycopg://', creator=lambda: pg_con)
con = engine.connect()

sql = f"SELECT * FROM {schema}.concept;"
all_concepts = pd.read_sql(text(sql), con)

print("Processing Usagi mapping files...")
folder = "https://raw.githubusercontent.com/AmsterdamUMC/AMSTEL/main/data/mappings/"

# The list of local (AmsterdamUMCdb) vocabularies is stored in the
# local_vocabularies.yaml file in the mappings folder. A vocabulary
# can contain a sub-vocabulary based on the mapping type.

# Retrieve the local vocabularies from AMSTEL GitHub
yaml_file = "local_vocabularies.yaml"
response = requests.get(urljoin(folder, yaml_file))
content = response.content.decode("utf-8")
local_vocabularies = yaml.safe_load(content)

maps_list = []

for vocabulary in local_vocabularies:
    print(vocabulary)

    # destination is part of list items
    if vocabulary == 'admissions_destination':
        voc = "listitems_value"

        concepts = pd.read_csv(urljoin(folder, f"{voc}.usagi.csv"))
        concepts = concepts[concepts['ADD_INFO:itemid'] == 10472]

    # listitems values are considered a special case, since values can be
    # considered concepts

    elif vocabulary == 'listitems_meas_value':
        voc = "listitems_value"
        concepts = pd.read_csv(urljoin(folder, f"{voc}.usagi.csv"))
        concepts = concepts[concepts['domainId'] == "Meas Value"]

    elif vocabulary == 'listitems_obs_value':

        # the 'AUMC Obs Value' contains every value that will not be used in
        # another table
        voc = "listitems_value"
        concepts = pd.read_csv(urljoin(folder, f"{voc}.usagi.csv"))
        concepts = concepts[concepts['domainId'].isin([
            "Meas Value",
            "Device",
            "Procedure",
            "Condition"
        ])]

        # remove duplicates from listitems -> reason_for_admission
        voc = 'reason_for_admission'
        co_reason_for_admission = pd.read_csv(urljoin(folder, f"{voc}.usagi.csv"))
        concepts = concepts[~concepts['sourceCode'].isin(co_reason_for_admission['sourceCode'])]

        # remove duplicates from listitems -> admissions_destination
        concepts = concepts[~concepts['ADD_INFO:itemid'] == 10472]

    elif vocabulary == 'listitems_device':
        voc = "listitems_value"
        concepts = pd.read_csv(urljoin(folder, f"{voc}.usagi.csv"))
        concepts = concepts[concepts['domainId'] == "Device"]

    elif vocabulary == 'listitems_procedure':
        voc = "listitems_value"
        concepts = pd.read_csv(urljoin(folder, f"{voc}.usagi.csv"))
        concepts = concepts[concepts['domainId'] == "Procedure"]

    elif vocabulary == 'listitems_condition':
        voc = "listitems_value"
        concepts = pd.read_csv(urljoin(folder, f"{voc}.usagi.csv"))
        concepts = concepts[concepts['domainId'] == "Condition"]

    else:
        concepts = pd.read_csv(urljoin(folder, f"{vocabulary}.usagi.csv"))

    # add empty column that contains original Dutch item name for most tables
    # but missing from admissions
    if 'ADD_INFO:source_concept' not in concepts.columns:
        concepts['ADD_INFO:source_concept'] = np.NAN

    # add count columns if available
    if 'ADD_INFO:count_validated' in concepts.columns:
        concepts['source_frequency_validated'] = concepts['ADD_INFO:count_validated']
        concepts['source_frequency'] = concepts['sourceFrequency']
    elif 'ADD_INFO:count' in concepts.columns:
        concepts['source_frequency_validated'] = concepts['sourceFrequency']
        concepts['source_frequency'] = concepts['ADD_INFO:count']
    else:
        concepts['source_frequency_validated'] = concepts['sourceFrequency']
        concepts['source_frequency'] = concepts['sourceFrequency']

    # iterate mapping types for each vocabulary
    mapping_types = local_vocabularies[vocabulary]
    for mapping_type in mapping_types:
        voc_id = mapping_types[mapping_type]
        print(f"  * '{voc_id}' for {mapping_type} mapping")

        concepts_by_mapping_type = concepts[
            (concepts['mappingType'] == mapping_type) &
            (~concepts['sourceCode'].isna())
            ]

        if len(concepts_by_mapping_type) == 0:
            continue

        dictionary = concepts_by_mapping_type.merge(all_concepts, left_on="conceptId", right_on="concept_id",
                                                    how="left")
        dictionary['source_vocabulary_id'] = voc_id
        dictionary.loc[~(dictionary['ADD_INFO:source_concept'].isna()), 'source_code_description'] = dictionary[
            'ADD_INFO:source_concept']
        dictionary.loc[(dictionary['ADD_INFO:source_concept'].isna()), 'source_code_description'] = dictionary[
            'sourceCode']

        dictionary = dictionary[[
            "conceptId", "concept_name", "domain_id", "concept_class_id", "vocabulary_id",
            "concept_code", "source_vocabulary_id", "sourceCode", "source_code_description",
            "source_frequency", "source_frequency_validated",
            "mappingStatus", "equivalence"
        ]]

        # remove mappings if not APPROVED
        dictionary.loc[dictionary['mappingStatus'] != 'APPROVED', [
            "conceptId", "concept_name", "domain_id", "concept_class_id", "vocabulary_id",
            "concept_code"]
        ] = np.nan

        dictionary = dictionary.rename(columns={
            "sourceCode": "source_code", "conceptId": "concept_id",
            "mappingStatus": "mapping_status"
        })

        # wrap the data frame in a list to add as a single element
        maps_list.append(dictionary)

dictionary = pd.concat(maps_list)

# convert to the best possible data types to prevent integers from becoming floats
dictionary = dictionary.convert_dtypes()
dictionary.to_csv("../amsterdamumcdb/dictionary/dictionary.csv", index=False)
