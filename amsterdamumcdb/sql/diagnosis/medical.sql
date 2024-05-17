SELECT
    condition_occurrence_id,
    person_id,
    visit_occurrence_id,
    condition_concept_id,
    c_condition.concept_name as condition_concept_name,
    condition_start_datetime,
    condition_status_concept_id,
    c_status.concept_name    AS status_concept_name
FROM
    condition_occurrence c_o
    LEFT JOIN concept c_condition ON
        c_condition.concept_id = c_o.condition_concept_id
    LEFT JOIN concept c_status ON
        c_status.concept_id = c_o.condition_status_concept_id
WHERE
    condition_status_concept_id IN
    (
     32901, --Primary admission diagnosis
     32907 --Secondary admission diagnosis
        )
    AND NOT visit_occurrence_id IN
            -- Exclude admissions from the surgical query:
            (SELECT
                 DISTINCT po.visit_occurrence_id
             FROM
                 procedure_occurrence po
                 LEFT JOIN visit_occurrence vo ON
                     vo.visit_occurrence_id = po.visit_occurrence_id
                 LEFT JOIN concept c ON
                     c.concept_id = po.procedure_concept_id
             WHERE
                 procedure_datetime < vo.visit_start_datetime
                 AND procedure_datetime >= vo.visit_start_datetime - INTERVAL '8 HOUR')
ORDER BY
    person_id, visit_occurrence_id
