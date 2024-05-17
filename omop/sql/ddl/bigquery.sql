--BigQuery CDM DDL Specification for OMOP Common Data Model 5.4

CREATE TABLE IF NOT EXISTS person
(
    person_id                   INT64 NOT NULL,
    gender_concept_id           INT64 NOT NULL,
    year_of_birth               INT64 NOT NULL,
    month_of_birth              INT64,
    day_of_birth                INT64,
    birth_datetime              TIMESTAMP,
    race_concept_id             INT64 NOT NULL,
    ethnicity_concept_id        INT64 NOT NULL,
    location_id                 INT64,
    provider_id                 INT64,
    care_site_id                INT64,
    person_source_value         STRING,
    gender_source_value         STRING,
    gender_source_concept_id    INT64,
    race_source_value           STRING,
    race_source_concept_id      INT64,
    ethnicity_source_value      STRING,
    ethnicity_source_concept_id INT64
);

CREATE TABLE IF NOT EXISTS observation_period
(
    observation_period_id         INT64 NOT NULL,
    person_id                     INT64 NOT NULL,
    observation_period_start_date DATE  NOT NULL,
    observation_period_end_date   DATE  NOT NULL,
    period_type_concept_id        INT64 NOT NULL
);

CREATE TABLE IF NOT EXISTS visit_occurrence
(
    visit_occurrence_id           INT64 NOT NULL,
    person_id                     INT64 NOT NULL,
    visit_concept_id              INT64 NOT NULL,
    visit_start_date              DATE  NOT NULL,
    visit_start_datetime          TIMESTAMP,
    visit_end_date                DATE  NOT NULL,
    visit_end_datetime            TIMESTAMP,
    visit_type_concept_id         INT64 NOT NULL,
    provider_id                   INT64,
    care_site_id                  INT64,
    visit_source_value            STRING,
    visit_source_concept_id       INT64,
    admitted_from_concept_id      INT64,
    admitted_from_source_value    STRING,
    discharged_to_concept_id      INT64,
    discharged_to_source_value    STRING,
    preceding_visit_occurrence_id INT64
);

CREATE TABLE IF NOT EXISTS visit_detail
(
    visit_detail_id                INT64 NOT NULL,
    person_id                      INT64 NOT NULL,
    visit_detail_concept_id        INT64 NOT NULL,
    visit_detail_start_date        DATE  NOT NULL,
    visit_detail_start_datetime    TIMESTAMP,
    visit_detail_end_date          DATE  NOT NULL,
    visit_detail_end_datetime      TIMESTAMP,
    visit_detail_type_concept_id   INT64 NOT NULL,
    provider_id                    INT64,
    care_site_id                   INT64,
    visit_detail_source_value      STRING,
    visit_detail_source_concept_id INT64,
    admitted_from_concept_id       INT64,
    admitted_from_source_value     STRING,
    discharged_to_source_value     STRING,
    discharged_to_concept_id       INT64,
    preceding_visit_detail_id      INT64,
    parent_visit_detail_id         INT64,
    visit_occurrence_id            INT64 NOT NULL
);

CREATE TABLE IF NOT EXISTS condition_occurrence
(
    condition_occurrence_id       INT64 NOT NULL,
    person_id                     INT64 NOT NULL,
    condition_concept_id          INT64 NOT NULL,
    condition_start_date          DATE  NOT NULL,
    condition_start_datetime      TIMESTAMP,
    condition_end_date            DATE,
    condition_end_datetime        TIMESTAMP,
    condition_type_concept_id     INT64 NOT NULL,
    condition_status_concept_id   INT64,
    stop_reason                   STRING,
    provider_id                   INT64,
    visit_occurrence_id           INT64,
    visit_detail_id               INT64,
    condition_source_value        STRING,
    condition_source_concept_id   INT64,
    condition_status_source_value STRING
)
     -- Create two partitions based on condition_status_concept_id: Currently, the reason for admission is determined by
     -- a value in the condition_status_concept_id. All other conditions lack these values.
     -- The value 65535 is an arbitrarily high number.
    PARTITION BY
        RANGE_BUCKET(
              condition_status_concept_id, GENERATE_ARRAY(0, 65535, 65535)
        )
    CLUSTER BY
        condition_concept_id, person_id, condition_start_datetime;

CREATE TABLE IF NOT EXISTS drug_exposure
(
    drug_exposure_id             INT64 NOT NULL,
    person_id                    INT64 NOT NULL,
    drug_concept_id              INT64 NOT NULL,
    drug_exposure_start_date     DATE  NOT NULL,
    drug_exposure_start_datetime TIMESTAMP,
    drug_exposure_end_date       DATE  NOT NULL,
    drug_exposure_end_datetime   TIMESTAMP,
    verbatim_end_date            DATE,
    drug_type_concept_id         INT64 NOT NULL,
    stop_reason                  STRING,
    refills                      INT64,
    quantity                     BIGNUMERIC,
    days_supply                  INT64,
    sig                          STRING,
    route_concept_id             INT64,
    lot_number                   STRING,
    provider_id                  INT64,
    visit_occurrence_id          INT64,
    visit_detail_id              INT64,
    drug_source_value            STRING,
    drug_source_concept_id       INT64,
    route_source_value           STRING,
    dose_unit_source_value       STRING
)
    CLUSTER BY
        drug_concept_id, person_id, drug_exposure_start_datetime;

CREATE TABLE IF NOT EXISTS procedure_occurrence
(
    procedure_occurrence_id     INT64 NOT NULL,
    person_id                   INT64 NOT NULL,
    procedure_concept_id        INT64 NOT NULL,
    procedure_date              DATE  NOT NULL,
    procedure_datetime          TIMESTAMP,
    procedure_end_date          DATE,
    procedure_end_datetime      TIMESTAMP,
    procedure_type_concept_id   INT64 NOT NULL,
    modifier_concept_id         INT64,
    quantity                    INT64,
    provider_id                 INT64,
    visit_occurrence_id         INT64,
    visit_detail_id             INT64,
    procedure_source_value      STRING,
    procedure_source_concept_id INT64,
    modifier_source_value       STRING
)
    -- Create two partitions based on provider_id: one with and all other values. The records with
    -- provider_id IS are unvalidated device data. The value 255 is an arbitrarily high number.
    PARTITION BY
        RANGE_BUCKET(
              provider_id, GENERATE_ARRAY(0, 255, 255)
        )
    CLUSTER BY
        procedure_concept_id, person_id, procedure_datetime

    -- Forces the user the specify a WHERE clause on provider_id;
    OPTIONS (require_partition_filter = TRUE);

CREATE TABLE IF NOT EXISTS device_exposure
(
    device_exposure_id             INT64 NOT NULL,
    person_id                      INT64 NOT NULL,
    device_concept_id              INT64 NOT NULL,
    device_exposure_start_date     DATE  NOT NULL,
    device_exposure_start_datetime TIMESTAMP,
    device_exposure_end_date       DATE,
    device_exposure_end_datetime   TIMESTAMP,
    device_type_concept_id         INT64 NOT NULL,
    unique_device_id               STRING,
    production_id                  STRING,
    quantity                       INT64,
    provider_id                    INT64,
    visit_occurrence_id            INT64,
    visit_detail_id                INT64,
    device_source_value            STRING,
    device_source_concept_id       INT64,
    unit_concept_id                INT64,
    unit_source_value              STRING,
    unit_source_concept_id         INT64
)
    CLUSTER BY
        device_concept_id, person_id, device_exposure_start_datetime;

CREATE TABLE IF NOT EXISTS measurement
(
    measurement_id                INT64 NOT NULL,
    person_id                     INT64 NOT NULL,
    measurement_concept_id        INT64 NOT NULL,
    measurement_date              DATE  NOT NULL,
    measurement_datetime          TIMESTAMP,
    measurement_time              STRING,
    measurement_type_concept_id   INT64 NOT NULL,
    operator_concept_id           INT64,
    value_as_number               BIGNUMERIC,
    value_as_concept_id           INT64,
    unit_concept_id               INT64,
    range_low                     BIGNUMERIC,
    range_high                    BIGNUMERIC,
    provider_id                   INT64,
    visit_occurrence_id           INT64,
    visit_detail_id               INT64,
    measurement_source_value      STRING,
    measurement_source_concept_id INT64,
    unit_source_value             STRING,
    unit_source_concept_id        INT64,
    value_source_value            STRING,
    measurement_event_id          INT64,
    meas_event_field_concept_id   INT64
)
    -- Create two partitions based on provider_id: one with and all other values. The records with
    -- provider_id IS are unvalidated device data. The value 255 is an arbitrarily high number.
    PARTITION BY
        RANGE_BUCKET(
              provider_id, GENERATE_ARRAY(0, 255, 255)
        )
    CLUSTER BY
        measurement_concept_id, person_id, measurement_datetime

    -- Forces the user the specify a WHERE clause on provider_id;
    OPTIONS (require_partition_filter = TRUE);

CREATE TABLE IF NOT EXISTS observation
(
    observation_id                INT64 NOT NULL,
    person_id                     INT64 NOT NULL,
    observation_concept_id        INT64 NOT NULL,
    observation_date              DATE  NOT NULL,
    observation_datetime          TIMESTAMP,
    observation_type_concept_id   INT64 NOT NULL,
    value_as_number               BIGNUMERIC,
    value_as_string               STRING,
    value_as_concept_id           INT64,
    qualifier_concept_id          INT64,
    unit_concept_id               INT64,
    provider_id                   INT64,
    visit_occurrence_id           INT64,
    visit_detail_id               INT64,
    observation_source_value      STRING,
    observation_source_concept_id INT64,
    unit_source_value             STRING,
    qualifier_source_value        STRING,
    value_source_value            STRING,
    observation_event_id          INT64,
    obs_event_field_concept_id    INT64

)
    -- Create two partitions based on provider_id: one with and all other values. The records with
    -- provider_id IS are unvalidated device data. The value 255 is an arbitrarily high number.
    PARTITION BY
        RANGE_BUCKET(
              provider_id, GENERATE_ARRAY(0, 255, 255)
        )
    CLUSTER BY
        observation_concept_id, person_id, observation_datetime

    -- Forces the user the specify a WHERE clause on provider_id;
    OPTIONS (require_partition_filter = TRUE);

CREATE TABLE IF NOT EXISTS death
(
    person_id               INT64 NOT NULL,
    death_date              DATE  NOT NULL,
    death_datetime          TIMESTAMP,
    death_type_concept_id   INT64,
    cause_concept_id        INT64,
    cause_source_value      STRING,
    cause_source_concept_id INT64
);


CREATE TABLE IF NOT EXISTS note
(
    note_id                     INT64  NOT NULL,
    person_id                   INT64  NOT NULL,
    note_date                   DATE   NOT NULL,
    note_datetime               TIMESTAMP,
    note_type_concept_id        INT64  NOT NULL,
    note_class_concept_id       INT64  NOT NULL,
    note_title                  STRING,
    note_STRING                 STRING NOT NULL,
    encoding_concept_id         INT64  NOT NULL,
    language_concept_id         INT64  NOT NULL,
    provider_id                 INT64,
    visit_occurrence_id         INT64,
    visit_detail_id             INT64,
    note_source_value           STRING,
    note_event_id               INT64,
    note_event_field_concept_id INT64
);

CREATE TABLE IF NOT EXISTS note_nlp
(
    note_nlp_id                INT64  NOT NULL,
    note_id                    INT64  NOT NULL,
    section_concept_id         INT64,
    snippet                    STRING,
    offset                     STRING,
    lexical_variant            STRING NOT NULL,
    note_nlp_concept_id        INT64,
    note_nlp_source_concept_id INT64,
    nlp_system                 STRING,
    nlp_date                   DATE   NOT NULL,
    nlp_datetime               TIMESTAMP,
    term_exists                STRING,
    term_temporal              STRING,
    term_modifiers             STRING
);

CREATE TABLE IF NOT EXISTS specimen
(
    specimen_id                 INT64 NOT NULL,
    person_id                   INT64 NOT NULL,
    specimen_concept_id         INT64 NOT NULL,
    specimen_type_concept_id    INT64 NOT NULL,
    specimen_date               DATE  NOT NULL,
    specimen_datetime           TIMESTAMP,
    quantity                    BIGNUMERIC,
    unit_concept_id             INT64,
    anatomic_site_concept_id    INT64,
    disease_status_concept_id   INT64,
    specimen_source_id          STRING,
    specimen_source_value       STRING,
    unit_source_value           STRING,
    anatomic_site_source_value  STRING,
    disease_status_source_value STRING
)
    CLUSTER BY
        specimen_concept_id, person_id;

CREATE TABLE IF NOT EXISTS fact_relationship
(
    domain_concept_id_1     INT64 NOT NULL,
    fact_id_1               INT64 NOT NULL,
    domain_concept_id_2     INT64 NOT NULL,
    fact_id_2               INT64 NOT NULL,
    relationship_concept_id INT64 NOT NULL
);

CREATE TABLE IF NOT EXISTS location
(
    location_id           INT64 NOT NULL,
    address_1             STRING,
    address_2             STRING,
    city                  STRING,
    state                 STRING,
    zip                   STRING,
    county                STRING,
    location_source_value STRING,
    country_concept_id    INT64,
    country_source_value  STRING,
    latitude              BIGNUMERIC,
    longitude             BIGNUMERIC
);

CREATE TABLE IF NOT EXISTS care_site
(
    care_site_id                  INT64 NOT NULL,
    care_site_name                STRING,
    place_of_service_concept_id   INT64,
    location_id                   INT64,
    care_site_source_value        STRING,
    place_of_service_source_value STRING
);

CREATE TABLE IF NOT EXISTS provider
(
    provider_id                 INT64 NOT NULL,
    provider_name               STRING,
    npi                         STRING,
    dea                         STRING,
    specialty_concept_id        INT64,
    care_site_id                INT64,
    year_of_birth               INT64,
    gender_concept_id           INT64,
    provider_source_value       STRING,
    specialty_source_value      STRING,
    specialty_source_concept_id INT64,
    gender_source_value         STRING,
    gender_source_concept_id    INT64
);

CREATE TABLE IF NOT EXISTS payer_plan_period
(
    payer_plan_period_id          INT64 NOT NULL,
    person_id                     INT64 NOT NULL,
    payer_plan_period_start_date  DATE  NOT NULL,
    payer_plan_period_end_date    DATE  NOT NULL,
    payer_concept_id              INT64,
    payer_source_value            STRING,
    payer_source_concept_id       INT64,
    plan_concept_id               INT64,
    plan_source_value             STRING,
    plan_source_concept_id        INT64,
    sponsor_concept_id            INT64,
    sponsor_source_value          STRING,
    sponsor_source_concept_id     INT64,
    family_source_value           STRING,
    stop_reason_concept_id        INT64,
    stop_reason_source_value      STRING,
    stop_reason_source_concept_id INT64
);

CREATE TABLE IF NOT EXISTS cost
(
    cost_id                   INT64  NOT NULL,
    cost_event_id             INT64  NOT NULL,
    cost_domain_id            STRING NOT NULL,
    cost_type_concept_id      INT64  NOT NULL,
    currency_concept_id       INT64,
    total_charge              BIGNUMERIC,
    total_cost                BIGNUMERIC,
    total_paid                BIGNUMERIC,
    paid_by_payer             BIGNUMERIC,
    paid_by_patient           BIGNUMERIC,
    paid_patient_copay        BIGNUMERIC,
    paid_patient_coinsurance  BIGNUMERIC,
    paid_patient_deductible   BIGNUMERIC,
    paid_by_primary           BIGNUMERIC,
    paid_ingredient_cost      BIGNUMERIC,
    paid_dispensing_fee       BIGNUMERIC,
    payer_plan_period_id      INT64,
    amount_allowed            BIGNUMERIC,
    revenue_code_concept_id   INT64,
    revenue_code_source_value STRING,
    drg_concept_id            INT64,
    drg_source_value          STRING
);

CREATE TABLE IF NOT EXISTS drug_era
(
    drug_era_id         INT64 NOT NULL,
    person_id           INT64 NOT NULL,
    drug_concept_id     INT64 NOT NULL,
    drug_era_start_date DATE  NOT NULL,
    drug_era_end_date   DATE  NOT NULL,
    drug_exposure_count INT64,
    gap_days            INT64
);

CREATE TABLE IF NOT EXISTS dose_era
(
    dose_era_id         INT64      NOT NULL,
    person_id           INT64      NOT NULL,
    drug_concept_id     INT64      NOT NULL,
    unit_concept_id     INT64      NOT NULL,
    dose_value          BIGNUMERIC NOT NULL,
    dose_era_start_date DATE       NOT NULL,
    dose_era_end_date   DATE       NOT NULL
);

CREATE TABLE IF NOT EXISTS condition_era
(
    condition_era_id           INT64 NOT NULL,
    person_id                  INT64 NOT NULL,
    condition_concept_id       INT64 NOT NULL,
    condition_era_start_date   DATE  NOT NULL,
    condition_era_end_date     DATE  NOT NULL,
    condition_occurrence_count INT64
);

CREATE TABLE IF NOT EXISTS episode
(
    episode_id                INT64 NOT NULL,
    person_id                 INT64 NOT NULL,
    episode_concept_id        INT64 NOT NULL,
    episode_start_date        DATE  NOT NULL,
    episode_start_datetime    TIMESTAMP,
    episode_end_date          DATE,
    episode_end_datetime      TIMESTAMP,
    episode_parent_id         INT64,
    episode_number            INT64,
    episode_object_concept_id INT64 NOT NULL,
    episode_type_concept_id   INT64 NOT NULL,
    episode_source_value      STRING,
    episode_source_concept_id INT64
);

CREATE TABLE IF NOT EXISTS episode_event
(
    episode_id                     INT64 NOT NULL,
    event_id                       INT64 NOT NULL,
    episode_event_field_concept_id INT64 NOT NULL
);

CREATE TABLE IF NOT EXISTS metadata
(
    metadata_id              INT64  NOT NULL,
    metadata_concept_id      INT64  NOT NULL,
    metadata_type_concept_id INT64  NOT NULL,
    name                     STRING NOT NULL,
    value_as_string          STRING,
    value_as_concept_id      INT64,
    value_as_number          BIGNUMERIC,
    metadata_date            DATE,
    metadata_datetime        TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cdm_source
(
    cdm_source_name                STRING NOT NULL,
    cdm_source_abbreviation        STRING NOT NULL,
    cdm_holder                     STRING NOT NULL,
    source_description             STRING,
    source_documentation_reference STRING,
    cdm_etl_reference              STRING,
    source_release_date            DATE   NOT NULL,
    cdm_release_date               DATE   NOT NULL,
    cdm_version                    STRING,
    cdm_version_concept_id         INT64  NOT NULL,
    vocabulary_version             STRING NOT NULL
);

CREATE TABLE IF NOT EXISTS concept
(
    concept_id       INT64  NOT NULL,
    concept_name     STRING NOT NULL,
    domain_id        STRING NOT NULL,
    vocabulary_id    STRING NOT NULL,
    concept_class_id STRING NOT NULL,
    standard_concept STRING,
    concept_code     STRING NOT NULL,
    valid_start_date DATE   NOT NULL,
    valid_end_date   DATE   NOT NULL,
    invalid_reason   STRING
)
    CLUSTER BY
        concept_id;

CREATE TABLE IF NOT EXISTS vocabulary
(
    vocabulary_id         STRING NOT NULL,
    vocabulary_name       STRING NOT NULL,
    vocabulary_reference  STRING,
    vocabulary_version    STRING,
    vocabulary_concept_id INT64  NOT NULL
);

CREATE TABLE IF NOT EXISTS domain
(
    domain_id         STRING NOT NULL,
    domain_name       STRING NOT NULL,
    domain_concept_id INT64  NOT NULL
);

CREATE TABLE IF NOT EXISTS concept_class
(
    concept_class_id         STRING NOT NULL,
    concept_class_name       STRING NOT NULL,
    concept_class_concept_id INT64  NOT NULL
);

CREATE TABLE IF NOT EXISTS concept_relationship
(
    concept_id_1     INT64  NOT NULL,
    concept_id_2     INT64  NOT NULL,
    relationship_id  STRING NOT NULL,
    valid_start_date DATE   NOT NULL,
    valid_end_date   DATE   NOT NULL,
    invalid_reason   STRING
)
    CLUSTER BY
        concept_id_1;

CREATE TABLE IF NOT EXISTS relationship
(
    relationship_id         STRING NOT NULL,
    relationship_name       STRING NOT NULL,
    is_hierarchical         STRING NOT NULL,
    defines_ancestry        STRING NOT NULL,
    reverse_relationship_id STRING NOT NULL,
    relationship_concept_id INT64  NOT NULL
);

CREATE TABLE IF NOT EXISTS concept_synonym
(
    concept_id           INT64  NOT NULL,
    concept_synonym_name STRING NOT NULL,
    language_concept_id  INT64  NOT NULL
)
    CLUSTER BY
        concept_id;

CREATE TABLE IF NOT EXISTS concept_ancestor
(
    ancestor_concept_id      INT64 NOT NULL,
    descendant_concept_id    INT64 NOT NULL,
    min_levels_of_separation INT64 NOT NULL,
    max_levels_of_separation INT64 NOT NULL
)
    CLUSTER BY
        descendant_concept_id;

CREATE TABLE IF NOT EXISTS source_to_concept_map
(
    source_code             STRING NOT NULL,
    source_concept_id       INT64  NOT NULL,
    source_vocabulary_id    STRING NOT NULL,
    source_code_description STRING,
    target_concept_id       INT64  NOT NULL,
    target_vocabulary_id    STRING NOT NULL,
    valid_start_date        DATE   NOT NULL,
    valid_end_date          DATE   NOT NULL,
    invalid_reason          STRING
);

CREATE TABLE IF NOT EXISTS drug_strength
(
    drug_concept_id             INT64 NOT NULL,
    ingredient_concept_id       INT64 NOT NULL,
    amount_value                BIGNUMERIC,
    amount_unit_concept_id      INT64,
    numerator_value             BIGNUMERIC,
    numerator_unit_concept_id   INT64,
    denominator_value           BIGNUMERIC,
    denominator_unit_concept_id INT64,
    box_size                    INT64,
    valid_start_date            DATE  NOT NULL,
    valid_end_date              DATE  NOT NULL,
    invalid_reason              STRING
)
    CLUSTER BY
        drug_concept_id;

CREATE TABLE IF NOT EXISTS cohort
(
    cohort_definition_id INT64 NOT NULL,
    subject_id           INT64 NOT NULL,
    cohort_start_date    DATE  NOT NULL,
    cohort_end_date      DATE  NOT NULL
);

CREATE TABLE IF NOT EXISTS cohort_definition
(
    cohort_definition_id          INT64  NOT NULL,
    cohort_definition_name        STRING NOT NULL,
    cohort_definition_description STRING,
    definition_type_concept_id    INT64  NOT NULL,
    cohort_definition_syntax      STRING,
    subject_concept_id            INT64  NOT NULL,
    cohort_initiation_date        DATE
);