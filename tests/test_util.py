"""
# Test script for AmsterdamUMCdb using both PostgreSQL and Google BigQuery
Tests utils for working with SQL queries between the two database systems

## Requirements
### Databases
- Working PostgreSQL server with fully setup AmsterdamUMCdb
- Access to AmsterdamUMCdb instance on Google BigQuery

### Config files:
- config.ini, by copying the config.SAMPLE.ini file and adding the credentials
- credentials.json, created by following the [Quickstart: Using client libraries](https://cloud.google.com/bigquery/docs/quickstarts/quickstart-client-libraries)
"""

import os
import pandas as pd
import configparser
import unittest
import amsterdamumcdb as adb

from google.cloud import bigquery
import psycopg2

from amsterdamumcdb import connections
from amsterdamumcdb import cohorts
from amsterdamumcdb import util


class UtilTests(unittest.TestCase):
    config = 'config.ini'
    if not os.path.exists(config):
        config = os.path.join('../', config)

    config_gbq = connections.connect_gbq(config)
    con_pg = connections.connect_pg(config)

    def test_sql_validated(self):
        orig_sql = "SELECT COUNT(*) FROM numericitems"
        print(f'Original SQL statement for validated data:\n{orig_sql}')

        sql_gbq = util.select_validated(orig_sql, con=self.config_gbq)
        print(f'Transformed SQL statement for Google BigQuery:\n{sql_gbq}')
        gbq = util.read_sql(orig_sql, con=self.config_gbq)
        print(gbq)

        sql_pg = util.select_validated(orig_sql, con=self.con_pg)
        print(f'Transformed SQL statement for PostgreSQL:\n{sql_pg}')
        pg = util.read_sql(orig_sql, con=self.con_pg)
        print(pg)

        self.assertEqual(gbq.values[0][0], pg.values[0][0])
        self.assertEqual(gbq.values[0][0], 68672818)  # number of validated numericitems excluding unvalidated

    def test_sql_include_unvalidated(self):
        orig_sql = "SELECT COUNT(*) FROM numericitems"
        print(f'Original SQL statement for unvalidated data:\n{orig_sql}')

        sql_gbq = util.select_validated(orig_sql, con=self.config_gbq, include_unvalidated=True)
        print(f'Transformed SQL statement for Google BigQuery:\n{sql_gbq}')
        gbq = util.read_sql("SELECT COUNT(*) FROM numericitems", con=self.config_gbq, include_unvalidated=True)
        print(gbq)

        sql_pg = util.select_validated(orig_sql, con=self.con_pg, include_unvalidated=True)
        print(f'Transformed SQL statement for PostgreSQL:\n{sql_pg}')
        pg = util.read_sql("SELECT COUNT(*) FROM numericitems", con=self.con_pg, include_unvalidated=True)
        print(pg)

        self.assertEqual(gbq.values[0][0], pg.values[0][0])
        self.assertEqual(gbq.values[0][0], 977625612)  # total number of numericitems including unvalidated


if __name__ == '__main__':
    unittest.main()



