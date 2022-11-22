"""
# Test script for AmsterdamUMCdb using both PostgreSQL and Google BigQuery
Tests SOFA functions

## Requirements
### Databases
- Working PostgreSQL server with fully setup AmsterdamUMCdb
- Access to AmsterdamUMCdb instance on Google BigQuery

### Config files:
- config.ini, by copying the config.SAMPLE.ini file and adding the credentials
- credentials.json, created by following the [Quickstart: Using client libraries](https://cloud.google.com/bigquery/docs/quickstarts/quickstart-client-libraries)
"""

import os
import unittest

from amsterdamumcdb import connections
from amsterdamumcdb import scores
import pandas as pd
import pandas.testing as pd_testing


def syncDataTypes(dataframe_left, dataframe_right):
    for col in dataframe_left.columns:
        dtype_left = dataframe_left[col].dtype
        dtype_right = dataframe_right[col].dtype
        if dtype_left != dtype_right:
            dataframe_right[col] = dataframe_right[col].astype(dtype_left)


class SOFATests(unittest.TestCase):
    def assertDataframeEqual(self, a, b, msg):
        try:
            syncDataTypes(a, b)
            pd_testing.assert_frame_equal(a, b)
        except AssertionError as e:
            raise self.failureException(msg) from e

    def setUp(self):
        config = 'config.ini'
        if not os.path.exists(config):
            config = os.path.join('../', config)

        self.config_gbq = connections.connect_gbq(config)
        self.con_pg = connections.connect_pg(config)

        self.addTypeEqualityFunc(pd.DataFrame, self.assertDataframeEqual)

    def test_sofa_admission(self):
        print('Testing retrieving full SOFA score at admission...')
        print('Google BigQuery...')
        sofa_gbq = scores.get_sofa_admission(con=self.config_gbq)
        print(sofa_gbq)

        print('PostgreSQL...')
        sofa_pg = scores.get_sofa_admission(con=self.con_pg)
        print(sofa_pg)

        self.assertEqual(sofa_gbq, sofa_pg)

    def test_sofa_bilirubin(self):
        print('Testing SOFA Liver: bilirubin...')
        print('Google BigQuery...')
        sofa_gbq = scores.get_sofa_bilirubin(con=self.config_gbq)
        print(sofa_gbq)

        print('PostgreSQL...')
        sofa_pg = scores.get_sofa_bilirubin(con=self.con_pg)
        print(sofa_pg)

        self.assertEqual(sofa_gbq, sofa_pg)

    def test_sofa_cardiovascular_map(self):
        print('Testing SOFA Cardiovascular: MAP...')
        print('Google BigQuery...')
        sofa_gbq = scores.get_sofa_cardiovascular_map(con=self.config_gbq)
        print(sofa_gbq)

        print('PostgreSQL...')
        sofa_pg = scores.get_sofa_cardiovascular_map(con=self.con_pg)
        print(sofa_pg)

        self.assertEqual(sofa_gbq, sofa_pg)

    def test_sofa_cardiovascular_meds(self):
        print('Testing SOFA Cardiovascular: vasopressors/inotropes...')
        print('Google BigQuery...')
        sofa_gbq = scores.get_sofa_cardiovascular_meds(con=self.config_gbq)
        print(sofa_gbq)

        print('PostgreSQL...')
        sofa_pg = scores.get_sofa_cardiovascular_meds(con=self.con_pg)
        print(sofa_pg)

        self.assertEqual(sofa_gbq, sofa_pg)

    def test_sofa_cns(self):
        print('Testing SOFA Central Nervous System: GCS...')
        print('Google BigQuery...')
        sofa_gbq = scores.get_sofa_cns(con=self.config_gbq)
        print(sofa_gbq)

        print('PostgreSQL...')
        sofa_pg = scores.get_sofa_cns(con=self.con_pg)
        print(sofa_pg)

        self.assertEqual(sofa_gbq, sofa_pg)

    def test_sofa_platelets(self):
        print('Testing SOFA Coagulation: Platelets...')
        print('Google BigQuery...')
        sofa_gbq = scores.get_sofa_platelets(con=self.config_gbq)
        print(sofa_gbq)

        print('PostgreSQL...')
        sofa_pg = scores.get_sofa_platelets(con=self.con_pg)
        print(sofa_pg)

        self.assertEqual(sofa_gbq, sofa_pg)

    def test_sofa_renal_creatinine(self):
        print('Testing SOFA Renal: Creatinine...')
        print('Google BigQuery...')
        sofa_gbq = scores.get_sofa_renal_creatinine(con=self.config_gbq)
        print(sofa_gbq)

        print('PostgreSQL...')
        sofa_pg = scores.get_sofa_renal_creatinine(con=self.con_pg)
        print(sofa_pg)

        self.assertEqual(sofa_gbq, sofa_pg)

    def test_sofa_renal_urine(self):
        print('Testing SOFA Renal: Daily urine output...')
        print('Google BigQuery...')
        sofa_gbq = scores.get_sofa_renal_daily_urine_output(con=self.config_gbq)
        print(sofa_gbq)

        print('PostgreSQL...')
        sofa_pg = scores.get_sofa_renal_daily_urine_output(con=self.con_pg)
        print(sofa_pg)

        self.assertEqual(sofa_gbq, sofa_pg)

    def test_sofa_respiration(self):
        print('Testing SOFA Respiration: Oxygenation...')
        print('Google BigQuery...')
        sofa_gbq = scores.get_sofa_respiration(con=self.config_gbq)
        print(sofa_gbq)

        print('PostgreSQL...')
        sofa_pg = scores.get_sofa_respiration(con=self.con_pg)
        print(sofa_pg)

        self.assertEqual(sofa_gbq, sofa_pg)


if __name__ == '__main__':
    unittest.main()
