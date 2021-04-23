SELECT
    n.admissionid,
    n.itemid,
    n.item,
    n.value,
    f.value AS specimen_source,
    n.registeredby,
    CASE
        WHEN n.registeredby NOT ILIKE '%Systeem%' THEN TRUE
        ELSE FALSE
    END AS manual_entry,
    (n.measuredat - a.admittedat)/(1000*60) AS time
FROM numericitems n
LEFT JOIN admissions a ON
    n.admissionid = a.admissionid
LEFT JOIN freetextitems f ON
    n.admissionid = f.admissionid AND
    n.measuredat = f.measuredat AND
    f.itemid = 11646 --Afname (bloed): source of specimen (arterial)
WHERE n.itemid IN (
    6848, --PH
    12310 --pH (bloed)
    )
-- measurements within 24 hours of ICU stay (use 30 minutes before admission to allow for time differences):
AND (n.measuredat - a.admittedat) <= 1000*60*60*24 AND (n.measuredat - a.admittedat) >= -(1000*60*30)
AND (f.value ILIKE '%art.%' OR f.value IS NULL) -- source is arterial or undefined (assume arterial)