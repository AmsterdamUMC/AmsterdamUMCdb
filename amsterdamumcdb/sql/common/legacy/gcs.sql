WITH sedatives_analgesics AS (
    SELECT
        admissionid,
        itemid,
        item,
        start,
        stop,
        rate
    FROM drugitems
    WHERE ordercategoryid = 65 --2. Spuitpompen: continuous infusions like sedatives/vasopressors
    AND itemid in (
        7480	--Propofol (Diprivan)
        ,7194	--Midazolam (Dormicum)
        ,6962	--Clonazepam (Rivotril)
        ,7165	--Lorazepam (Temesta)
        ,7170	--Diazepam (Valium)
        ,8190	--Thiopental (Nesdonal)
        ,9004	--Pentobarbital (Nembutal)
        ,7219	--Fentanyl
        ,7225	--Morfine
        ,9018	--Esketamine (Ketanest-S)
        ,7097	--Haloperidol (Haldol)
    )
    AND rate > 0.5 --lower rates are often used for comfort/pain relieve
), gcs_components AS (
    SELECT
        eyes.admissionid,
        --eyes.itemid,
        --eyes.item,
        --eyes.value,
        --eyes.valueid,
        CASE eyes.itemid
            WHEN 6732 THEN 5 - eyes.valueid     --Actief openen van de ogen
            WHEN 13077 THEN eyes.valueid        --A_Eye
            WHEN 14470 THEN eyes.valueid - 4    --RA_Eye
            WHEN 16628 THEN eyes.valueid - 4    --MCA_Eye
            WHEN 19635 THEN eyes.valueid - 4    --E_EMV_NICE_24uur
            WHEN 19638 THEN eyes.valueid - 8    --E_EMV_NICE_Opname
        END AS eyes_score,
        --motor.value,
        --motor.valueid,
        CASE motor.itemid
            WHEN 6734 THEN 7 - motor.valueid    --Beste motore reactie van de armen
            WHEN 13072 THEN motor.valueid       --A_Motoriek
            WHEN 14476 THEN motor.valueid - 6   --RA_Motoriek
            WHEN 16634 THEN motor.valueid - 6   --MCA_Motoriek
            WHEN 19636 THEN motor.valueid - 6   --M_EMV_NICE_24uur
            WHEN 19639 THEN motor.valueid - 12  --M_EMV_NICE_Opname
        END AS motor_score,
        --verbal.value,
        --verbal.valueid,
        CASE verbal.itemid
            WHEN 6735 THEN 6 - verbal.valueid   --Beste verbale reactie
            WHEN 13066 THEN verbal.valueid      --A_Verbal
            WHEN 14482 THEN verbal.valueid - 5  --RA_Verbal
            WHEN 16640 THEN verbal.valueid - 5  --MCA_Verbal
            WHEN 19637 THEN verbal.valueid - 9 --V_EMV_NICE_24uur
            WHEN 19640 THEN verbal.valueid - 15 --V_EMV_NICE_Opname
        END AS verbal_score,
        eyes.measuredat,
        eyes.registeredby as eyes_registeredby,
        eyes.updatedat as eyes_updatedat,
        motor.registeredby as motor_registeredby,
        motor.updatedat as motor_updatedat,
        verbal.registeredby as verbal_registeredby,
        verbal.updatedat as verbal_updatedat,
        (eyes.measuredat - a.admittedat)/(1000*60) AS time
    FROM listitems eyes
    LEFT JOIN admissions a ON
        eyes.admissionid = a.admissionid
    LEFT JOIN listitems motor ON
        eyes.admissionid = motor.admissionid AND
        eyes.measuredat = motor.measuredat AND
        motor.itemid IN (
            6734, --Beste motore reactie van de armen
            13072, --A_Motoriek
            14476, --RA_Motoriek
            16634, --MCA_Motoriek
            19636, --M_EMV_NICE_24uur
            19639 --M_EMV_NICE_Opname
        )
    LEFT JOIN listitems verbal ON
        eyes.admissionid = verbal.admissionid AND
        eyes.measuredat = verbal.measuredat AND
        verbal.itemid IN (
            6735, --Beste verbale reactie
            13066, --A_Verbal
            14482, --RA_Verbal
            16640, --MCA_Verbal
            19637, --V_EMV_NICE_24uur
            19640 --V_EMV_NICE_Opname
        )
    WHERE eyes.itemid IN (
        6732, --Actief openen van de ogen
        13077, --A_Eye
        14470, --RA_Eye
        16628, --MCA_Eye
        19635, --E_EMV_NICE_24uur
        19638 --E_EMV_NICE_Opname
        )
    -- measurements within 24 hours of ICU stay:
    AND (eyes.measuredat - a.admittedat) <= 1000*60*60*24 AND (eyes.measuredat - a.admittedat) >= 0
), gcs AS (
    SELECT *
        ,eyes_score + motor_score + (
            CASE
                WHEN verbal_score < 1 THEN 1
                ELSE verbal_score
            END
        ) AS gcs_score
        ,CASE
            WHEN 'ICV_Medisch Staflid' IN (eyes_registeredby, motor_registeredby, verbal_registeredby) THEN 'ICV_Medisch Staflid'
            WHEN 'ICV_Medisch' IN (eyes_registeredby, motor_registeredby, verbal_registeredby) THEN 'ICV_Medisch'
            WHEN 'ANES_Anesthesiologie' IN (eyes_registeredby, motor_registeredby, verbal_registeredby) THEN 'ANES_Anesthesiologie'
            WHEN 'ICV_Physician assistant' IN (eyes_registeredby, motor_registeredby, verbal_registeredby) THEN 'ICV_Physician assistant'
            WHEN 'ICH_Neurochirurgie' IN (eyes_registeredby, motor_registeredby, verbal_registeredby) THEN 'ICH_Neurochirurgie'
            WHEN 'ICV_IC-Verpleegkundig' IN (eyes_registeredby, motor_registeredby, verbal_registeredby) THEN 'ICV_IC-Verpleegkundig'
            WHEN 'ICV_MC-Verpleegkundig' IN (eyes_registeredby, motor_registeredby, verbal_registeredby) THEN 'ICV_MC-Verpleegkundig'
            ELSE eyes_registeredby
        END as registeredby
        ,ROW_NUMBER() OVER(
            PARTITION BY admissionid, measuredat
            ORDER BY
                CASE eyes_registeredby --prefer documentation by senior staff/SOFA trained staff
                    WHEN 'ICV_Medisch Staflid' THEN 1
                    WHEN 'ICV_Medisch' THEN 2
                    WHEN 'ANES_Anesthesiologie'THEN 3
                    WHEN 'ICV_Physician assistant' THEN 4
                    WHEN 'ICH_Neurochirurgie'THEN 5
                    WHEN 'ICV_IC-Verpleegkundig' THEN 6
                    WHEN 'ICV_MC-Verpleegkundig' THEN 7
                    ELSE 8
                END,
                CASE motor_registeredby --prefer documentation by senior staff/SOFA trained staff
                    WHEN 'ICV_Medisch Staflid' THEN 1
                    WHEN 'ICV_Medisch' THEN 2
                    WHEN 'ANES_Anesthesiologie'THEN 3
                    WHEN 'ICV_Physician assistant' THEN 4
                    WHEN 'ICH_Neurochirurgie'THEN 5
                    WHEN 'ICV_IC-Verpleegkundig' THEN 6
                    WHEN 'ICV_MC-Verpleegkundig' THEN 7
                    ELSE 8
                END,
                CASE verbal_registeredby --prefer documentation by senior staff/SOFA trained staff
                    WHEN 'ICV_Medisch Staflid' THEN 1
                    WHEN 'ICV_Medisch' THEN 2
                    WHEN 'ANES_Anesthesiologie'THEN 3
                    WHEN 'ICV_Physician assistant' THEN 4
                    WHEN 'ICH_Neurochirurgie'THEN 5
                    WHEN 'ICV_IC-Verpleegkundig' THEN 6
                    WHEN 'ICV_MC-Verpleegkundig' THEN 7
                    ELSE 8
                END,
               eyes_updatedat DESC, motor_updatedat DESC, verbal_updatedat DESC, --prefer most recent updates/corrections
               eyes_score DESC, motor_score DESC, verbal_score DESC --prefer most recent updates/corrections
        ) AS priority
    FROM gcs_components
)
SELECT
    gcs.admissionid, gcs.measuredat, gcs.time, gcs.eyes_score, gcs.motor_score, gcs.verbal_score, gcs.registeredby, gcs_score,
    STRING_AGG(DISTINCT sa.item, '; ' ORDER BY sa.item) AS sedatives_given,
    MAX((gcs.measuredat - sa.start)/(1000*60)) AS sedatives_started_minutes_before, --negative values indicate not yet running
    MIN((gcs.measuredat - sa.stop)/(1000*60)) AS sedatives_stopped_minutes_before --negative values indicate still running
FROM gcs
LEFT JOIN sedatives_analgesics sa ON
    gcs.admissionid = sa.admissionid AND
    gcs.measuredat >= sa.start - (1000*60*60*2) AND --started not more than two hours in the future
    gcs.measuredat <= sa.stop + (1000*60*60*2) --stopped not more than two hours before measurement
WHERE priority = 1
GROUP BY gcs.admissionid, gcs.measuredat, gcs.time, gcs.eyes_score, gcs.motor_score, gcs.verbal_score, gcs.registeredby, gcs_score
ORDER BY gcs.admissionid, gcs.measuredat