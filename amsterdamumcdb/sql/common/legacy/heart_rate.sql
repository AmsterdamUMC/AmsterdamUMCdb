SELECT
    n.admissionid,
    n.itemid,
    n.item,
    n.value,
    CASE
        WHEN NOT registeredby IS NULL THEN TRUE
        ELSE FALSE
    END as validated,
    (measuredat - a.admittedat)/(1000*60) AS time
FROM numericitems n
LEFT JOIN admissions a ON
n.admissionid = a.admissionid
WHERE itemid IN (
    6640 --Hartfrequentie
)
AND (measuredat - a.admittedat) <= 1000*60*60*24 --measurements within 24 hours