import os
import configparser

import sqlalchemy
from google.cloud import bigquery
import psycopg2


def connect_gbq(config_file='config.ini'):
    """
    Setup connection for Google BigQuery using pandas gbq API

    Returns: config_gbq Dict
    """
    config = configparser.ConfigParser()
    config.read(config_file)

    credentials_file = os.path.join(os.path.dirname(os.path.abspath(config_file)),
                                    config['bigquery']['credentials_file'])

    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credentials_file
    # sets default dataset for AmsterdamUMCdb
    DATASET_PROJECT_ID = config['bigquery']['dataset_project_id']
    DATASET_ID = config['bigquery']['dataset_id']
    LOCATION = config['bigquery']['location']

    # create a Client object that handles authentication
    client = bigquery.Client()

    config_gbq = {'query':
        {'defaultDataset': {
            "datasetId": DATASET_ID,
            "projectId": DATASET_PROJECT_ID
        },
            'Location': LOCATION}
    }
    return config_gbq


def connect_pg(config_file='config.ini'):
    """
    Setup connection for SQLAlchemy for postgres using psycopg2.
    Currently, only a connection using the SQLAlchemy engine is supported.

    Returns: psycopg2 connection
    """
    import configparser
    import os
    config = configparser.ConfigParser()

    config.read(config_file)

    # Open a connection to the postgres database:
    pg_con = psycopg2.connect(database=config['psycopg2']['database'],
                              user=config['psycopg2']['username'], password=config['psycopg2']['password'],
                              host=config['psycopg2']['host'], port=config['psycopg2']['port'])
    pg_con.set_client_encoding('WIN1252')  # Uses code page for Dutch accented characters.
    pg_con.set_session(autocommit=True)

    cursor = pg_con.cursor()
    cursor.execute('SET SCHEMA \'amsterdamumcdb\'');  # set search_path to amsterdamumcdb schema

    # create SQLAlchemy engine for official pandas database support
    engine = sqlalchemy.create_engine('postgresql+psycopg2://', creator=lambda: pg_con)
    con = engine.connect()

    return con
