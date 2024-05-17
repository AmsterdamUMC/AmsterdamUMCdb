WITH resp_rate AS (
    SELECT
        n.admissionid,
        n.itemid,
        n.item,
        n.value,
        CASE
            WHEN NOT n.registeredby IS NULL THEN TRUE
            ELSE FALSE
        END as validated,
        (n.measuredat - a.admittedat)/(1000*60) AS time,
        ROW_NUMBER() OVER(
            PARTITION BY n.admissionid, n.measuredat
            ORDER BY
                CASE itemid
                    WHEN 8873 THEN 1 --Ventilator measurements
                    WHEN 12266 THEN 2 --Ventilator measurements
                    ELSE 3  --Patient monitor measurements
                END
            ) AS priority
    FROM numericitems n
    LEFT JOIN admissions a ON
        n.admissionid = a.admissionid
    WHERE itemid IN (
        --Evita Parameters
        8873, --Ademfrequentie Evita: measurement by Evita ventilator, most accurate
        --7726, --Ademfrequentie Spontaan: measurement by Evita ventilator, spontaneous breaths/min, distiction not needed for 'actual' respiratory rate
        --9654, --Ademfrequentie Spontaan(2): measurement by 2nd simultaneously used Evita ventilator (very uncommon), spontaneous breaths/min, distiction not needed for 'actual' respiratory rate

        --Servo-i/Servo-u Parameters
        --12283, --Adem Frequentie (Set): setting on Servo-i/Servo-U ventilator, not needed for 'actual' respiratory rate
        --12322, --Adem Frequentie (Set) (2): setting on 2nd simultaneously used Servo-i/Servo-U ventilator (uncommon), not needed for 'actual' respiratory rate
        12266, --Ademfreq.: measurement by Servo-i/Servo-U ventilator, most accurate
        --12348, --Ademfreq.(2): measurement by 2nd simultaneously used Servo-i/Servo-U ventilator (uncommon), no additional information
        --12577 --Ademfreq. Spontaan nieuw --from Servo-i/Servo-U ventilator, spontaneous breaths/min, distiction not needed for 'actual' respiratory rate

        --Patient monitor
        8874 --Ademfrequentie Monitor: measurement by patient monitor using ECG-impedance, less accurate
        )
    AND (n.measuredat - a.admittedat) <= 1000*60*60*24 --measurements within 24 hours
)
SELECT * FROM
resp_rate
WHERE priority = 1 --only retrieve most accurate measurement