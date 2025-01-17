# AmsterdamUMCdb Changelog

This changelog documents both the changes to the AmsterdamUMCdb *database* and the `amsterdamumcdb` Python *package* 
containing tools for working with the database. 

## [package/v0.3.1] - 2025-01-17
## Changed
- improved dictionary.csv generation
- re-added some missing functions for OMOP version
- added better documentation for OMOP tables
- moved changelog to separate CHANGELOG.md file
- updated requirements.txt

## [package/v0.3.0] - 2024-05-17

### Added
- Support for using AmsterdamUMCdb version 1.5.0 for the 6th ESICM Datathon 2024

### Changed
- The legacy AmsterdamUMCdb format can be used using the `legacy=true` flag in the package functions.
- The code for generating ICU scores and the sepsis cohort based on these scores is currently not implemented for version 1.5.0.

## [database/v1.5.0] - 2024-05-10

### Changed

- Changed the data model to the [OMOP Common Data Model](https://ohdsi.github.io/CommonDataModel/) version 5.4 using the 
[AMSTEL](https://github.com/AmsterdamUMC/AMSTEL) repository
- Improved mapping to standardized vocabularies to >95% coverage for both attributes and categorical values

### Security

- Minor quasi-identifiers, identified during mapping review, were removed from the dataset.


### Deprecated
- Support for the legacy versions (<= v1.0.2) will be dropped after release of AmsterdamUMCdb v2.0.0

## [package/v0.2.1] - 2022-11-22
### Added

- unified PostgreSQL and BigQuery processing
- Added unit tests for the cohorts. Forces `pd.Na` to be considered `False` during comparisons.

### Fixed

- Fixed filtering based boolean indexing using `np.NaN` (pandas default) and `pd.NA` (used by pandas-gbq since the default is `Int64`) leading to different results, particularly when finding the complement using negation.

### Changed

- By default, uses only validated data for `amsterdamumcdb` functions for consistent PostgreSQL and BigQuery results.
- Removed aggregation in SQL code of Glasgow Coma Scale (GCS) in line with other functions.
- Update SOFA GCS processing for more accurate scoring
- Added rounding to 1 decimal for conversions (from `kPa` to `mmHg`) in SQL statements
- Updated deprecated matplotlib style (`seaborn-darkgrid`)
- Update engine to SQLAlchemy for official pandas support instead of direct psycopg2 connection
- Moved code from Jupyter `reason_for_admission.ipynb` notebook into `amsterdamumcdb.cohorts` module.

## [package/v0.2.0] - 2022-11-02

### Added

- sample cohorts (sepsis-3, mechanical ventilation, shock) in `cohorts.py`
- SOFA scoring to `scores.py`
- util functions for PostgresSQL to BigQuery translation

### Changed 
- moved SQL code from notebooks to separate SQL files

## [package/v0.1.5] - 2022-04-27

### Added

- dictionary: as part of the `ICUnity` project in preparation for the [The Dutch ICU Data Warehouse](https://www.icudata.nl/index-en.html) a number of commonly used items have been  mapped to [LOINC](https://decor.nictiz.nl/art-decor/loinc), [SNOMED CT](https://decor.nictiz.nl/art-decor/snomed-ct) or [ATC](https://www.whocc.no/atc_ddd_index/) with data in the `vocabulary_id`, `vocabulary_concept_code`, `vocabulary_concept_name` columns. 
- dictionary: [UCUM](https://ucum.org/ucum.html) units added

## [package/v0.1.4] - 2021-04-23

### Fixed

- fixes binning in `outliers_histogram()` when all values < 1

## [package/v0.1.3] - 2021-05-23

### Changed
- Improves binning in `outliers_histogram()`

## [package/v0.1.2] - 2021-05-20

### Changed

- Allows negative dates in `get_fluidbalance()`

## [package/v0.1.1] - 2021-05-20

### Fixed

- Fixes Google BigQuery `Project must be a string` error.

## [package/v0.1.0] - 2021-04-23

Initial release for ESICM Datathon 2021

## [database/v1.0.2] - 2020-02-29

### Security

- Reduces re-identification risk by removing additional quasi-identifiers.

### Fixed/Changed

- `admissions`: Fixes incorrect labeling of ICU (`IC`) patients as MCU (`MC`) patient in the `location` column of
  the `admissions` table.
- `numericitems`: Fixes an error in temperature values due to a conversion error from degrees Fahrenheit to Celsius.

## [database/v1.0.1] - 2020-01-19

### Security

- Reduces re-identification risk for additional adversary attacks by outlier suppression based on presumed background
  knowledge.

### Fixed/Changed

- `admissions`: Uses the more common 'height' for tallness (human height or stature) instead of 'length' in the
  admissions table (columns: `heightgroup`, `heightsource`).


## [database/v1.0] - 2019-11-19

First publicly released version of AmsterdamUMCdb.