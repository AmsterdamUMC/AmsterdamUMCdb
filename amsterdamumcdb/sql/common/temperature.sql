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
    8658, --Temp Bloed
    8659, --Temperatuur Perifeer 2
    8662, --Temperatuur Perifeer 1
    13058, --Temp Rectaal
    13059, --Temp Lies
    13060, --Temp Axillair
    13061, --Temp Oraal
    13062, --Temp Oor
    13063, --Temp Huid
    13952, --Temp Blaas
    16110 --Temp Oesophagus
)
AND (measuredat - a.admittedat) <= 1000*60*60*24 --measurements within 24 hours