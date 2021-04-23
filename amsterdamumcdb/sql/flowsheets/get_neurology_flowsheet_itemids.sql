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
  9356, 
  'EVD-cm boven Monroe', 
  'EVD-cm above Monroe', 
  'neurology common', 
  428, 
  'neurology common', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9357, 
  'ELD-cm boven Monroe', 
  'ELD-cm above Monroe', 
  'neurology common', 
  428, 
  'neurology common', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9358, 
  'EVD-Open/Dicht', 
  'EVD-Open / Close', 
  'neurology common', 
  428, 
  'neurology common', 
  'list'
);
INSERT INTO fs
VALUES (
  9359, 
  'ELD-Open/Dicht', 
  'ELD-Open / Close', 
  'neurology common', 
  428, 
  'neurology common', 
  'list'
);
INSERT INTO fs
VALUES (
  9545, 
  'Cerebrale PaO2', 
  'Cerebral PaO2', 
  'neurology common', 
  428, 
  'neurology common', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9546, 
  'Cerebrale temp.', 
  'Cerebral temp.', 
  'neurology common', 
  428, 
  'neurology common', 
  'numeric'
);
INSERT INTO fs
VALUES (
  10604, 
  'Liquor aspect', 
  'Liquor aspect', 
  'neurology common', 
  428, 
  'neurology common', 
  'list'
);
INSERT INTO fs
VALUES (
  13943, 
  'Liquor aspect(2)', 
  'Liquor aspect(2)', 
  'neurology common', 
  428, 
  'neurology common', 
  'list'
);
INSERT INTO fs
VALUES (
  13944, 
  'EVD-Open/Dicht(2)', 
  'EVD-Open / Close(2)', 
  'neurology common', 
  428, 
  'neurology common', 
  'list'
);
INSERT INTO fs
VALUES (
  13945, 
  'EVD-cm boven Monroe(2)', 
  'EVD-cm above Monroe(2)', 
  'neurology common', 
  428, 
  'neurology common', 
  'numeric'
);
INSERT INTO fs
VALUES (
  14769, 
  'Arm Li', 
  'Arm left', 
  'neurology functions', 
  336, 
  'moving limbs', 
  'list'
);
INSERT INTO fs
VALUES (
  14770, 
  'Arm Re', 
  'Arm right', 
  'neurology functions', 
  336, 
  'moving limbs', 
  'list'
);
INSERT INTO fs
VALUES (
  14771, 
  'Been Li', 
  'Leg left', 
  'neurology functions', 
  336, 
  'moving limbs', 
  'list'
);
INSERT INTO fs
VALUES (
  14772, 
  'Been Re', 
  'Leg right', 
  'neurology functions', 
  336, 
  'moving limbs', 
  'list'
);
INSERT INTO fs
VALUES (
  9572, 
  'Bijzonderheden', 
  'Particularities', 
  'details', 
  426, 
  'detail', 
  'freetext'
);
INSERT INTO fs
VALUES (
  15257, 
  'Cisternale drain Uit', 
  'Cisternal drain Off', 
  'fluidbalance cisternal drain', 
  685, 
  'cisternal drain', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20346, 
  'Epileptisch insult', 
  'Epileptic seizure', 
  'neurology additional', 
  684, 
  'miscellaneous', 
  'numeric'
);
INSERT INTO fs
VALUES (
  20347, 
  'Epileptisch insult (duur, minuten)', 
  'Epileptic seizure (duration, minutes)', 
  'neurology additional', 
  684, 
  'miscellaneous', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9233, 
  'Houding patiënt', 
  'Position patient', 
  'details', 
  426, 
  'miscellaneous', 
  'list'
);
INSERT INTO fs
VALUES (
  8835, 
  'Intracraniële druk', 
  'Intracranial pressure', 
  'neurology pressure', 
  334, 
  'pressure', 
  'numeric'
);
INSERT INTO fs
VALUES (
  19358, 
  'Intracraniële druk', 
  'Intracranial pressure', 
  'neurology pressure', 
  334, 
  'pressure', 
  'numeric'
);
INSERT INTO fs
VALUES (
  13940, 
  'Intracraniële druk(2)', 
  'Intracranial pressure (2)', 
  'neurology pressure', 
  334, 
  'pressure', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9360, 
  'Lumbaaldrain Uit', 
  'Lumbar drain Out', 
  'fluidbalance lumbar drain', 
  593, 
  'lumbar drain', 
  'numeric'
);
INSERT INTO fs
VALUES (
  9232, 
  'Ramsay score', 
  'Ramsay score', 
  'fluidbalance ventricular drain', 
  425, 
  'score', 
  'list'
);
INSERT INTO fs
VALUES (
  8829, 
  'Pupil Links Reactie', 
  'Pupil Left Response', 
  'neurology functions', 
  336, 
  'eye pupils', 
  'list'
);
INSERT INTO fs
VALUES (
  8830, 
  'Pupil Rechts Reactie', 
  'Pupil Right Response', 
  'neurology functions', 
  336, 
  'eye pupils', 
  'list'
);
INSERT INTO fs
VALUES (
  8832, 
  'Pupil Links Grootte', 
  'Pupil Left Size', 
  'neurology functions', 
  336, 
  'eye pupils', 
  'list'
);
INSERT INTO fs
VALUES (
  8833, 
  'Pupil Rechts Grootte', 
  'Pupil Right Size', 
  'neurology functions', 
  336, 
  'eye pupils', 
  'list'
);
INSERT INTO fs
VALUES (
  10630, 
  'Pupillen opmerkingen', 
  'Pupils comments', 
  'neurology functions', 
  336, 
  'eye pupils', 
  'freetext'
);
INSERT INTO fs
VALUES (
  15172, 
  'VAS score', 
  'Ventilated Associated Pneumonia (VAP_ score', 
  'fluidbalance ventricular drain', 
  425, 
  'score', 
  'list'
);
INSERT INTO fs
VALUES (
  14444, 
  'RASS score', 
  'RASS score', 
  'fluidbalance ventricular drain', 
  425, 
  'score', 
  'list'
);
INSERT INTO fs
VALUES (
  13495, 
  'Ventrikeldrain2 Uit', 
  'Ventricular drain2 Out', 
  'score', 
  353, 
  'ventricular drain', 
  'numeric'
);
INSERT INTO fs
VALUES (
  8770, 
  'Ventrikeldrain1 Uit', 
  'Ventricular drain1 Out', 
  'score', 
  353, 
  'ventricular drain', 
  'numeric'
);

SELECT * FROM fs;