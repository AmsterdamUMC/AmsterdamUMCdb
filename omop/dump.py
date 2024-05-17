import psycopg
from psycopg import sql
from tqdm import tqdm

# Connect to an existing database
import configparser
import os
import gzip

config = configparser.ConfigParser()

if os.path.isfile('../config.ini'):
    config.read('../config.ini')
else:
    config.read('../config.SAMPLE.ini')

schema = config['cdm']['schema']

vocabulary_list = [
    "concept",
    "vocabulary",
    "concept_ancestor",
    "concept_relationship",
    "relationship",
    "concept_synonym",
    "domain",
    "concept_class",
    "drug_strength",
    "source_to_concept_map"
]

data_list = [
    "cdm_source",
    "person",
    "death",
    "care_site",
    "location",
    "provider",
    "visit_occurrence",
    "condition_occurrence",
    "device_exposure",
    "drug_exposure",
    "measurement",
    "observation",
    "procedure_occurrence",
    "specimen"
]

derived_list = [
    "condition_era",
    "observation_period",
    "drug_era"
]

unused_list = [
    "cohort",
    "cohort_definition",
    "cost",
    "episode",
    "episode_event",
    "fact_relationship",
    "metadata",
    "note",
    "note_nlp",
    "payer_plan_period",
    "visit_detail",
]

tables = [
    *vocabulary_list,
    *data_list,
    *derived_list,
    *unused_list
]
print("Dumping CDM OMOP tables to CSV file...")
# Open a connection to the postgres database:
with psycopg.connect(dbname=config['cdm']['dbname'],
                     user=config['cdm']['username'], password=config['cdm']['password'],
                     host=config['cdm']['host'], port=config['cdm']['port']) as conn:
    # Open a cursor to perform database operations
    with conn.cursor() as cursor:

        for table in tables:

            filepath = os.path.join(os.path.abspath("../data/"), f"{table}.csv")
            with open(filepath, "wb") as f:

                with cursor.copy(
                        sql.SQL("COPY {schema}.{table} TO STDOUT WITH (FORMAT CSV, HEADER)").format(
                            schema=sql.Identifier(schema),
                            table=sql.Identifier(table))
                ) as copy:
                    pbar = tqdm(copy)
                    pbar.set_description("Processing %s" % table)
                    for data in pbar:
                        f.write(data)

print("Done.")


# get size of csv files
total_size = 0
for root, dirs, files in os.walk("../data/"):
    for filename in files:
        if ".csv" in filename:
            path = os.path.join(root, filename)
            file_size = os.stat(path).st_size  # in bytes
            total_size = total_size + file_size

print(total_size)

# process all csv files
chunk_size = 1024 * 1024  # 1024 * 1024 byte = 1 mb

# create two tqdm progress bars
pbar_total = tqdm(total=total_size, initial=0, desc='Compressing csv files',
                  dynamic_ncols=True, unit_scale=1, unit='Bytes',
                  leave=True)

pbar_file = tqdm(total=0, desc='Current file:', dynamic_ncols=True, unit_scale=1, unit='Bytes',
                 leave=True)

for root, dirs, files in os.walk("../data/"):
    for filename in files:
        if ".csv" in filename:
            path = os.path.join(root, filename)
            file_size = os.stat(path).st_size  # in bytes

            pbar_file.set_description('Current file: ' + filename)
            pbar_file.reset(total=file_size)
            pbar_file.refresh()

            with open(path, 'rb') as f_in:
                with gzip.open(f"{path}.gz", 'wb') as f_out:
                    while True:
                        buf = f_in.read(chunk_size)
                        if not buf:
                            break
                        f_out.write(buf)

                        pbar_file.update(len(buf))
                        pbar_total.update(len(buf))
