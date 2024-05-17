DROP TABLE IF EXISTS fs;

CREATE TEMP TABLE fs (
    itemid int, 
    item varchar(50),
    item_english varchar(50),
    itemcategory  varchar(100),
    itemcategoryid int,
    label varchar(50),
    item_type varchar(30)
); 

INSERT INTO fs
VALUES (
  6640, 
  'Hartfrequentie', 
  'Heart rate (HR)', 
  'HD Heart rythm', 
  320, 
  'Heart rhythm', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6641, 
  'ABP systolisch', 
  'ABP systolic (ABPs)', 
  'HD Blood Pressures', 
  323, 
  'Blood pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6642, 
  'ABP gemiddeld', 
  'ABP mean (ABPm)', 
  'HD Blood Pressures', 
  323, 
  'Blood pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6643, 
  'ABP diastolisch', 
  'ABP diastolic (ABPd)', 
  'HD Blood Pressures', 
  323, 
  'Blood pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6644, 
  'PAP systolisch', 
  'PAP systolic (PAPs)', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6645, 
  'PAP gemiddeld', 
  'PAP mean (PAPm)', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6646, 
  'PAP diastolisch', 
  'PAP diastolic (PAPd)', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6655, 
  'CVD', 
  'CVP (central venous pressure)', 
  'HD Blood Pressures', 
  323, 
  'Blood pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6656, 
  'Cardiac Output', 
  'Cardiac Output (CO)', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6657, 
  'PCWP wedge', 
  'PCWP wedge', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6658, 
  'IABP Frequentie', 
  'IABP Frequency', 
  'HD-IABP', 
  326, 
  'IABP', 
  'list'
);
INSERT INTO fs
VALUES (
  6671, 
  'Hartritme', 
  'Heart rhythm', 
  'HD Heart rythm', 
  320, 
  'Heart rhythm', 
  'list'
);
INSERT INTO fs
VALUES (
  6678, 
  'Niet invasieve bloeddruk systolisch', 
  'Non invasive blood pressure systolic (NIBPs)', 
  'HD Blood Pressures', 
  323, 
  'Blood pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6679, 
  'Niet invasieve bloeddruk gemiddeld', 
  'Non-invasive mean blood pressure (NIBPm)', 
  'HD Blood Pressures', 
  323, 
  'Blood pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6680, 
  'Niet invasieve bloeddruk diastolisch', 
  'Non invasive blood pressure diastolic (NIBPd)', 
  'HD Blood Pressures', 
  323, 
  'Blood pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8200, 
  'Pacemaker mode', 
  'Pacemaker mode', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'list'
);
INSERT INTO fs
VALUES (
  8463, 
  'Blaasdruk', 
  'Bladder pressure', 
  'MISCELLANEOUS', 
  426, 
  'Other', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8647, 
  'IABP Trigger', 
  'IABP Trigger', 
  'HD-IABP', 
  326, 
  'IABP', 
  'list'
);
INSERT INTO fs
VALUES (
  8649, 
  'IABP Systole', 
  'IABP Systolic', 
  'HD-IABP', 
  326, 
  'IABP', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8650, 
  'IABP Curve', 
  'IABP Curve', 
  'HD-IABP', 
  326, 
  'IABP', 
  'list'
);
INSERT INTO fs
VALUES (
  8651, 
  'Pulsaties Li-been', 
  'Left leg pulsations', 
  'HD Pulsations', 
  324, 
  'Pulsations', 
  'list'
);
INSERT INTO fs
VALUES (
  8652, 
  'Pulsaties Re-been', 
  'Right leg Pulsations', 
  'HD Pulsations', 
  324, 
  'Pulsations', 
  'list'
);
INSERT INTO fs
VALUES (
  8654, 
  'IABP Pulsatie', 
  'IABP Pulsation', 
  'HD-IABP', 
  326, 
  'IABP', 
  'list'
);
INSERT INTO fs
VALUES (
  8655, 
  'IABP Augmentatie', 
  'IABP Augmentation', 
  'HD-IABP', 
  326, 
  'IABP', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8658, 
  'Temp Bloed', 
  'Temperature Blood', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8659, 
  'Temperatuur Perifeer 2', 
  'Temperature Peripheral 2', 
  'HD Temperature', 
  322, 
  'Old parameters', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8662, 
  'Temperatuur Perifeer 1', 
  'Temperature Peripheral 1', 
  'HD Temperature', 
  322, 
  'Old parameters', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8663, 
  'Temperatuur Plaats 1', 
  'Temperature Place 1', 
  'HD Temperature', 
  322, 
  'Old parameters', 
  'list'
);
INSERT INTO fs
VALUES (
  8825, 
  'Ectopie', 
  'Ectopia', 
  'HD Heart rythm', 
  320, 
  'Heart rhythm', 
  'list'
);
INSERT INTO fs
VALUES (
  8841, 
  'ABP systolisch II', 
  'ABP systolic (ABPs) II', 
  'HD-Other', 
  367, 
  'Other', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8842, 
  'ABP diastolisch II', 
  'ABP diastolic (ABPd) II', 
  'HD-Other', 
  367, 
  'Other', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8843, 
  'ABP gemiddeld II', 
  'ABP mean (ABPm) II', 
  'HD-Other', 
  367, 
  'Other', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9233, 
  'Houding patiënt', 
  'Position patient', 
  'MISCELLANEOUS', 
  426, 
  'Miscellaneous', 
  'list'
);
INSERT INTO fs
VALUES (
  9469, 
  'Pacemaker Frequentie', 
  'Pacemaker Frequency', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9470, 
  'Pacemaker Ventricle ampl.(output) ingesteld', 
  'Pacemaker Ventricle ampl. (Output) set', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9471, 
  'Pacemaker Ventricle sense ingesteld', 
  'Pacemaker Ventricle sense set', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9572, 
  'Bijzonderheden', 
  'Particularities', 
  'MISCELLANEOUS', 
  426, 
  'Particularities', 
  'freetext'
);
INSERT INTO fs
VALUES (
  9593, 
  'Temperatuur Plaats 2', 
  'Temperature Place 2', 
  'HD Temperature', 
  322, 
  'Old parameters', 
  'list'
);
INSERT INTO fs
VALUES (
  10433, 
  'IABP Bijzonderheden', 
  'IABP Particulars', 
  'HD-IABP', 
  326, 
  'IABP', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12087, 
  'Buikomvang', 
  'Belly circumference', 
  'MISCELLANEOUS', 
  426, 
  'Other', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12403, 
  'Pacemaker Atrium ampl.(output) ingesteld', 
  'Pacemaker Atrium ampl. (Output) set', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12404, 
  'Pacemaker Atrium sense ingesteld', 
  'Pacemaker Atrium sense set', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12440, 
  'IABP HF', 
  'IABP HF  (heart frequency)', 
  'HD-IABP', 
  326, 
  'IABP', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12441, 
  'IABP Mean Sys. Blood Pressure', 
  'IABP Mean Systole Blood Pressure', 
  'HD-IABP', 
  326, 
  'IABP', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12442, 
  'IABP Mean Dia. Blood Pressure', 
  'IABP Mean Diastole Blood Pressure', 
  'HD-IABP', 
  326, 
  'IABP', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12443, 
  'IABP Mean Blood Pressure', 
  'IABP Mean Blood Pressure', 
  'HD-IABP', 
  326, 
  'IABP', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13058, 
  'Temp Rectaal', 
  'Temperature Rectal', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13059, 
  'Temp Lies', 
  'Temperature Lies', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13060, 
  'Temp Axillair', 
  'Temperature Axillary', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13061, 
  'Temp Oraal', 
  'Temperature Oral', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13062, 
  'Temp Oor', 
  'Temperature Ear', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13063, 
  'Temp Huid', 
  'Temperature Skin', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13064, 
  'Temp Huid Plaats', 
  'Temperature Skin Place', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'list'
);
INSERT INTO fs
VALUES (
  13151, 
  'PiCCO CO (Cardiac Output)', 
  'PiCCO CO (Cardiac Output)', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13154, 
  'PiCCO SVV (Slagvolumevariatie)', 
  'PiCCO SVV (Stroke Volume Variation)', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13155, 
  'PiCCO PPV (Polsdrukvariatie)', 
  'PiCCO PPV (Pulse Pressure Variation)', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13491, 
  'Bladderscan: Inhoud blaas', 
  'Bladderscan: Bladder content', 
  'MISCELLANEOUS', 
  426, 
  'Other', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13952, 
  'Temp Blaas', 
  'Temperature Bladder', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14047, 
  'PiCCO Tb blood temperature', 
  'PiCCO Tb blood temperature', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14048, 
  'PiCCO Gewicht', 
  'PiCCO Weight', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14055, 
  'PiCCO HF Hartfrequentie', 
  'PiCCO HF Heart rate', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14059, 
  'PiCCO AD Bloeddruk', 
  'PiCCO AD Blood pressure', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'Gegroepeerd'
);
INSERT INTO fs
VALUES (
  14060, 
  'PiCCO mean CO', 
  'PiCCO mean CO', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14062, 
  'PiCCO PCCO', 
  'PiCCO PCCO', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14064, 
  'PiCCO GEF', 
  'PiCCO GEF', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14065, 
  'Beat to beat SV', 
  'Beat to beat SV', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14066, 
  'PiCCO GEDV', 
  'PiCCO GEDV', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14067, 
  'PiCCO mean GEDV', 
  'PiCCO mean GEDV', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14070, 
  'PiCCO EVLW', 
  'iCCO EVLW', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14071, 
  'PiCCO mean EVLW', 
  'PiCCO mean EVLW', 
  'PiCCO-plus', 
  652, 
  'PiCCO plus', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16110, 
  'Temp Oesophagus', 
  'Temperature Oesophagus', 
  'HD Temperature', 
  322, 
  'Temperature', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16686, 
  'Peritoneaal druk', 
  'Peritoneal pressure', 
  'MISCELLANEOUS', 
  426, 
  'Other', 
  'numeric'
);
INSERT INTO fs
VALUES (
  18618, 
  'MC NAS score', 
  'MC NAS score', 
  'NAS score', 
  708, 
  'Particularities', 
  'numeric'
);
INSERT INTO fs
VALUES (
  18843, 
  'IC NAS score', 
  'IC NAS score', 
  'NAS score', 
  708, 
  'Miscellaneous', 
  'numeric'
);
INSERT INTO fs
VALUES (
  19361, 
  'Pacemaker Atrium ampl.(output) gemeten', 
  'Pacemaker Atrium ampl. (Output) measured', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  19362, 
  'Pacemaker Atrium sense gemeten', 
  'Pacemaker Atrium sense measured', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  19363, 
  'Pacemaker Ventricle ampl.(output) gemeten', 
  'Pacemaker Ventricle ampl. (Output) measured', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  19364, 
  'Pacemaker Ventricle sense gemeten', 
  'Pacemaker Ventricle sense measured', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20081, 
  'Gemeten gewicht', 
  'Measured weight', 
  'Anamnesis-Patient Data', 
  476, 
  'Miscellaneous', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20950, 
  'Global Ejection Fraction', 
  'Global Ejection Fraction', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20951, 
  'Stroke Volume Variation', 
  'Stroke Volume Variation', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20952, 
  'ExtraVasculair Lung Water Index', 
  'ExtraVascular Lung Water Index', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20953, 
  'Global End Diastolic Volume Index', 
  'Global End Diastolic Volume Index', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20954, 
  'Pulmonary Vascular Permeability Index', 
  'Pulmonary Vascular Permeability Index', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20955, 
  'CCO', 
  'CCO', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20956, 
  'CCI', 
  'CCI', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20957, 
  'ITBVI', 
  'ITBVI', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  21050, 
  'DPmax', 
  'DPmax', 
  'HD Profile', 
  325, 
  'Profile', 
  'numeric'
);
INSERT INTO fs
VALUES (
  21180, 
  'Pacemaker batterij verwisseld', 
  'Pacemaker battery changed', 
  'ORDER Circulation', 
  430, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  21181, 
  'Pacemaker AV delay', 
  'Pacemaker AV delay', 
  'HD Heart rythm', 
  320, 
  'Pacemaker', 
  'numeric'
);
INSERT INTO fs
VALUES (
  21189, 
  'Pulsaties Arteria Radialis Li', 
  'Pulsations Arteria Radialis Li', 
  'HD Pulsations', 
  324, 
  'Pulsations', 
  'list'
);
INSERT INTO fs
VALUES (
  21190, 
  'Pulsaties Arteria Radialis Re', 
  'Pulsations Arteria Radialis Re', 
  'HD Pulsations', 
  324, 
  'Pulsations', 
  'list'
);
INSERT INTO fs
VALUES (
  21191, 
  'Pulsaties Arteria Femoralis Re', 
  'Pulsations Arteria Femoralis Re', 
  'HD Pulsations', 
  324, 
  'Pulsations', 
  'list'
);
INSERT INTO fs
VALUES (
  21192, 
  'Pulsaties Arteria Femoralis Li', 
  'Pulsations Arteria Femoralis Li', 
  'HD Pulsations', 
  324, 
  'Pulsations', 
  'list'
);

SELECT * FROM fs;