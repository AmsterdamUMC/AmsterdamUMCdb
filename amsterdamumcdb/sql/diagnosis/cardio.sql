SELECT
    condition_occurrence_id,
    person_id,
    visit_occurrence_id,
    condition_concept_id,
    c_condition.concept_name AS condition_concept_name,
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
    AND condition_concept_id IN
        (SELECT
             descendant_concept_id
         FROM
             concept_ancestor
         WHERE
             ancestor_concept_id IN
             (
                 321588 -- Heart disease
                 ))
ORDER BY
    person_id, visit_occurrence_id