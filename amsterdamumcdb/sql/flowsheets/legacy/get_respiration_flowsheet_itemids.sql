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
  9572, 
  'Bijzonderheden', 
  'Particularities', 
  'miscellaneous', 
  426, 
  'detail', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12369, 
  'SET %O2', 
  'SET% O2', 
  'respiration Bipap Vision settings', 
  590, 
  'Bipap Vision settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12371, 
  'CPAP (Bipap Vision)', 
  'CPAP (Bipap Vision)', 
  'respiration Bipap Vision settings', 
  590, 
  'Bipap Vision settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12376, 
  'Mode (Bipap Vision)', 
  'Mode (Bipap Vision)', 
  'respiration Bipap Vision settings', 
  590, 
  'Bipap Vision settings', 
  'list'
);
INSERT INTO fs
VALUES (
  12378, 
  'IPAP', 
  'IPAP', 
  'respiration Bipap Vision settings', 
  590, 
  'Bipap Vision settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12379, 
  'EPAP', 
  'EPAP', 
  'respiration Bipap Vision settings', 
  590, 
  'Bipap Vision settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12380, 
  'IPAP Rise Time', 
  'IPAP Rise Time', 
  'respiration Bipap Vision settings', 
  590, 
  'Bipap Vision settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12381, 
  'Tinsp (Set)', 
  'Tinsp (Set)', 
  'respiration Bipap Vision settings', 
  590, 
  'Bipap Vision settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12385, 
  'Rate (Set)', 
  'Rate (Set)', 
  'respiration Bipap Vision settings', 
  590, 
  'Bipap Vision settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12382, 
  'Ti/ T tot', 
  'Ti / T total', 
  'respiration Bipap Vision measurements', 
  591, 
  'Bipap Vision measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12383, 
  'Tot. leak', 
  'Tot. leak', 
  'respiration Bipap Vision measurements', 
  591, 
  'Bipap Vision measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12384, 
  'Pt. trig', 
  'Pt. trig', 
  'respiration Bipap Vision measurements', 
  591, 
  'Bipap Vision measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12372, 
  'Rate (Bipap Vision)', 
  'Rate (Bipap Vision)', 
  'respiration Bipap Vision measurements', 
  591, 
  'Bipap Vision measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12373, 
  'Vt (Bipap Vision)', 
  'Vt (Bipap Vision)', 
  'respiration Bipap Vision measurements', 
  591, 
  'Bipap Vision measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12374, 
  'MinVent', 
  'MinVent', 
  'respiration Bipap Vision measurements', 
  591, 
  'Bipap Vision measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6698, 
  'PIP', 
  'PIP', 
  'respiration Bipap Vision measurements', 
  591, 
  'Bipap Vision measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9233, 
  'Houding patiënt', 
  'Position patient', 
  'miscellaneous', 
  426, 
  'miscellaneous', 
  'list'
);
INSERT INTO fs
VALUES (
  9532, 
  'Tinspiratie', 
  'Tinspiration', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9533, 
  'Texpiratie', 
  'Texpiration', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9534, 
  'Type beademing Evita 1', 
  'Type respirator Evita 1', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'list'
);
INSERT INTO fs
VALUES (
  9609, 
  'BIPAP T1 Evita1', 
  'BIPAP T1 Evita1', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9611, 
  'BIPAP T2 Evita1', 
  'BIPAP T2 Evita1', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6685, 
  'Type Beademing Evita 4', 
  'Type respirator Evita 4', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'list'
);
INSERT INTO fs
VALUES (
  8848, 
  'Beademingstoestel', 
  'respirator machine', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'list'
);
INSERT INTO fs
VALUES (
  8849, 
  'Insp. Flow max', 
  'Insp. Flow max', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8850, 
  'Frequentie', 
  'Frequency', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8851, 
  'Tidal Volume (Set)', 
  'Tidal Volume (Set)', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8852, 
  'P max', 
  'P max', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8853, 
  'Freq. IMV', 
  'Freq. IMV', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8854, 
  'Trigger/ASB(curve)', 
  'Trigger/ASB(curve)', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8855, 
  'Tinsp : Texp', 
  'Tinsp : Texp', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'list'
);
INSERT INTO fs
VALUES (
  8856, 
  'Flow trigger ASB', 
  'Flow trigger ASB', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8857, 
  'BIPAP Hoog', 
  'BIPAP high', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8858, 
  'BIPAP Laag', 
  'BIPAP low', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8861, 
  'NO', 
  'NO nitrogen', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8862, 
  'PEEP/CPAP', 
  'PEEP/CPAP', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8865, 
  'ASB', 
  'ASB', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8868, 
  'Temperatuur Bevochtiger', 
  'Temperature humidifier', 
  'respiration Evita settings', 
  330, 
  'Evita settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8869, 
  'O2 Volume', 
  'O2 Volume', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8870, 
  'VE', 
  'VE', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8871, 
  'VTe', 
  'VTe', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8872, 
  'Tidal Volume Spirometer', 
  'Tidal Volume Spirometer', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8873, 
  'Ademfrequentie Evita', 
  'Respiration frequency Evita', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6710, 
  'Compliance', 
  'Compliance', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  7726, 
  'Ademfrequentie Spontaan', 
  'Spontaneous respiration frequency', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8875, 
  'Mv Spontaan', 
  'MV spontaneously', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8876, 
  'Frequentie Spontaan', 
  'Spontaneous respiration frequency', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8877, 
  'Peak druk', 
  'Peak pressure', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8878, 
  'Plateau druk', 
  'Plateau pressure', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8879, 
  'PEEP (gemeten)', 
  'PEEP measured', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8880, 
  'Weerstand', 
  'Resistance', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8882, 
  'Intrinsic PEEP', 
  'Intrinsic PEEP', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8883, 
  'Airtrap', 
  'Airtrap', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8884, 
  'End Tidal CO2 %', 
  'End Tidal CO2 %', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8885, 
  'End Tidal CO2 mmHG', 
  'End Tidal CO2 mmHG', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8886, 
  'Beademings Temperatuur', 
  'Respiration temperature', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9619, 
  'Mv Lekkage', 
  'MV leakage', 
  'respiration Evita measurements', 
  331, 
  'Evita measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12082, 
  'HFO-Bias-flow', 
  'HFO-Bias-flow', 
  'respiration High Frequency Oscillatory (HFO)', 
  579, 
  'HFO-respiration', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12083, 
  'HFO-Paw', 
  'HFO-Paw', 
  'respiration High Frequency Oscillatory (HFO)', 
  579, 
  'HFO-respiration', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12084, 
  'HFO-Amplitude', 
  'HFO-Amplitude', 
  'respiration High Frequency Oscillatory (HFO)', 
  579, 
  'HFO-respiration', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12085, 
  'HFO-Paw Ondergrens', 
  'HFO-Paw low', 
  'respiration High Frequency Oscillatory (HFO)', 
  579, 
  'HFO-respiration', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12086, 
  'HFO-Paw Bovengrens', 
  'HFO-Paw high', 
  'respiration High Frequency Oscillatory (HFO)', 
  579, 
  'HFO-respiration', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12088, 
  'HFO-Inspiratietijd', 
  'HFO-Inspirationtime', 
  'respiration High Frequency Oscillatory (HFO)', 
  579, 
  'HFO-respiration', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12090, 
  'HFO-Frequentie', 
  'HFO-Frequency', 
  'respiration High Frequency Oscillatory (HFO)', 
  579, 
  'HFO-respiration', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12283, 
  'Adem Frequentie (Set)', 
  'Respiration Frequency (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12285, 
  'PC boven PEEP (Set)', 
  'PC above PEEP (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12287, 
  'SIMV Frequentie (Set)', 
  'SIMV frequency (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12289, 
  'Volume (Set)', 
  'Volume (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12294, 
  'SIMV ademcyclus (Set)', 
  'SIMV respiration cycle (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12295, 
  'P hoog (Set)', 
  'P high (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12296, 
  'T hoog (Set)', 
  'T high (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12297, 
  'T peep (Set)', 
  'T peep (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12298, 
  'PS boven P hoog (Set)', 
  'PS above P high (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12300, 
  'Trigger time out (Set)', 
  'Trigger time out (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12304, 
  'Triggergevoeligheid (Set)', 
  'Trigger sensitivity (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12305, 
  'P Bovenste (Set)', 
  'P upper (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12306, 
  'Insp. Time %, Set', 
  'Insp. Time %, Set', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12307, 
  'Pause time (Set, %)', 
  'Pause time (Set, %)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12308, 
  'Insp. Rise time (Set)', 
  'Insp. Rise time (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12309, 
  'I : E (Set)', 
  'I : E (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12291, 
  'Teugvolume (Set)', 
  'Tidal volume (Set)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12573, 
  'Insp. Time (sec) nieuw', 
  'Insp. Time (sec)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12574, 
  'Pause Time (sec) nieuw', 
  'Pause Time (sec)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12576, 
  'Insp. Rise time (Set, sec) nieuw', 
  'Insp. Rise time (Set, sec)', 
  'respiration Servo settings', 
  587, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12577, 
  'Ademfreq. Spontaan nieuw', 
  'Respiration frequency spontaneously', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12578, 
  'MVe Spontaan nieuw', 
  'MVe spontaneously', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12683, 
  'Ti (sec) nieuw', 
  'Ti (sec)', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14091, 
  'NAVA Edi peak', 
  'NAVA Edi peak', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14092, 
  'NAVA Edi min', 
  'NAVA Edi min', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20343, 
  'I : E', 
  'I : E', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12561, 
  'Cdyn', 
  'Cdyn', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12570, 
  'Cstat', 
  'Cstat', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12571, 
  'Elastance', 
  'Elastance', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12572, 
  'NIV leakage fraction nieuw', 
  'NIV leakage fraction', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12563, 
  'Ri', 
  'Ri', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12564, 
  'Re', 
  'Re', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12567, 
  'WOBv', 
  'WOBv', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12301, 
  'PEEP tot', 
  'PEEP tot', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12302, 
  'Vec (Eind-expiratoire flow)', 
  'Vec (Eind-expiratoire flow)', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12280, 
  'Pauze druk', 
  'Pauze pressure', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12281, 
  'Piek druk', 
  'Peak pressure', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12278, 
  'Mean luchtweg druk', 
  'Mean airway pressure', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12270, 
  'CO2 tidal productie', 
  'CO2 tidal production', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12266, 
  'Ademfreq.', 
  'Resipration frequency', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6707, 
  'End tidal CO2 concentratie', 
  'End tidal CO2 concentration', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6709, 
  'Saturatie (Monitor)', 
  'Saturation (Monitor)', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8080, 
  'CO2 min prod', 
  'CO2 min prod', 
  'respiration Servo measurements', 
  586, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14089, 
  'NAVA Niveau', 
  'NAVA level', 
  'respiration Servo NAVA settings', 
  662, 
  'NAVA machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14090, 
  'NAVA  Edi Trigger', 
  'NAVA  Edi Trigger', 
  'respiration Servo NAVA settings', 
  662, 
  'NAVA machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12558, 
  'NIV Backup RR (Set)', 
  'NIV Backup RR (Set)', 
  'respiration Servo NIV settings', 
  612, 
  'NIV machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12559, 
  'NIV Backup Ti (Set)', 
  'NIV Backup Ti (Set)', 
  'respiration Servo NIV settings', 
  612, 
  'NIV machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12560, 
  'NIV Program Status (Set)', 
  'NIV Program Status (Set)', 
  'respiration Servo NIV settings', 
  612, 
  'NIV machine measurements', 
  'list'
);
INSERT INTO fs
VALUES (
  6699, 
  'FiO2 %', 
  'FiO2 %', 
  'respiration Oxygen offer (O2)', 
  329, 
  'O2 offer', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12322, 
  'Adem Frequentie (Set) (2)', 
  'Respiration frequentie (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12323, 
  'Backup druk (Set) (2)', 
  'Backup pressure (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12324, 
  'Eind insp. cyclus (Set) (2)', 
  'Eind insp. cyclus (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12325, 
  'I : E (2)', 
  'I : E', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12327, 
  'Insp. Rise time %, Set (2)', 
  'Insp. Rise time %, Set', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12328, 
  'Insp. Time %, (Set, %)  (2)', 
  'Insp. Time %, (Set, %)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12329, 
  'O2 concentratie (Set) (2)', 
  'O2 concentration (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12331, 
  'P Bovenste (Set) (2)', 
  'P upper (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12333, 
  'P hoog (Set) (2)', 
  'P high (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12334, 
  'Pause time (Set, %) (2)', 
  'Pause time (Set, %)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'freetext'
);
INSERT INTO fs
VALUES (
  12335, 
  'PC boven PEEP (Set) (2)', 
  'PC above PEEP (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12336, 
  'PEEP (Set) (2)', 
  'PEEP (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12337, 
  'PS boven P hoog (Set) (2)', 
  'PS above P high (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12338, 
  'PS boven PEEP (Set) (2)', 
  'PS above PEEP (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12339, 
  'SIMV ademcyclus (Set) (2)', 
  'SIMV resipration cycle (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12340, 
  'SIMV Frequentie (Set) (2)', 
  'SIMV Frequency (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12341, 
  'T hoog (Set) (2)', 
  'T hoog (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12342, 
  'T peep (Set) (2)', 
  'T peep (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12343, 
  'Teugvolume (Set) (2)', 
  'Tidal volume (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12344, 
  'Trigger time out  (Set) (2)', 
  'Trigger time out  (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12345, 
  'Triggergevoeligheid (Set) (2)', 
  'Trigger sensitivity (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12346, 
  'Volume (Set) (2)', 
  'Volume (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12347, 
  'Ventilatie Mode (Set) (2)', 
  'Ventilation Mode (Set)', 
  'respiration Servo settings', 
  588, 
  'Servo machine settings', 
  'list'
);
INSERT INTO fs
VALUES (
  12348, 
  'Ademfreq.(2)', 
  'Respiration frequency', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12350, 
  'CO2 min prod (2)', 
  'CO2 min prod', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12352, 
  'CO2 tidal productie (2)', 
  'CO2 tidal production', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12354, 
  'Eind exp. druk (2)', 
  'Eind exp. pressure', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12356, 
  'End tidal CO2 concentratie (2)', 
  'End tidal CO2 concentration', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12357, 
  'Exp. minuut volume (2)', 
  'Exp. minute volume', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12358, 
  'Exp. tidal volume (2)', 
  'Exp. tidal volume', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12359, 
  'Insp. Minuut volume (2)', 
  'Insp. minute volume', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12360, 
  'Insp. tidal volume (2)', 
  'Insp. tidal volume', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12362, 
  'Mean luchtweg druk (2)', 
  'Mean airway pressure', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12363, 
  'Pauze druk (2)', 
  'Pause pressure', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12364, 
  'PEEP tot (2)', 
  'PEEP tot', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12365, 
  'Piek druk (2)', 
  'Peak pressure', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12366, 
  'SBI (Zwakke ademhalingsindex) (2)', 
  'SBI (weak respiration index)', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12367, 
  'Vec (Eind-expiratoire flow) (2)', 
  'Vec (End-expiratory flow)', 
  'respiration Servo measurements', 
  589, 
  'Servo machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8955, 
  'Cuff druk van Tube', 
  'Cuff pressure tube', 
  'respiration Tube cuff pressure', 
  333, 
  'Turbe cuff pressure', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8891, 
  'Balloneren', 
  'Ballooning', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  8893, 
  'Neus Toilet', 
  'Nose cleaning', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  8889, 
  'Aantal Bronchiaaltoilet', 
  'Total brochial suction', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  8874, 
  'Ademfrequentie Monitor', 
  'Respiration frequency Monitor', 
  'respiration Servo measurements', 
  586, 
  'respiration Servo measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8845, 
  'O2 l/min', 
  'O2 l/min', 
  'respiration Oxygen offer (O2)', 
  329, 
  'O2 offer', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8189, 
  'Toedieningsweg', 
  'Airway route', 
  'respiration Oxygen offer (O2)', 
  329, 
  'O2 offer', 
  'list'
);
INSERT INTO fs
VALUES (
  12279, 
  'O2 concentratie', 
  'O2 concentration', 
  'respiration Oxygen offer (O2)', 
  329, 
  'O2 offer', 
  'numeric'
);
INSERT INTO fs
VALUES (
  15295, 
  'Gecuffed/Ontcuffed', 
  'Cuffed/Not cuffed', 
  'respiration Oxygen offer (O2)', 
  329, 
  'O2 offer', 
  'list'
);
INSERT INTO fs
VALUES (
  12684, 
  'Insp. Rise time (Set, %) nieuw', 
  'Insp. Rise time (Set, %)', 
  'respiration Servo settings', 
  587, 
  'Servoi machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12293, 
  'Backup druk (Set)', 
  'Backup druk (Set)', 
  'respiration Servo settings', 
  587, 
  'Servoi machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12292, 
  'Eind insp. cyclus (Set)', 
  'End insp. cyclus (Set)', 
  'respiration Servo settings', 
  587, 
  'Servoi machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12282, 
  'O2 concentratie (Set)', 
  'O2 concentration (Set)', 
  'respiration Servo settings', 
  587, 
  'Servoi machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12290, 
  'Ventilatie Mode (Set)', 
  'Ventilation Mode (Set)', 
  'respiration Servo settings', 
  587, 
  'Servoi machine settings', 
  'list'
);
INSERT INTO fs
VALUES (
  12286, 
  'PS boven PEEP (Set)', 
  'PS above PEEP (Set)', 
  'respiration Servo settings', 
  587, 
  'Servoi machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12284, 
  'PEEP (Set)', 
  'PEEP (Set)', 
  'respiration Servo settings', 
  587, 
  'Servoi machine settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12303, 
  'SBI (Zwakke ademhalingsindex)', 
  'SBI (weak respirationindex)', 
  'respiration Servo measurements', 
  586, 
  'Servoi machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12277, 
  'Insp. tidal volume', 
  'Insp. tidal volume', 
  'respiration Servo measurements', 
  586, 
  'Servoi machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12276, 
  'Insp. Minuut volume', 
  'Insp. minute volume', 
  'respiration Servo measurements', 
  586, 
  'Servoi machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12275, 
  'Exp. tidal volume', 
  'Exp. tidal volume', 
  'respiration Servo measurements', 
  586, 
  'Servoi machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12273, 
  'Exp. minuut volume', 
  'Exp. minute volume', 
  'respiration Servo measurements', 
  586, 
  'Servoi machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  6694, 
  'Eind exp. druk', 
  'End exp. pressure', 
  'respiration Servo measurements', 
  586, 
  'Servoi machine measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12519, 
  'Aspect Sputum', 
  'Aspect Sputum', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  8899, 
  'Hoestprikkel', 
  'Cough stimulus', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  8892, 
  'Mond/Keel toilet', 
  'Mouth/throat cleaning', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  8898, 
  'Reactie op Uitzuigen', 
  'Reaction on suction', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  8897, 
  'Druppelen NaCl', 
  'Drips NaCL', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  8895, 
  'Kleur Sputum', 
  'Color sputum', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  8894, 
  'Hoeveelheid Sputum', 
  'Amount sputum', 
  'respiration suction ', 
  369, 
  'suction', 
  'list'
);
INSERT INTO fs
VALUES (
  15142, 
  'CPAP PEEP (cmH2O)', 
  'CPAP PEEP (cmH2O)', 
  'respiration Oxygen offer (O2)', 
  329, 
  'Vital Flow (CPAP)', 
  'list'
);
INSERT INTO fs
VALUES (
  16246, 
  'Zephyros FiO2', 
  'Zephyros FiO2', 
  'respiration Zephyron settings', 
  693, 
  'Zephyros settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16248, 
  'Zephyros  Freq', 
  'Zephyros frequency', 
  'respiration Zephyron settings', 
  693, 
  'Zephyros settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16249, 
  'Zephyros P.Insp', 
  'Zephyros P.Insp', 
  'respiration Zephyron settings', 
  693, 
  'Zephyros settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16250, 
  'Zephyros PEEP', 
  'Zephyros PEEP', 
  'respiration Zephyron settings', 
  693, 
  'Zephyros settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16251, 
  'Zephyros P-psv', 
  'Zephyros P-psv', 
  'respiration Zephyron settings', 
  693, 
  'Zephyros settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16239, 
  'Zephyros Ppeak', 
  'Zephyros Ppeak', 
  'respiration Zephyron measurements', 
  694, 
  'Zephyros measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16240, 
  'Zephyros Pmin', 
  'Zephyros Pmin', 
  'respiration Zephyron measurements', 
  694, 
  'Zephyros measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16241, 
  'Zephyros Frequentie', 
  'Zephyros frequency', 
  'respiration Zephyron measurements', 
  694, 
  'Zephyros measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16243, 
  'Zephyros Vte', 
  'Zephyros Vte', 
  'respiration Zephyron measurements', 
  694, 
  'Zephyros measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16244, 
  'Zephyros Mve', 
  'Zephyros Mve', 
  'respiration Zephyron measurements', 
  694, 
  'Zephyros measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  16245, 
  'Zephyros O2i', 
  'Zephyros O2i', 
  'respiration Zephyron measurements', 
  694, 
  'Zephyros measurements', 
  'numeric'
);