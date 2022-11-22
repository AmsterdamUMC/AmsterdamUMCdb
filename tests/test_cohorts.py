"""
# Test script for AmsterdamUMCdb using both PostgreSQL and Google BigQuery
Tests cohort scripts for working with SQL queries between the two database systems

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


class CohortsTests(unittest.TestCase):
    config = 'config.ini'
    if not os.path.exists(config):
        config = os.path.join('../', config)

    config_gbq = connections.connect_gbq(config)
    con_pg = connections.connect_pg(config)

    def test_cardiothoracic_surgery_cohort(self):
        print('Testing cardio-thoracic surgery cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_cardiothoracic_surgery_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_cardiothoracic_surgery_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(5938, count_gbq)

    def test_infection_cohort(self):
        print('Testing infection cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_infection_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_infection_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(3152, count_gbq)

    def test_respiratory_failure_cohort(self):
        print('Testing respiratory failure cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_respiratory_failure_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_respiratory_failure_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(1517, count_gbq)

    def test_neurosurgery_cohort(self):
        print('Testing neurosurgery cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_neurosurgery_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_neurosurgery_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(1618, count_gbq)

    def test_gastrointestinal_surgery_cohort(self):
        print('Testing gastrointestinal surgery cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_gastrointestinal_surgery_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_gastrointestinal_surgery_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(1149, count_gbq)

    def test_cardiac_arrest_cohort(self):
        print('Testing cardiac arrest cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_cardiac_arrest_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_cardiac_arrest_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(961, count_gbq)

    def test_vascular_surgery_cohort(self):
        print('Testing vascular surgery cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_vascular_surgery_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_vascular_surgery_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(1037, count_gbq)

    def test_trauma_cohort(self):
        print('Testing trauma cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_trauma_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_trauma_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(1242, count_gbq)

    def test_neuro_cohort(self):
        print('Testing neurologic disorders cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_neuro_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_neuro_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(627, count_gbq)

    def test_cardio_cohort(self):
        print('Testing cardiac disorders cohort...')
        print('Google BigQuery...')
        patients_gbq = cohorts.get_cardio_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = cohorts.get_cardio_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(538, count_gbq)

    # @unittest.skip("Skip Sepsis-3 cohort testing") # this test will take some time
    def test_sepsis3_cohort(self):
        print('Testing Sepsis-3 cohort...')
        print('Google BigQuery...')
        patients_gbq = adb.get_sepsis_patients(con=self.config_gbq)
        print(patients_gbq)
        count_gbq = len(patients_gbq)
        print(f'{count_gbq} patients')

        print('PostgreSQL...')
        patients_pg = adb.get_sepsis_patients(con=self.con_pg)
        print(patients_pg)
        count_pg = len(patients_pg)
        print(f'{count_pg} patients')

        self.assertEqual(count_gbq, count_pg)
        self.assertEqual(count_gbq, 3019)


if __name__ == '__main__':
    unittest.main()
