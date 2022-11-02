import pandas as pd
import os
import re
from .scores import get_sofa_admission, get_sofa_cardiovascular_meds
from .util import read_sql, query

# surgical regular expressions
re_cardiosurg = r'(CABG|AVR|hartchirurgie|heart surgery|Chron. cardiovasculaire ziekte|hartkleppen' + \
                r'|cardiovascula|MVP|MVR|mitral|tricuspid|pericard|aortic.*valve|lobectom|segment|thorax|Bentall' \
                r'|aorta-ascendens|aorta-boog' + \
                r'|aorta-wortel|aorta-descendens|lung|pneumectomie|bullectom|respiratoir ' \
                r'neoplasm|thoracoscop|thoracotom(y|ie)|respirato' + \
                r'|vrije wand ruptuur|VSR|ASD|pleurectom|intracardiac|aneurysmectom|congenital defect repair)(?! for ' \
                r'esophag) '
re_neurosurg = r'neuro|tentorieel|cranial|subdur|epidur|subarachn|intracerbr|hoofdtrauma|SAB|S.A.H.|CNS|Hoofd|' \
               r'seizures' + \
               r'|craniotom|cranioplast|spinal|dwarslaesie|ventriculstom|transphenoidal|brain|A.V.M.|Arteriovenous ' \
               r'malformation' + \
               r'|brughoek|shunts and revisions|stereotactic|Burr hole|cerebrospinal'
re_vascsurg = r'vaatchirurgie|vasc.*surg|EVAR|aorta vervanging|perifeer vasc|embolectom|aneurysm|carotid|endovasc' + \
              r'|dissectie|endarterectom|thrombectomy|dilatation|PTCA|all other ' \
              r'bypass|femoral-popliteal|aorto-femoral|femoral-femoral' + \
              r'|transplantectom'
re_gisurg = r'oesophagus|esophageal|maag|stomach|darm|intestin|gastro-intestin|pancreatitis|laparotom|gastro' \
            r'-intestinale perforatie' + \
            r'|galblaas|Bleeding-.*GI|other GI|colon|rectal|GI.*surgery|GI ' \
            r'obstruction|Whipple|diverticular|appendectomy' + \
            r'|peritonitis|cholecystectomy|exenteration'
re_uro = r'(?<!ne)(urolog|cystectomy|genitourinary surgery|prostatectom|ileal\-conduit|orchiectomy|bladder repair' + \
         r'|nefrectom|nephrectom|renaal neopsplama)'
re_obgyn = r'hysterectom|Cesarean|ectopic pregnancy'
re_gensurg = r'mond/keel|cancer oral|cancer laryngeal|spondylodes|Fusion-spinal|devices for spine|orthopedic' + \
             r'|renaal|metabol|endocrin|thyroid|hip replacement|knee ' \
             r'replacement|adrenalectom|tracheostomy|bewaking|amputation|apnea-sleep' + \
             r'|lymph node dissection|mastectomy|cosmetic|fracture-pathological|bewaking'
re_trauma_surg = r'(?<!non-)(?<!see )(trauma|hypotherm|smoke inhalation)(?!, see trauma)(?! see)(?!: see)'
re_tx_surg = r'niertransplantatie|kidney transplant|renaal transplantatie|pancreastransplantatie'

re_respfailure_surg = r'resp.*insuff|na respiratoir arrest|arrest, respiratory|atelectas|pneumoni|na ok'

re_sepsis_surg = r'sepsis|pneumoni|GI perforation|perforation/rupture|infection|abscess|GI Vascular ' \
                 r'ischemia|diverticular|appendectomy|peritonitis '
re_cardiacarrest_surg = r'Cardiac arrest.*respiratory arrest|na reanimatie'
re_hepa = r'lever'
re_surg_other = r'diagnose anders|respiratoir|cardiovasculair|niet operatief'

re_surgical_medical = r'Bloeding tractus digestivus|Haemorragische shock|Gastro-intestinale bloeding|' \
                      r'Bleeding, upper GI' + \
                      r'|hematologisch|Hematologische maligniteit|Haematologisch|Renaal'

re_surgical = '(' + \
              re_cardiosurg + '|' + \
              re_neurosurg + '|' + \
              re_vascsurg + '|' + \
              re_gisurg + '|' + \
              re_uro + '|' + \
              re_obgyn + '|' + \
              re_gensurg + '|' + \
              re_trauma_surg + '|' + \
              re_tx_surg + '|' + \
              re_hepa + '|' + \
              re_surg_other + '|' + \
              re_surgical_medical + '|' + \
              re_respfailure_surg + '|' + \
              re_sepsis_surg + '|' + \
              re_cardiacarrest_surg + '|' + \
              ')'

# medical
re_respfailure_med = r'(?<! without )(resp.*insuff|pneumoni|respirato|luchtweg obstructie|obstruction-airway' + \
                     r'|chronisch obstructieve longziekte|emphysema|asthma|aspiratie|aspiration|longembolie|pulmonary' \
                     r'|pulmonaire' + \
                     r'|long|lung|atelectas|ALI|ARDS|pleural|cancer, lung|pneumothorax|verdrinking|near ' \
                     r'drowning|weaning|hemothorax|PCP) '
re_cardiacarrest_med = r'Cardiac arrest.*respiratory arrest|na reanimatie'
re_sepsis_med = r'sepsis|septic|infect|pneumoni|cholangitis|pancr|endocarditis|meningitis|GI ' \
                r'perforation|abces|abscess|darm ischaemie|GI vascular|fasciitis' + \
                r'|inflammatory|peritonitis'
re_cardio = r'cardiogene shock|shock, cardiogenic|angina|ritme|rhythm|cardiovascular|cardiovasculair' + \
            r'|myocardial|endocarditis|coronair|coronary|cardiomyopath|tamponade|pericardial|papillary ' \
            r'muscle|^MI|hartkleppen' + \
            r'|CHF|hart falen|decompensatio cordis'
re_neuro = '(?<!see )(insult|seizure|CVA|observatie neurologische status|intracerebraal ' \
           'haematoom|intracranial|intracerebr|subdur|subarachno' + \
           r'|epidur|coma|neurologisch|neurologic|CZS|S\.A\.B\.|neurologie|hoofdtrauma|head|neuro|muscula|spinal' \
           r'|meningitis|encephalitis' + \
           r'|myasthenia|vaatspasme protocol|Guillian-Barre|encephalopath|musculoskeletal)(?!-see Neurological System)'
re_bleeding = r'bloeding tractus digestivus|gastro-intestinale bloeding|gastro-intestinaal|bleeding, ' \
              r'upper GI|bleeding, lower GI' + \
              r'|bleeding, GI|ulcer'
re_gi_med = r'ileus|GI medical|GI obstruction'
re_tox = r'intox|overdosis|overdose|toxicity|withdrawal|drug'
re_trauma_med = r'(?<!non-)(?<!see )(trauma|hypotherm|smoke inhalation)(?!, see trauma)(?! see)(?!: see)'
re_hemonc = r'malign|hematolog|cancer|bloeding|TTP|HUS|leukemi|pancytopen|coagulopath|anemia|neutropen|lymph|sickle'
re_endo_med = r'metabolisme|keto-acidose|diabetic|metabolic|endocrine|hypertens|acid-base|hypoglyc|thyroid'
re_shock_med = r'hypovolemische shock|shock|haemorr|hemorrha|anaphylaxis'
re_nefro_med = r'renaal|renal|tubulus|genitourinary|urolog|nefr'
re_hepa_med = r'lever|hepatic'
re_obgyn_med = r'obstetrie|postpartum|eclampsia'
re_vasc_med = r'aneurysm|vascular|cardiovascular medical|Thrombus,arterial|vascular medical|dissect|EVAR|embolectom'
re_mon_med = r'apnea, sleep|monitoring|bewaking|observatie'
re_tx_med = r'transplant'

re_medical = '(' + \
             re_respfailure_med + '|' + \
             re_cardiacarrest_med + '|' + \
             re_sepsis_med + '|' + \
             re_cardio + '|' + \
             re_neuro + '|' + \
             re_bleeding + '|' + \
             re_gi_med + '|' + \
             re_tox + '|' + \
             re_trauma_med + '|' + \
             re_hemonc + '|' + \
             re_endo_med + '|' + \
             re_shock_med + '|' + \
             re_nefro_med + '|' + \
             re_hepa_med + '|' + \
             re_obgyn_med + '|' + \
             re_vasc_med + '|' + \
             re_mon_med + '|' + \
             re_tx_med + '|' + \
             ')'


def get_surgical_patients(con) -> pd.DataFrame:
    """Returns a dataframe containing patients with a surgical reason for admission.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    combined_diagnoses = get_reason_for_admission(con)
    return combined_diagnoses[combined_diagnoses['surgical'] == 1]


def get_cardiothoracic_surgery_patients(con) -> pd.DataFrame:
    combined_diagnoses = get_reason_for_admission(con)
    return combined_diagnoses[
        (combined_diagnoses['surgical'] == 1)
        & (combined_diagnoses['diagnosis'].str.contains(re_cardiosurg, na=False, flags=re.IGNORECASE))]


def get_medical_patients(con) -> pd.DataFrame:
    """Returns a dataframe containing patients with a medical reason for admission.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    combined_diagnoses = get_reason_for_admission(con)
    return combined_diagnoses[combined_diagnoses['surgical'] == 0]


def get_respiratory_failure_patients(con) -> pd.DataFrame:
    """Returns a dataframe containing patients with respiratory failure as the primary reason for admission. Please
    note that many patients that suffer from (septic) shock will require mechanical ventilation often due to secondary
    respiratory failure (e.g. due to acute respiratory distress syndrome)

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    combined_diagnoses = get_reason_for_admission(con)
    return combined_diagnoses[combined_diagnoses['surgical'] == 0]


def get_sepsis_patients(con) -> pd.DataFrame:
    """Returns a dataframe containing patients with a diagnosis of sepsis at admission.

    The [Sepsis-3 definition](https://jamanetwork-com.vu-nl.idm.oclc.org/journals/jama/fullarticle/2492881)
    requires, in addition to a presumed infection, a Sequential [Sepsis-related] Organ Failure Assessment
    (SOFA) score of 2 points or more.

    Operationalization:
    * presumed infection (with dysregulated host response), based on:
    - sepsis_at_admission flagged in the admission form by the attending physician
    - the admission diagnosis, medical or surgical, is considered a severe infection, e.g., gastro-intestinal
    perforation, cholangitis, meningitis
    - use of antibiotics that are not used prophylactically after surgery
    - use of antibiotics and cultures drawn within 6 hours of admission

    AND

    * organ dysfunction based on change in total SOFA score ≥2 points
    - baseline SOFA score assumed to be 0
    - uses data from first 24 hours of ICU admission

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    print('Creating cohort Sepsis-3 at admission (infection and SOFA score ≥2)...')
    print('Querying reason for admission...')
    combined_diagnoses = get_reason_for_admission(con)
    print('Selecting patients with presumed infection...')
    infection = combined_diagnoses[
        (
                (
                    # use reasons for admission
                    # surgical admissions with sepsis
                    (combined_diagnoses['surgical'] == 1)
                    & (combined_diagnoses['diagnosis'].str.contains(re_sepsis_surg, na=False, flags=re.IGNORECASE))
                ) | (
                    # medical admissions with sepsis
                    (combined_diagnoses['surgical'] == 0)
                    & (combined_diagnoses['diagnosis'].str.contains(re_sepsis_med, na=False, flags=re.IGNORECASE))
                ) | (
                    # uses documentation at admission form (Early Goal Directed Therapy)
                    (combined_diagnoses['sepsis_at_admission'] == 1)
                ) | (
                    # uses administered (therapeutic) antibiotics for determining sepsis
                    (combined_diagnoses['sepsis_antibiotics_bool'] == 1)
                ) | (
                    # uses combination of administered antibiotics (that sometimes are used as prophylaxis) AND
                    # drawn cultures for determining sepsis
                    (combined_diagnoses['other_antibiotics_bool'] == 1)
                    & (combined_diagnoses['sepsis_cultures_bool'] == 1)
                )
        ) & ~(combined_diagnoses['sepsis_at_admission'] == 0)
        # exclude all diagnoses where explicitly 'no sepsis' was documented
        ]

    print('Selecting patients based on SOFA total score SOFA ≥2')
    sofa = get_sofa_admission(con)
    infection = pd.merge(infection, sofa[
        ['admissionid', 'sofa_respiration_score', 'sofa_coagulation_score',
         'sofa_liver_score', 'sofa_cardiovascular_score', 'sofa_cns_score',
         'sofa_renal_score', 'sofa_total_score']], on='admissionid', how='left')

    sepsis = infection[infection['sofa_total_score'] >= 2]
    return sepsis


def get_shock_patients(con) -> pd.DataFrame:
    """Returns a dataframe containing all patients that present with or develop shock within 24 hours of admission.
    Definition:
    - Vasopressor or inotrope administered, AND
    - Lactate >= 2.0 mmol/l

        Arguments:
            con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    print('Creating cohort shock at admission/first 24 hours (vasopressors/inotropes administered '
          'and lactate ≥2 mmol/l)...')
    print('Querying reason for admission...')
    combined_diagnoses = get_reason_for_admission(con)

    # re-use SOFA cardiovascular score for vasopressors and/or inotropes
    sofa_cardiovascular_meds = get_sofa_cardiovascular_meds(con)
    lactate = query('common/lactate.sql', con)

    # max cardiovascular score based on vasopressors and inotropes
    max_cardiovascular_score = sofa_cardiovascular_meds.groupby('admissionid')['sofa_cardiovascular_score'].max().to_frame(
        'sofa_cardiovascular_score').sort_values(by=['admissionid']).reset_index()
    shock = pd.merge(combined_diagnoses, max_cardiovascular_score, on='admissionid', how='left')

    # max lactate
    lactate_max = lactate.groupby('admissionid')['value'].max().to_frame(
        'lactate').sort_values(by=['admissionid']).reset_index()
    shock = pd.merge(shock, lactate_max, on='admissionid', how='left')

    # only keep patients with vasopressors and/or inotrope support (2 or higher), AND with lactate > 2.0 mmol/l
    print('Selecting patients with vasopressors and/or inotrope support (SOFA cardiovascular score 2 or higher), '
          'AND with lactate >= 2.0 mmol/l...')
    shock = shock[(shock['sofa_cardiovascular_score'] >= 2) & (shock['lactate'] >= 2.0)]
    return shock

def get_invasive_ventilation_patients(con) -> pd.DataFrame:
    """Returns a dataframe containing all patients that were mechanically ventilated using an invasive mode.
    Definition:
    - Mechanical ventilation mode compatible with invasive ventilation.

        Arguments:
            con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """
    print('Creating cohort invasive mechanical ventilation during ICU admission...')
    print('Querying reason for admission...')
    combined_diagnoses = get_reason_for_admission(con)

    # use mechanical ventilation query
    print('Querying mechanical ventilation (including possible non-invasive ventilation)...')
    ventilation = query('lifesupport/mechanical_ventilation.sql', con)

    # merge dataframes
    ventilation = pd.merge(combined_diagnoses, ventilation, on='admissionid', how='left')

    print('Selecting patients with invasive ventilation...')
    ventilation = ventilation[ventilation['invasive_bool'].fillna(False)]

    return ventilation


def get_reason_for_admission(con) -> pd.DataFrame:
    """Returns a dataframe containing all patients with reasons for admission.

    Arguments:
        con -- psycopg2 connection or pandas-gbq Google BigQuery config
    """

    # gets the SQL source file
    dirname = os.path.dirname(os.path.abspath(__file__))
    filename = './sql/diagnosis/reason_for_admission.sql'
    sql_filename = os.path.join(dirname, filename)

    with open(sql_filename, 'r') as file:
        sql = file.read()
    result = read_sql(sql, con)

    return result
