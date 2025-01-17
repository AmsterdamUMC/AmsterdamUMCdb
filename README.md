<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_c4i_square.png?raw=1" alt="Logo C4I" width=128px><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo AMDS" width=128px/>


# Welcome

AmsterdamUMCdb is the first freely accessible European intensive care database. It is endorsed by the European Society
of Intensive Care Medicine (ESICM) and its Data Science Section. It contains de-identified health data related to tens
of thousands of intensive care unit admissions, including demographics, vital signs, laboratory tests and medications.

# Version

The current version of AmsterdamUMCdb is 1.5.0, released in May 2024 in the 
[OMOP Common Data Model](https://ohdsi.github.io/CommonDataModel/) 
[version 5.4](https://ohdsi.github.io/CommonDataModel/cdm54.html) using the 
[AmsterdamUMC/AMSTEL](https://github.com/AmsterdamUMC/AMSTEL) repository. 
This version contains data related to 23,106 intensive care unit and high dependency unit admissions of adult patients 
from 2003-2016. The last legacy version was 1.0.2, released in March 2020. 
The first version of AmsterdamUMCdb (1.0) was released in November 2019.

# Requesting Access

The database, although de-identified, still contains detailed information regarding the clinical care of patients, so
must be treated with appropriate care and respect and cannot be shared without permission. To request access, go to
the [Amsterdam Medical Data Science](https://amsterdammedicaldatascience.nl/) website. 

After receiving access, it is recommended to open the tutorial on Google
Colab [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/bigquery/getting_started.ipynb)

# Acknowledgement

When using AmsterdamUMCdb in your research, please cite:

Thoral, P. J., Peppink, J. M., Driessen, R. H., Sijbrands, E. J. G., Kompanje, E. J. O., Kaplan, L., Bailey, H.,
Kesecioglu, J., Cecconi, M., Churpek, M., Clermont, G., van der Schaar, M., Ercole, A., Girbes, A. R. J., Elbers, P. W.
G., on behalf of the Amsterdam University Medical Centers Database (AmsterdamUMCdb) Collaborators and the SCCM/ESICM
Joint Data Science Task Force (2021). Sharing ICU Patient Data Responsibly Under the Society of Critical Care
Medicine/European Society of Intensive Care Medicine Joint Data Science Collaboration: The Amsterdam University Medical
Centers Database (AmsterdamUMCdb) Example. Crit Care Med. 2021 Jun 1;49(6):e563-e577.
doi: [10.1097/CCM.0000000000004916](https://doi.org/10.1097/CCM.0000000000004916). PMID: 33625129; PMCID: PMC8132908.

# Facts and Figures

The current database contains data from the clinical patient data management system of the department of Intensive Care,
a mixed medical-surgical ICU, from Amsterdam University Medical Center. The clinical data contains 23,106 admissions of
20,109 patients admitted from 2003 to 2016 with a total of almost 1.0 billion clinical observations consisting of
vitals, clinical scoring systems, device data and lab results data and nearly 5.0 million medication records.

<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/plot_admissions_year.png?raw=1" alt="Admissions per year category" height="512px"/>
<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/plot_admissions_age.png?raw=1" alt="Admission per age category" height="512px"/>


# Tables
In-depth descriptions of the tables can be found in the [OMOP Common Data Model](https://ohdsi.github.io/CommonDataModel/cdm54.html)
specification document. For a dictionary of items stored in the database, 
see the [*amsterdamumcdb*.get_dictionary()](#get_dictionary) function or the [dictionary.csv](./amsterdamumcdb/dictionary/dictionary.csv) file.

## Populated Tables
Since AmsterdamUMCdb currently only contains data related to the Intensive Care unit admission, not all tables of the 
Common Data Model have been populated with data. The following tables contain standardized data. 

### Standardized Clinical Data
The patient level data collected throughout the ICU stay.

| Table name                                                                                      | Description                                                                                                                                                                                                                                                                     |
|:------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [person](https://ohdsi.github.io/CommonDataModel/cdm54.html#person)                             | Patients admitted to the Intensive Care unit (ICU)                                                                                                                                                                                                                              |
| [visit_occurrence](https://ohdsi.github.io/CommonDataModel/cdm54.html#visit_occurrence)         | ICU admissions for each `person`                                                                                                                                                                                                                                                |
| [death](https://ohdsi.github.io/CommonDataModel/cdm54.html#death)                               | Death records of patients (`person`) admitted to the ICU. This may contains death records outside of the actual ICU admission or unrelated to the ICU admission                                                                                                                 |
| [condition_occurrence](https://ohdsi.github.io/CommonDataModel/cdm54.html#condition_occurrence) | Medical conditions, including primary or secondary admission diagnosis, and records based on events (e.g. atrial fibrillation)                                                                                                                                                  |
| [drug_exposure](https://ohdsi.github.io/CommonDataModel/cdm54.html#drug_exposure)               | Drugs administered during the ICU admission                                                                                                                                                                                                                                     |
| [procedure_occurrence](https://ohdsi.github.io/CommonDataModel/cdm54.html#procedure_occurrence) | Procedures performed before (e.g. surgery) or during the ICU admission                                                                                                                                                                                                          |
| [measurement](https://ohdsi.github.io/CommonDataModel/cdm54.html#measurement)                   | Measurements and clinical observations, including vital parameters, data from medical devices, lab results, outputs from drains and foley-catheters, scores etc. The `domain_id` of the `concept_id` determines (arbitrarily) whether a concept is a measurement or observation |
| [observation](https://ohdsi.github.io/CommonDataModel/cdm54.html#observation)                   | See: measurement, above                                                                                                                                                                                                                                                         |
| [device_exposure](https://ohdsi.github.io/CommonDataModel/cdm54.html#device_exposure)           | Exposure of patients to catheters, drains, tubes and other devices during the ICU stay.                                                                                                                                                                                         |
| [specimen](https://ohdsi.github.io/CommonDataModel/cdm54.html#specimen)                         | Allows identifying the source of the specimens drawn. Mainly useful for identifying arterial vs venous blood gas analysis samples.                                                                                                                                              |

### Standardized Health System
| Table name                                                                | Description                                                                                         |
|:--------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------|
| [location](https://ohdsi.github.io/CommonDataModel/cdm54.html#location)   | The location (coordinates and address) of Amsterdam UMC                                             |
| [care_site](https://ohdsi.github.io/CommonDataModel/cdm54.html#care_site) | Departments providing Intensive Care: Intensive Care unit and High Dependency unit ("Medium Care")  |
| [provider](https://ohdsi.github.io/CommonDataModel/cdm54.html#provider)   | Health care provider groups, medical specialties, or (laboratory) systems documenting clinical data |

### Standardized vocabularies
 The OHDSI Standardized vocabularies v5.0 29-FEB-24 were imported from [OHDSI ATHENA](https://athena.ohdsi.org/).

| Table name                                                                                        | Description                                                                                                                                                                                                                                                                                                                                                              |
|:--------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [concept](https://ohdsi.github.io/CommonDataModel/cdm54.html#concept)                             | Concepts that uniquely identify each fundamental unit of meaning used to express clinical information                                                                                                                                                                                                                                                                    |
| [vocabulary](https://ohdsi.github.io/CommonDataModel/cdm54.html#vocabulary)                       | Vocabularies integrated from various sources or created de novo in OMOP CDM                                                                                                                                                                                                                                                                                              |
| [domain](https://ohdsi.github.io/CommonDataModel/cdm54.html#vocabulary)                           | OMOP-defined Domains to which the Concepts of the Standardized Vocabularies can belong                                                                                                                                                                                                                                                                                   |
| [concept_class](https://ohdsi.github.io/CommonDataModel/cdm54.html#concept_class)                 | Semantic categories that reference the source structure of each Vocabulary                                                                                                                                                                                                                                                                                               |
| [concept_synonym](https://ohdsi.github.io/CommonDataModel/cdm54.html#concept_synonym)             | Alternate names and descriptions for Concepts.                                                                                                                                                                                                                                                                                                                           |
| [concept_relationship](https://ohdsi.github.io/CommonDataModel/cdm54.html#concept_relationship)   | Relationships between any two Concepts and the nature or type of the relationship.                                                                                                                                                                                                                                                                                       |
| [relationship](https://ohdsi.github.io/CommonDataModel/cdm54.html#relationship)                   | All types of relationships that can be used to associate any two concepts in the `concept_relationship`                                                                                                                                                                                                                                                                  |
| [concept_ancestor](https://ohdsi.github.io/CommonDataModel/cdm54.html#concept_ancestor)           | Provides hierarchical relationships between Concepts. This table is entirely derived from the `concept`, `concept_relationship` and `relationship` tables                                                                                                                                                                                                                |
| [drug_strength](https://ohdsi.github.io/CommonDataModel/cdm54.html#drug_strength)                 | Contains structured content about the amount or concentration and associated units of a specific ingredient contained within a particular drug product. Mainly used to determine administered dosed based on `quantity` field in `drug_exposure` table                                                                                                                   |
| [source_to_concept_map](https://ohdsi.github.io/CommonDataModel/cdm54.html#source_to_concept_map) | Used in the (Extract/Transform/Load) ETL processes to establish mappings for each source code into a Standard Concept. For end users, it is recommended to use the [dictionary](#get_dictionary). Detailed information on the ETL to convert AmsterdamUMCdb to the OMOP CDM can be found in the [AmsterdamUMC/AMSTEL](https://github.com/AmsterdamUMC/AMSTEL) repository |

### Standardized derived elements
| Table name                                                                        | Description                                                                                                         |
|:----------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------|
| [condition_era](https://ohdsi.github.io/CommonDataModel/cdm54.html#condition_era) | A Condition Era is defined as a span of time when the Person is assumed to have a given condition.                  |
| [drug_era](https://ohdsi.github.io/CommonDataModel/cdm54.html#drug_era)           | A Drug Era is defined as a span of time when the Person is assumed to be exposed to a particular active ingredient. |

### Standardized Meta Data
| Table name                                                                  | Description                                                        |
|:----------------------------------------------------------------------------|:-------------------------------------------------------------------|
| [cdm_source](https://ohdsi.github.io/CommonDataModel/cdm54.html#cdm_source) | Details about the original (legacy) source AmsterdamUMCdb database |

## Legacy tables (version <= 1.0.2)

The table and field definitions from the legacy table are available from
the [AmsterdamUMCdb wiki](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki) and from Jupyter Notebooks in
the [tables](tables/) folder.

|Table name|Description|
|:---|:---|
|[admissions](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/admissions)|admissions and demographic data of the patients admitted to the ICU or MCU|
|[drugitems](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/drugitems)|medication orders including fluids, (parenteral) feeding and blood transfusions during the stay on the ICU|
|[freetextitems](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/freetextitems)|observations, including laboratory results, that are based on non-numeric (text) data|
|[listitems](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/listitems)|categorial observations, e.g. based on a selection from a list, like type of heart rhytm, ventilatory mode, etc.|
|[numericitems](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/numericitems)| numerical measurements and observations, including vital parameters, data from medical devices, lab results, outputs from drains and foley-catheters, scores etc.|
|[procedureorderitems](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/procedureorderitems)|procedures and tasks, such as performing a chest X-ray, drawing blood and daily ICU nursing care and scoring|
|[processitems](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/processitems)|catheters, drains, tubes, and continous non-medication processes (e.g. renal replacement therapy, hypothermia induction, etc.)|

# amsterdamumcdb Python package

The `amsterdamumcdb` Python package contains common functions for working with the database.

## Available functions

### <a name="get_dictionary"></a>*amsterdamumcdb*.get_dictionary(legacy=False):

Gets a dictionary of all items in AmsterdamUMCdb with translated medical concepts mapped to 
[OHDSI Standardized Vocabularies](https://github.com/OHDSI/Vocabulary-v5.0/wiki) 
including LOINC, SNOMED CT and RxNorm.

- Arguments:
  - legacy -- Loads the legacy  version of the dictionary for AmsterdamUMCdb version 1.0.2 or earlier. Default: False.


- Returns:
    - dataframe containing dictionary

### *amsterdamumcdb*.get_fluidbalance(admissionid, from_date, to_date, con):

Calculate the fluid balance (i.e. fluid input - fluid output) for a specific time interval. Typically this will be used
to calculate daily fluid balances.

+ Arguments:
    + admissionid -- the admissionid of ICU admission
    + from_date -- the start of the interval, expressed as the number of milliseconds from start of this ICU admission
    + to_date -- the end of the interval, expressed as the number of milliseconds from start of this ICU admission
    + con -- psycopg2 connection or pandas-gbq Google BigQuery config

### *amsterdamumcdb*.outliers_histogram(data, z_threshold=4.0, lower=None, upper=None, bins=None, binwidth=None, maxbins=None):

Return a pyplot histogram, where the upper and/or lower outliers are binned together for a more even distribution plot.
By default, the histogram will be created with bins that are on boundaries aligned with the pyplot axis ticks.

+ Arguments:
    + data -- dataframe to create the histogram for.
    + z_threshold (Optional) -- number of standard deviations from the median to determine outliers
    + lower (Optional) -- lower threshold for binning lower outliers together
    + upper (Optional) -- upper threshold for binning higher outliers together
    + bins (Optional) -- int or sequence or str, allows specifying the number of bins, the actual bins or a binning
      strategy
      (see: https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.hist.html)
    + binwidth (Optional) -- forces a specified size of the equally sized bins between the lower and upper threshold
    + maxbins -- the maximum number of equally sized bins to create

