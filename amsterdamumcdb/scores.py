import os

import numpy as np
import pandas as pd
from .util import read_sql

dirname = os.path.dirname(os.path.abspath(__file__))


def get_sofa_respiration(con) -> pd.DataFrame:
    """
    Return SOFA Respiration: PaO2 / FiO2 (mmHg)

    Simultaneously retrieve PaO2 and the 'nearest' FiO2 from the ventilator or estimated FiO2 based on applied oxygen
    device. Ideally documentation of measurements should be at the same time, but since this is not guaranteed allow an
    offset. Note: in more recent data PaCO2 and PaO2 were documented in kPa instead of mmHg.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    print('Querying SOFA Respiration...')
    filename = './sql/common/pO2_FiO2_estimated.sql'
    sql_filename = os.path.join(dirname, filename)
    with open(sql_filename, 'r') as sql_file:
        sql_sofa_respiration = sql_file.read()
    sofa_respiration = read_sql(sql_sofa_respiration, con)

    print('Processing SOFA Respiration...')
    # remove extreme outliers
    sofa_respiration.loc[(sofa_respiration['fio2'] > 100), 'fio2'] = np.NaN

    # convert FiO2 in % to fraction
    sofa_respiration.loc[(sofa_respiration['fio2'] <= 100) &
                         (sofa_respiration['fio2'] >= 20), 'fio2'] = sofa_respiration['fio2'] / 100

    # remove extreme outliers (FiO2) (possible O2 flow?)
    sofa_respiration.loc[(sofa_respiration['fio2'] > 1), 'fio2'] = np.NaN

    # remove lower outliers, most likely incorrectly labeled as 'arterial' instead of '(mixed/central) venous'
    sofa_respiration.loc[sofa_respiration['pao2'] < 50, 'pao2'] = np.NaN
    sofa_respiration = sofa_respiration.dropna(subset=['pao2'])

    # calculate PF-ratio
    sofa_respiration.loc[:, 'pf_ratio'] = sofa_respiration['pao2'] / sofa_respiration['fio2']

    # calculate SOFA respiration score:
    sofa_respiration.loc[:, 'sofa_respiration_score'] = 0
    sofa_respiration.loc[(sofa_respiration['pf_ratio'] < 400) &
                         (sofa_respiration['pf_ratio'] >= 300), 'sofa_respiration_score'] = 1
    sofa_respiration.loc[(sofa_respiration['pf_ratio'] < 300), 'sofa_respiration_score'] = 2
    sofa_respiration.loc[(sofa_respiration['pf_ratio'] < 200) & (sofa_respiration['pf_ratio'] >= 100) &
                         (sofa_respiration['ventilatory_support'] is True), 'sofa_respiration_score'] = 3
    sofa_respiration.loc[(sofa_respiration['pf_ratio'] < 100) &
                         (sofa_respiration['ventilatory_support'] is True), 'sofa_respiration_score'] = 4

    return sofa_respiration.sort_values(by=['admissionid', 'time']).reset_index(drop=True)


def get_sofa_cardiovascular_meds(con) -> pd.DataFrame:
    """
    Returns SOFA: Cardiovascular - Hypotension, cardiovascular medication: vasopressors and / or inotropes
    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    print('Querying SOFA Cardiovascular: vasopressors/inotropes...')
    filename = './sql/common/vasopressors_inotropes.sql'
    sql_filename = os.path.join(dirname, filename)
    with open(sql_filename, 'r', encoding='utf-8') as sql_file:
        sql_sofa_cardiovascular = sql_file.read()
    sofa_cardiovascular = read_sql(sql_sofa_cardiovascular, con)

    print('Processing SOFA Cardiovascular: vasopressors/inotropes...')
    sofa_cardiovascular_meds = sofa_cardiovascular.groupby(['admissionid', 'itemid', 'item']).agg(
        total_duration=pd.NamedAgg(column='duration', aggfunc='sum'),
        max_gamma=pd.NamedAgg(column='gamma', aggfunc='max')
    ).reset_index()

    # calculate SOFA cardiovascular score:
    sofa_cardiovascular_meds.loc[:, 'sofa_cardiovascular_score'] = 0

    # dopamine (itemid 7179) <= 5 or dobutamine (itemid 7178) any dose
    sofa_cardiovascular_meds.loc[(
                                         ((sofa_cardiovascular_meds['itemid'] == 7179) & (
                                                 sofa_cardiovascular_meds['max_gamma'] <= 5)) |
                                         (sofa_cardiovascular_meds['itemid'] == 7178)
                                 ), 'sofa_cardiovascular_score'] = 2

    # dopamine (itemid 7179) > 5, epinephrine (itemid 6818) <= 0.1, norepinephrine (itemid 7229) <= 0.1
    sofa_cardiovascular_meds.loc[(
                                         ((sofa_cardiovascular_meds['itemid'] == 7179) & (
                                                 sofa_cardiovascular_meds['max_gamma'] > 5) &
                                          (sofa_cardiovascular_meds['max_gamma'] < 15)) |
                                         ((sofa_cardiovascular_meds['itemid'] == 6818) & (
                                                 sofa_cardiovascular_meds['max_gamma'] <= 0.1)) |
                                         ((sofa_cardiovascular_meds['itemid'] == 7229) & (
                                                 sofa_cardiovascular_meds['max_gamma'] <= 0.1))
                                 ), 'sofa_cardiovascular_score'] = 3

    # dopamine (itemid 7179) > 15, epinephrine (itemid 6818) > 0.1, norepinephrine (itemid 7229) > 0.1
    sofa_cardiovascular_meds.loc[(
                                         ((sofa_cardiovascular_meds['itemid'] == 7179) & (
                                                 sofa_cardiovascular_meds['max_gamma'] > 15)) |
                                         ((sofa_cardiovascular_meds['itemid'] == 6818) & (
                                                 sofa_cardiovascular_meds['max_gamma'] > 0.1)) |
                                         ((sofa_cardiovascular_meds['itemid'] == 7229) & (
                                                 sofa_cardiovascular_meds['max_gamma'] > 0.1))
                                 ), 'sofa_cardiovascular_score'] = 4
    return sofa_cardiovascular_meds.sort_values(by='admissionid').reset_index(
        drop=True)


def get_sofa_platelets(con) -> pd.DataFrame:
    """
    Return SOFA Coagulation score.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    ############################################
    print('Querying SOFA Coagulation...')
    # get platelets (thrombocytes)
    filename = './sql/common/platelets.sql'
    sql_filename = os.path.join(dirname, filename)
    with open(sql_filename, 'r') as sql_file:
        sql_sofa_platelets = sql_file.read()
    sofa_platelets = read_sql(sql_sofa_platelets, con)

    # calculate SOFA coagulation score:
    print('Processing SOFA Coagulation...')
    sofa_platelets.loc[:, 'sofa_coagulation_score'] = 0
    sofa_platelets.loc[(sofa_platelets['value'] < 150) &
                       (sofa_platelets['value'] >= 100), 'sofa_coagulation_score'] = 1
    sofa_platelets.loc[(sofa_platelets['value'] < 100) &
                       (sofa_platelets['value'] >= 50), 'sofa_coagulation_score'] = 2
    sofa_platelets.loc[(sofa_platelets['value'] < 50) &
                       (sofa_platelets['value'] >= 20), 'sofa_coagulation_score'] = 3
    sofa_platelets.loc[(sofa_platelets['value'] < 20), 'sofa_coagulation_score'] = 4

    return sofa_platelets.sort_values(by=['admissionid', 'itemid', 'time']).reset_index(drop=True)


def get_sofa_bilirubin(con) -> pd.DataFrame:
    """
    Returns SOFA Liver scores.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    # SOFA: Liver - Bilirubin (µmol/l)
    ##################################
    # get bilirubin
    print('Querying SOFA Liver...')
    filename = './sql/common/bilirubin.sql'
    sql_filename = os.path.join(dirname, filename)
    with open(sql_filename, 'r') as sql_file:
        sql_sofa_bilirubin = sql_file.read()
    sofa_bilirubin = read_sql(sql_sofa_bilirubin, con)

    # calculate SOFA liver score:
    print('Processing SOFA Liver...')
    sofa_bilirubin.loc[:, 'sofa_liver_score'] = 0
    sofa_bilirubin.loc[(sofa_bilirubin['value'] >= 20) & (sofa_bilirubin['value'] < 33), 'sofa_liver_score'] = 1
    sofa_bilirubin.loc[(sofa_bilirubin['value'] >= 33) & (sofa_bilirubin['value'] < 102), 'sofa_liver_score'] = 2
    sofa_bilirubin.loc[(sofa_bilirubin['value'] >= 102) & (sofa_bilirubin['value'] < 204), 'sofa_liver_score'] = 3
    sofa_bilirubin.loc[(sofa_bilirubin['value'] >= 204), 'sofa_liver_score'] = 4

    return sofa_bilirubin.sort_values(by=['admissionid', 'itemid', 'time']).reset_index(drop=True)


def get_sofa_cardiovascular_map(con):
    """
    Returns SOFA Mean arterial pressure score
    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    print('Querying SOFA Cardiovascular: MAP...')
    filename = './sql/common/mean_abp.sql'
    sql_filename = os.path.join(dirname, filename)
    with open(sql_filename, 'r') as sql_file:
        sql_mean_abp = sql_file.read()
    mean_abp = read_sql(sql_mean_abp, con)

    print('Processing SOFA Cardiovascular: MAP...')
    # remove extreme outliers, most likely data entry errors or measurement errors
    mean_abp.loc[(mean_abp['value'] > 165), 'value'] = np.NaN
    mean_abp.loc[(mean_abp['value'] <= 30), 'value'] = np.NaN
    mean_abp = mean_abp.dropna()

    # use mean_abp 'cleansed' dataframe
    sofa_cardiovascular_map = mean_abp.groupby(['admissionid', 'itemid', 'item']).agg(
        lowest_mean_abp=pd.NamedAgg(column='value', aggfunc='min')
    ).reset_index()

    # calculate SOFA cardiovascular score:
    sofa_cardiovascular_map.loc[:, 'sofa_cardiovascular_score'] = 0
    # MAP < 70
    sofa_cardiovascular_map.loc[(sofa_cardiovascular_map['lowest_mean_abp'] < 70), 'sofa_cardiovascular_score'] = 1

    return sofa_cardiovascular_map.sort_values(by=['admissionid']).reset_index(drop=True)


def get_sofa_cns(con) -> pd.DataFrame:
    """
    Return SOFA Central nervous system score

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    # get Glasgow Coma Scale-score
    print('Querying SOFA Central nervous system...')
    filename = './sql/common/gcs.sql'
    sql_filename = os.path.join(dirname, filename)
    with open(sql_filename, 'r') as sql_file:
        sql_gcs = sql_file.read()
    sofa_cns = read_sql(sql_gcs, con)

    print('Processing SOFA Central nervous system...')
    # calculate SOFA Central nervous system score:
    # the SOFA score assumes that the GCS is either determined without sedation, or was known before sedation was
    # started. Elective patients while being sedated are considered having GCS=15 with respect to the SOFA CNS score.
    #
    # Medical staff were trained to document an 'estimated/expected' GCS for sedated/intubated patients at least for the
    # first 24 hours, so should be the most reliable with respect to SOFA scoring

    # If scores have been performed by medical staff remove all others
    admissionids = sofa_cns[sofa_cns['registeredby'] == 'ICV_Medisch Staflid']['admissionid']
    sofa_cns = sofa_cns.drop(sofa_cns[
                                 (sofa_cns['admissionid'].isin(admissionids)) &
                                 ~(sofa_cns['registeredby'] == 'ICV_Medisch Staflid')
                                 ].index
                             )

    admissionids = sofa_cns[sofa_cns['registeredby'] == 'ICV_Medisch']['admissionid']
    sofa_cns = sofa_cns.drop(sofa_cns[
                                 (sofa_cns['admissionid'].isin(admissionids)) &
                                 ~(sofa_cns['registeredby'] == 'ICV_Medisch')
                                 ].index
                             )

    # The most common problem for SOFA scoring is documenting GCS of 3 while patients being sedated
    # (e.g. directly after surgery or after intubation)
    # Drop records with gcs_score = 3 AND sedated
    sofa_cns = sofa_cns.drop(sofa_cns[
                                 (sofa_cns['gcs_score'] == 3) & ~(sofa_cns['sedatives_given'].isna()) &
                                 (sofa_cns['registeredby'].isin(['ICV_IC-Verpleegkundig', 'ICV_MC-Verpleegkundig']))
                                 ].index
                             )

    # For GCS going from e.g. E1M1V1 to E3M6V5 within 24 hours
    sofa_cns[sofa_cns['gcs_score'] == 15][['admissionid', 'measuredat']]
    first_gcs15 = sofa_cns[sofa_cns['gcs_score'] == 15].groupby('admissionid').agg(
        first_gcs15_measuredat=('measuredat', 'first'))
    sofa_cns = sofa_cns.merge(first_gcs15, on='admissionid')
    sofa_cns = sofa_cns.drop(sofa_cns[
                                 (sofa_cns['gcs_score'] == 3) &
                                 (sofa_cns['measuredat'] < sofa_cns['first_gcs15_measuredat'])
                                 ].index
                             )
    # the GCS verbal (V) score could be documented as 'Intubated' (v_score = 0 or -2), often considered similar
    # to a value of 1. However, this often does not reflect the actual level of consciousness, especially if the
    # eyes and motor score values are not '1' as well.
    # First remove all score that do not contain at least a valid eyes and motor score
    sofa_cns = sofa_cns.drop(sofa_cns[
                                 (sofa_cns['eyes_score'].isna()) |
                                 (sofa_cns['motor_score'].isna())
                                 ].index
                             )
    # assume E1M1 also has V1
    sofa_cns.loc[(sofa_cns['eyes_score'] == 1) & (sofa_cns['motor_score'] == 1), 'verbal_score'] = 1

    # remove intubated scores including scores with E4M6V1 and perform back/forward fill
    sofa_cns.loc[(sofa_cns['verbal_score'] == -2), 'verbal_score'] = np.NaN
    sofa_cns.loc[(sofa_cns['verbal_score'] == 0), 'verbal_score'] = np.NaN
    sofa_cns.loc[(sofa_cns['eyes_score'] == 4) & (sofa_cns['motor_score'] == 6) & (sofa_cns['verbal_score'] == 1),
                 'verbal_score'] = np.NaN

    # assume for missing verbal scores that future measurements should contain the actual value, otherwise
    # forward fill for still missing values
    sofa_cns['verbal_score'] = sofa_cns.groupby(['admissionid'])['verbal_score'].bfill()
    sofa_cns['verbal_score'] = sofa_cns.groupby(['admissionid'])['verbal_score'].ffill()

    # recalculate total GCS score
    sofa_cns['gcs_score'] = sofa_cns['eyes_score'] + sofa_cns['motor_score'] + sofa_cns['verbal_score']

    # calculate SOFA GCS score based on 'corrected' GCS scores:
    sofa_cns.loc[:, 'sofa_cns_score'] = 0
    sofa_cns.loc[(sofa_cns['gcs_score'] >= 13) & (sofa_cns['gcs_score'] < 15), 'sofa_cns_score'] = 1
    sofa_cns.loc[(sofa_cns['gcs_score'] >= 10) & (sofa_cns['gcs_score'] < 13), 'sofa_cns_score'] = 2
    sofa_cns.loc[(sofa_cns['gcs_score'] >= 6) & (sofa_cns['gcs_score'] < 10), 'sofa_cns_score'] = 3
    sofa_cns.loc[(sofa_cns['gcs_score'] < 6), 'sofa_cns_score'] = 4

    return sofa_cns.sort_values(by=['admissionid', 'time']).reset_index(drop=True)


def get_sofa_renal_daily_urine_output(con) -> pd.DataFrame:
    """
    Return SOFA Urine output score

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    # get urine output
    print('Querying SOFA Renal: urine output...')
    filename = './sql/common/urine_output.sql'
    sql_filename = os.path.join(dirname, filename)
    with open(sql_filename, 'r') as sql_file:
        sql_sofa_renal_urine_output = sql_file.read()
    sofa_renal_urine_output = read_sql(sql_sofa_renal_urine_output, con)

    print('Processing SOFA Renal: urine output...')
    # probably decimal error when entering volumes > 2500
    sofa_renal_urine_output.loc[(sofa_renal_urine_output['value'] > 2500), 'value'] = sofa_renal_urine_output[
                                                                                          'value'] / 10
    # remove extreme outliers, most likely data entry error)
    sofa_renal_urine_output.loc[(sofa_renal_urine_output['value'] > 4500), 'value'] = np.NaN
    sofa_renal_urine_output = sofa_renal_urine_output.dropna()

    # get urine output per 24 hours
    sofa_renal_daily_urine_output = sofa_renal_urine_output.groupby(['admissionid']).agg(
        daily_urine_output=pd.NamedAgg(column='value', aggfunc='sum')
    ).reset_index()

    # calculate SOFA renal score for urine output:
    sofa_renal_daily_urine_output.loc[:, 'sofa_renal_score'] = 0

    # urine output < 500 ml/day
    sofa_renal_daily_urine_output.loc[(
                                          ((sofa_renal_daily_urine_output['daily_urine_output'] < 500) &
                                           (sofa_renal_daily_urine_output['daily_urine_output'] > 200))
                                      ), 'sofa_renal_score'] = 3

    # urine output < 200 ml/day
    sofa_renal_daily_urine_output.loc[(
                                          ((sofa_renal_daily_urine_output['daily_urine_output'] < 200))
                                      ), 'sofa_renal_score'] = 4
    return sofa_renal_daily_urine_output.sort_values(by=['admissionid']).reset_index(drop=True)


def get_sofa_renal_creatinine(con) -> pd.DataFrame:
    print('Querying SOFA Renal: creatinine...')
    # get serum creatinine
    filename = './sql/common/creatinine_acute_kidney_injury_failure.sql'
    sql_filename = os.path.join(dirname, filename)
    with open(sql_filename, 'r') as sql_file:
        sql_creatinine = sql_file.read()
    creatinine = read_sql(sql_creatinine, con)

    print('Processing SOFA Renal: creatinine...')
    # remove extreme outliers, most likely data entry errors (manual_entry = True)
    creatinine.loc[(creatinine['value'] < 30) & (creatinine['manual_entry'] is True), 'value'] = np.NaN
    creatinine = creatinine.dropna(subset=['value'])

    # get highest creatinine per 24 hours
    # use creatinine 'cleansed' dataframe from APACHE score
    sofa_renal_creatinine = creatinine.groupby(['admissionid']).agg(
        max_creatinine=pd.NamedAgg(column='value', aggfunc='max')
    ).reset_index()

    # calculate SOFA renal score for creatinine:
    sofa_renal_creatinine.loc[:, 'sofa_renal_score'] = 0

    # creatinine 110-170 umol/l
    sofa_renal_creatinine.loc[(
                                  ((sofa_renal_creatinine['max_creatinine'] >= 110) &
                                   (sofa_renal_creatinine['max_creatinine'] < 171))
                              ), 'sofa_renal_score'] = 1

    # creatinine 171-299 umol/l
    sofa_renal_creatinine.loc[(
                                  ((sofa_renal_creatinine['max_creatinine'] >= 171) &
                                   (sofa_renal_creatinine['max_creatinine'] < 300))
                              ), 'sofa_renal_score'] = 2

    # creatinine 300-440 umol/l
    sofa_renal_creatinine.loc[(
                                  ((sofa_renal_creatinine['max_creatinine'] >= 300) &
                                   (sofa_renal_creatinine['max_creatinine'] <= 440))
                              ), 'sofa_renal_score'] = 3

    # creatinine >440 umol/l
    sofa_renal_creatinine.loc[(
                                  ((sofa_renal_creatinine['max_creatinine'] > 440))
                              ), 'sofa_renal_score'] = 4

    return sofa_renal_creatinine.sort_values(by=['admissionid']).reset_index(drop=True)


def get_sofa_admission(con) -> pd.DataFrame:
    """
    Returns a dataframe containing SOFA score in the first 24 hours of ICU admission for all patients.
    See the [SOFA](https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/concepts/severityscores/sofa.ipynb)
    notebook for additional information on data processing and example data and plots.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    print('Starting SOFA at admission...')

    # loads the admissions table for stratification on admission unit
    print('Querying admissions...')
    sql_admission = "SELECT * FROM admissions;"
    admissions = read_sql(sql_admission, con)

    # SOFA Respiration: PaO2 / FiO2 (mmHg)
    sofa_respiration = get_sofa_respiration(con)

    # SOFA: Coagulation - Platelets (x10^3/mm^3)
    sofa_platelets = get_sofa_platelets(con)

    # SOFA: Liver - Bilirubin (µmol/l)
    sofa_bilirubin = get_sofa_bilirubin(con)

    # SOFA: Cardiovascular - Hypotension
    # cardiovascular medication: vasopressors and / or inotropes
    sofa_cardiovascular_meds = get_sofa_cardiovascular_meds(con)

    # Mean arterial pressure
    sofa_cardiovascular_map = get_sofa_cardiovascular_map(con)

    # combine the scores from MAP and cardiovascular medication
    sofa_cardiovascular = pd.concat([sofa_cardiovascular_map, sofa_cardiovascular_meds], sort=False).sort_values(
        by='admissionid')

    # SOFA: Central nervous system
    sofa_cns = get_sofa_cns(con)

    # SOFA: Renal - Creatinine or urine output
    # get urine output
    sofa_renal_daily_urine_output = get_sofa_renal_daily_urine_output(con)

    # serum creatinine
    sofa_renal_creatinine = get_sofa_renal_creatinine(con)

    # combine the scores from creatinine and urine output
    sofa_renal = pd.concat([sofa_renal_creatinine, sofa_renal_daily_urine_output], sort=False).sort_values(
        by='admissionid')

    # SOFA Score
    ############
    print('Merging SOFA Scores...')
    # merge the scores
    sofa = admissions['admissionid']

    # max respiration score
    scores = sofa_respiration.groupby('admissionid')['sofa_respiration_score'].max().to_frame(
        'sofa_respiration_score').sort_values(by=['admissionid']).reset_index()
    sofa = pd.merge(sofa, scores, on='admissionid', how='left')

    # max coagulation score
    scores = sofa_platelets.groupby('admissionid')['sofa_coagulation_score'].max().to_frame(
        'sofa_coagulation_score').sort_values(by=['admissionid']).reset_index()
    sofa = pd.merge(sofa, scores, on='admissionid', how='left')

    # max liver score
    scores = sofa_bilirubin.groupby('admissionid')['sofa_liver_score'].max().to_frame(
        'sofa_liver_score').sort_values(by=['admissionid']).reset_index()
    sofa = pd.merge(sofa, scores, on='admissionid', how='left')

    # max cardiovascular score
    scores = sofa_cardiovascular.groupby('admissionid')['sofa_cardiovascular_score'].max().to_frame(
        'sofa_cardiovascular_score').sort_values(by=['admissionid']).reset_index()
    sofa = pd.merge(sofa, scores, on='admissionid', how='left')

    # max central nervous system score
    scores = sofa_cns.groupby('admissionid')['sofa_cns_score'].max().to_frame(
        'sofa_cns_score').sort_values(by=['admissionid']).reset_index()
    sofa = pd.merge(sofa, scores, on='admissionid', how='left')

    # max renal score
    scores = sofa_renal.groupby('admissionid')['sofa_renal_score'].max().to_frame(
        'sofa_renal_score').sort_values(by=['admissionid']).reset_index()
    sofa = pd.merge(sofa, scores, on='admissionid', how='left')

    # calculate total score (add al values in columns)
    total_scores = sofa.set_index('admissionid').sum(axis=1, skipna=True).to_frame('sofa_total_score')
    sofa = pd.merge(sofa, total_scores, on='admissionid', how='left')

    # Add location and urgency for easier selection:
    sofa = pd.merge(sofa, admissions[['admissionid', 'location', 'urgency']], on='admissionid', how='left')
    # To force new array with new dtype (instead of inplace setting) (FutureWarning),
    # changed `sofa.loc[:, 'urgency'] = pd.to_numeric(sofa.loc[:, 'urgency'])` to:
    admissions['urgency'] = pd.to_numeric(admissions.loc[:, 'urgency'])

    print('SOFA processing complete.')
    return sofa.sort_values(by=['admissionid']).reset_index(drop=True)
