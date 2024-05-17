SELECT
    oxy_dev.admissionid,
    oxy_dev.valueid,
    oxy_dev.value as o2_device,
    oxy_dev.measuredat,
    oxy_flow.value AS o2_flow
FROM listitems oxy_dev
LEFT JOIN admissions a ON
    oxy_dev.admissionid = a.admissionid
LEFT JOIN numericitems oxy_flow ON
    oxy_dev.admissionid = oxy_flow.admissionid AND
    oxy_dev.measuredat = oxy_flow.measuredat AND
    oxy_flow.itemid IN (
        8845, -- O2 l/min
        10387, --Zuurstof toediening (bloed)
        18587 --Zuurstof toediening
    )
WHERE oxy_dev.itemid = 8189 -- Toedieningsweg (Oxygen device)
    -- measurements within 24 hours of ICU stay:
    AND (oxy_dev.measuredat - a.admittedat) <= 1000*60*60*24 AND (oxy_dev.measuredat - a.admittedat) >= 0