WITH mechanical_ventilation as (
    SELECT admissionid,
           CASE
               WHEN COUNT(*) > 0 THEN TRUE
               ELSE FALSE
               END                          AS mechanical_ventilation_bool,
           STRING_AGG(DISTINCT value, '; ') AS mechanical_ventilation_modes,
    FROM listitems
    WHERE (
                itemid = 9534 --Type beademing Evita 1
            AND valueid IN (
                            1, --IPPV
                            2, --IPPV_Assist
                            3, --CPPV
                            4, --CPPV_Assist
                            5, --SIMV
                            6, --SIMV_ASB
                            7, --ASB
                            8, --CPAP
                            9, --CPAP_ASB
                            10, --MMV
                            11, --MMV_ASB
                            12, --BIPAP
                            13 --Pressure Controled
            )
        )
       OR (
                itemid = 6685 --Type Beademing Evita 4
            AND valueid IN (
                            1, --CPPV
                            3, --ASB
                            5, --CPPV/ASSIST
                            6, --SIMV/ASB
                            8, --IPPV
                            9, --IPPV/ASSIST
                            10, --CPAP
                            11, --CPAP/ASB
                            12, --MMV
                            13, --MMV/ASB
                            14, --BIPAP
                            20, --BIPAP-SIMV/ASB
                            22 --BIPAP/ASB
            )
        )
       OR (
                itemid = 8189 --Toedieningsweg O2
            AND valueid = 16 --CPAP
        )
       OR (
                itemid IN (
                           12290, --Ventilatie Mode (Set) - Servo-I and Servo-U ventilators
                           12347 --Ventilatie Mode (Set) (2) Servo-I and Servo-U ventilators
                )
            AND valueid IN (
            --IGNORE: 1, --Stand By
                            2, --PC
                            3, --VC
                            4, --PRVC
                            5, --VS
                            6, --SIMV(VC)+PS
                            7, --SIMV(PC)+PS
                            8, --PS/CPAP
                            9, --Bi Vente
                            10, --PC (No trig)
                            11, --VC (No trig)
                            12, --PRVC (No trig)
                            13, --PS/CPAP (trig)
                            14, --VC (trig)
                            15, --PRVC (trig)
                            16, --PC in NIV
                            17, --PS/CPAP in NIV
                            18 --NAVA
            )
        )
       OR itemid = 12376 --Mode (Bipap Vision)
        AND valueid IN (
                        1, --CPAP
                        2 --BIPAP
            )
    GROUP BY admissionid
),
     tube AS (
         SELECT admissionid,
                CASE
                    WHEN COUNT(*) > 0 THEN TRUE
                    ELSE FALSE
                    END AS endotracheal_tube
         FROM processitems
         WHERE itemid = 12634 --Tube
         GROUP BY admissionid
     ),
     trach AS (
         SELECT admissionid,
                CASE
                    WHEN COUNT(*) > 0 THEN TRUE
                    ELSE FALSE
                    END AS tracheostomy
         FROM processitems
         WHERE itemid = 12635 --Tracheostoma
         GROUP BY admissionid
     ),
     niv AS (
         SELECT admissionid,
                CASE
                    WHEN COUNT(*) > 0 THEN TRUE
                    ELSE FALSE
                    END AS non_invasive_bool
         FROM processitems
         WHERE itemid = 10740 --Beademen non-invasief
         GROUP BY admissionid
     ),
     iv as (
         SELECT admissionid,
                CASE
                    WHEN COUNT(*) > 0 THEN TRUE
                    ELSE FALSE
                    END                          AS invasive_bool,
                STRING_AGG(DISTINCT value, '; ') AS invasive_modes,
         FROM listitems
         WHERE (
                     itemid = 9534 --Type beademing Evita 1
                 AND valueid IN (
                                 1, --IPPV
                                 2, --IPPV_Assist
                                 3, --CPPV
                                 4, --CPPV_Assist
                                 5, --SIMV
                                 6, --SIMV_ASB
                                 7, --ASB
                                 8, --CPAP
                                 9, --CPAP_ASB
                                 10, --MMV
                                 11, --MMV_ASB
                                 12, --BIPAP
                                 13 --Pressure Controled
                 )
             )
            OR (
                     itemid = 6685 --Type Beademing Evita 4
                 AND valueid IN (
                                 1, --CPPV
                                 3, --ASB
                                 5, --CPPV/ASSIST
                                 6, --SIMV/ASB
                                 8, --IPPV
                                 9, --IPPV/ASSIST
                                 10, --CPAP
                                 11, --CPAP/ASB
                                 12, --MMV
                                 13, --MMV/ASB
                                 14, --BIPAP
                                 20, --BIPAP-SIMV/ASB
                                 22 --BIPAP/ASB
                 )
             )
            OR (
                     itemid IN (
                                12290, --Ventilatie Mode (Set) - Servo-I and Servo-U ventilators
                                12347 --Ventilatie Mode (Set) (2) Servo-I and Servo-U ventilators
                     )
                 AND valueid IN (
                                 2, --PC
                                 3, --VC
                                 4, --PRVC
                                 5, --VS
                                 6, --SIMV(VC)+PS
                                 7, --SIMV(PC)+PS
                                 8, --PS/CPAP
                                 9, --Bi Vente
                                 10, --PC (No trig)
                                 11, --VC (No trig)
                                 12, --PRVC (No trig)
                                 13, --PS/CPAP (trig)
                                 14, --VC (trig)
                                 15, --PRVC (trig)
                                 18 --NAVA
                 )
             )
         GROUP BY admissionid
     )
SELECT mv.admissionid
     , mv.mechanical_ventilation_bool
     , mv.mechanical_ventilation_modes
     , iv.invasive_bool
     , niv.non_invasive_bool
     , tube.endotracheal_tube
     , trach.tracheostomy
FROM mechanical_ventilation mv
         LEFT JOIN iv ON iv.admissionid = mv.admissionid
         LEFT JOIN tube ON tube.admissionid = mv.admissionid
         LEFT JOIN trach ON trach.admissionid = mv.admissionid
         LEFT JOIN niv ON niv.admissionid = mv.admissionid