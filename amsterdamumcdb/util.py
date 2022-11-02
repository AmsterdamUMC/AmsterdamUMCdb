import pandas as pd
import os
from .bigquery import pg2bq


def read_sql(sql, con):
    """
    Small wrapper around Pandas read_sql and read_gbq to de-duplicate code fragments that should work both on (local)
    postgreSQL instances and Google BigQuery ofr AmsterdamUMCdb.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """

    if type(con) is dict:  # BigQuery config
        # translate query from PostgreSQL dialect to BigQuery
        sql = pg2bq(sql)
        result = pd.read_gbq(sql, configuration=con)
    else:
        result = pd.read_sql(sql, con)

    return result


def query(filename, con):
    """
    Queries using a SQL script located in the `sql` folder. Translates the SQL code as needed.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    # gets the SQL source file
    dirname = os.path.dirname(os.path.abspath(__file__))
    sql_filename = os.path.join(dirname, 'sql', filename)

    print(f"Querying '{sql_filename}'...")
    with open(sql_filename, 'r') as sql_file:
        sql = sql_file.read()

    return read_sql(sql, con)
