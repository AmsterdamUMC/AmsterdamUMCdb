SELECT
    procedure_occurrence_id,
    po.person_id,
    po.visit_occurrence_id,
    procedure_concept_id,
    c.concept_name AS procedure_concept_name,
    procedure_datetime
FROM
    procedure_occurrence po
    LEFT JOIN visit_occurrence visit ON
        visit.visit_occurrence_id = po.visit_occurrence_id
    LEFT JOIN concept c ON
        c.concept_id = po.procedure_concept_id
    LEFT JOIN provider p ON
        p.provider_id = visit.provider_id
WHERE
    procedure_datetime < visit.visit_start_datetime
    AND procedure_datetime >= visit.visit_start_datetime - INTERVAL '8 HOUR'
    AND (p.specialty_concept_id = 38004447 -- General Surgery
        OR procedure_concept_id IN
           (SELECT
                descendant_concept_id
            FROM
                concept_ancestor
            WHERE
                ancestor_concept_id IN
                (
                    --4314251, -- Laparotomy
                    4293032 --Procedure on gastrointestinal tract
                    ))
        )
    AND NOT procedure_concept_id IN
            (SELECT
                 descendant_concept_id
             FROM
                 concept_ancestor
             WHERE
                 ancestor_concept_id IN
                 (
                  4042641, --Procedure on cardiovascular system
                  4030781 --Operative procedure on male genitourinary system (procedure)
                     ))
    AND NOT po.provider_id IS NULL



