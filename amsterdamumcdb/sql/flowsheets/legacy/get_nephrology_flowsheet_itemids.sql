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
  6684, 
  'Vloeistofvolume ingesteld', 
  'Fluid volume set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  7666, 
  'Arteriele druk', 
  'Arterial pressure', 
  'CVVH-measurements', 
  350, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  7667, 
  'Pre Filter PBE', 
  'Pre Filter PBE', 
  'CVVH-measurements', 
  350, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  7668, 
  'Veneuze druk braun', 
  'Venous pressure braun', 
  'CVVH-measurements', 
  350, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  7671, 
  'Negatieve filterdruk', 
  'Negative filter pressure', 
  'CVVH-measurements', 
  350, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  7905, 
  'TempVerwarmer ingesteld', 
  'Temperature Heater set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  7969, 
  'RedenStakenCVVH', 
  'Reason ending CVVH', 
  'CVVH-measurements', 
  350, 
  'CVVH-measurements', 
  'list'
);
INSERT INTO fs
VALUES (
  8492, 
  'AnGap', 
  'Anion Gap', 
  'Labs chemie blood', 
  371, 
  'Labs', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8622, 
  'PA max ingesteld', 
  'PA max set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8805, 
  'CVVH Onttrokken', 
  'CVVH Withdrawn', 
  'Fluidbalance CVVH', 
  347, 
  'CVVH fluidbalance', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8805, 
  'CVVH Onttrokken', 
  'CVVH Withdrawn', 
  'Fluidbalance CVVH', 
  347, 
  'CVVH-balance', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9572, 
  'Bijzonderheden', 
  'Particularities', 
  'Miscellaneous', 
  426, 
  'Particularities', 
  'freetext'
);
INSERT INTO fs
VALUES (
  9933, 
  'Calcium totaal (bloed)', 
  'Calcium total (blood)', 
  'Labs chemie blood', 
  490, 
  'Labs', 
  'NULL'
);
INSERT INTO fs
VALUES (
  10267, 
  'Ca-ion (7.4) (bloed)', 
  'Ca ion (7.4) (blood)', 
  'Labs chemie blood', 
  490, 
  'Labs', 
  'NULL'
);
INSERT INTO fs
VALUES (
  10736, 
  'Bloed-flow', 
  'Blood flow', 
  'CVVH-measurements', 
  350, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  11944, 
  'APTT  (bloed)', 
  'APTT (blood)', 
  'Labs hematology blood', 
  500, 
  'Labs', 
  'NULL'
);
INSERT INTO fs
VALUES (
  12091, 
  'CVVH-Vochtverlies stand', 
  'CVVH-fluid loss position', 
  'CVVH-measurements', 
  350, 
  'CVVH fluidbalance', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12091, 
  'CVVH-Vochtverlies stand', 
  'CVVH-fluid loss position', 
  'CVVH-measurements', 
  350, 
  'CVVH-balance', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12444, 
  'Bloedflow ingesteld', 
  'Blood flow set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12445, 
  'PA min ingesteld', 
  'PA min set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12446, 
  'PBE max ingesteld', 
  'PBE max set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12447, 
  'PD1 max ingesteld', 
  'PD1 set max', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12448, 
  'PD2 min ingesteld', 
  'PD2 min set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12449, 
  'PFD max ingesteld', 
  'PFD max set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12450, 
  'PV venster', 
  'PV window', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12451, 
  'Substitutie vloeistof volume ingesteld', 
  'Substitution fluid volume set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12452, 
  'Substitutieflow ingesteld', 
  'Substitution flow set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12453, 
  'TMP max ingesteld', 
  'TMP max set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12454, 
  'Vochtverlies ingesteld', 
  'Fluid loss set', 
  'CVVH-settings', 
  351, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12456, 
  'PFD', 
  'PFD', 
  'CVVH-measurements', 
  350, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  12459, 
  'TMP', 
  'TMP', 
  'CVVH-measurements', 
  350, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14835, 
  'MFT_Arteriele druk', 
  'MFT_Arterial pressure', 
  'CVVH-MFT', 
  681, 
  'CVVH pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14836, 
  'MFT_Filtraat druk', 
  'MFT_Filtrion pressure', 
  'CVVH-MFT', 
  681, 
  'CVVH pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14837, 
  'MFT_Veneuze druk', 
  'MFT_Venous pressure', 
  'CVVH-MFT', 
  681, 
  'CVVH pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14838, 
  'MFT_TMP', 
  'MFT_TMP', 
  'CVVH-MFT', 
  681, 
  'CVVH pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14839, 
  'MFT_Pre-filter druk', 
  'MFT_Pre-filter pressure', 
  'CVVH-MFT', 
  681, 
  'CVVH pressures', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14840, 
  'MFT_TMP bovengrens', 
  'MFT_TMP upper limit', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14841, 
  'MFT_Arteriele ondergrens', 
  'MFT_Arterial lower limit', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14842, 
  'MFT_Arteriele bovengrens', 
  'MFT_Arterial upper limit', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14843, 
  'MFT_Veneuze bovengrens', 
  'MFT_Venous upper limit', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14844, 
  'MFT_Veneuze ondergrens', 
  'MFT_Venous lower limit', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14845, 
  'MFT_TMP ondergrens', 
  'MFT_TMP lower limit', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14846, 
  'MFT_Behandeling', 
  'MFT_Treatment', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'list'
);
INSERT INTO fs
VALUES (
  14848, 
  'MFT_Substituaat (ingesteld)', 
  'MFT_Substitute (set)', 
  'CVVH-MFT', 
  681, 
  'MFT_substitution (old)', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14849, 
  'MFT_Ultrafiltratie (ingesteld)', 
  'MFT_Ultrafiltration (set)', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14850, 
  'MFT_Bloedflow (ingesteld)', 
  'MFT_Blood flow (set)', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14851, 
  'MFT_UF Totaal (ingesteld)', 
  'MFT_UF Total (set)', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14852, 
  'MFT_Temperatuur (ingesteld)', 
  'MFT_Temperature (set)', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  17982, 
  'APTT (bloed)', 
  'APTT (blood)', 
  'Labs hematology blood', 
  500, 
  'Labs', 
  'NULL'
);
INSERT INTO fs
VALUES (
  20076, 
  'MFT_Substitutievolume_totaal', 
  'MFT_Substitution volume_total', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20077, 
  'MFT_Substitutievolume_huidig', 
  'MFT_Substitution volume_current', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20078, 
  'MFT_Filtraatvolume_huidig', 
  'MFT_Filtration Volume_current', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20079, 
  'MFT_Filtraatvolume_totaal', 
  'MFT_Filtration volume_total', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20080, 
  'MFT_Behandelingsduur', 
  'MFT_Treatment duration', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20340, 
  'MFT_FilterLooptijd', 
  'MFT_FilterRuntime', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20549, 
  'Citraatslot', 
  'Citrate lock', 
  'CVVH-other', 
  743, 
  'CVVH-measurements', 
  'list'
);
INSERT INTO fs
VALUES (
  20551, 
  'Wissel postdilutiezakken', 
  'Exchange postdilution bags', 
  'CVVH-other', 
  743, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20552, 
  'Wissel predilutiezakken', 
  'Change predilution bags', 
  'CVVH-other', 
  743, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20631, 
  'RRI (Renal Resistive Index)', 
  'RRI (Renal Resistive Index)', 
  'Bio-impedance', 
  730, 
  'Measurement', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20706, 
  'MFT_Predilutievolume_huidig', 
  'MFT_Predilution Volume_current', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20707, 
  'MFT_Predilutievolume_totaal', 
  'MFT_Predilution Volume_Total', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20708, 
  'MFT_Postdilutievolume_huidig', 
  'MFT_ postdilution volume_current', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20709, 
  'MFT_Postdilutievolume_totaal', 
  'MFT_ postdilution volume_total', 
  'CVVH-MFT', 
  681, 
  'CVVH-measurements', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20710, 
  'MFT_Predilutieflow (ingesteld)', 
  'MFT_Predilution flow (set)', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20716, 
  'MFT_Postdilutieflow (ingesteld)', 
  'MFT_Postdilution flow (set)', 
  'CVVH-MFT', 
  681, 
  'CVVH-settings', 
  'numeric'
);

SELECT * FROM fs;