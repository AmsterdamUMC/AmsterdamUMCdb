SELECT
    procedure_occurrence_id,
    po.person_id,
    po.visit_occurrence_id,
    procedure_concept_id,
    c.concept_name AS procedure_concept_name,
    procedure_datetime
FROM
    procedure_occurrence po
    LEFT JOIN visit_occurrence vo ON
        vo.visit_occurrence_id = po.visit_occurrence_id
    LEFT JOIN concept c ON
        c.concept_id = po.procedure_concept_id
WHERE
    procedure_datetime < vo.visit_start_datetime
    AND procedure_datetime >= vo.visit_start_datetime - INTERVAL '8 HOUR'
    AND NOT po.provider_id IS NULL

