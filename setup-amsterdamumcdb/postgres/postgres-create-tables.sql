DROP TABLE IF EXISTS admissions CASCADE;
CREATE TABLE admissions 
(
    patientid INTEGER,
    admissionid serial PRIMARY KEY,
    admissioncount INTEGER,
    location VARCHAR,
    urgency BIT,
    origin VARCHAR,
    admittedat BIGINT,
    admissionyeargroup VARCHAR,
    dischargedat BIGINT,
    lengthofstay SMALLINT,
    destination VARCHAR,
    gender VARCHAR,
    agegroup VARCHAR,
    dateofdeath BIGINT,
    weightgroup VARCHAR,
    weightsource VARCHAR,
    lengthgroup VARCHAR,
    lengthsource VARCHAR,
    specialty VARCHAR
);

DROP TABLE IF EXISTS drugitems CASCADE;
CREATE TABLE drugitems 
(
    admissionid INTEGER,
    orderid BIGINT,
    ordercategoryid INTEGER,
    ordercategory VARCHAR,
    itemid INTEGER,
    item VARCHAR,
    isadditive BIT,
    isconditional BIT,
    rate FLOAT,
    rateunit VARCHAR,
    rateunitid INTEGER,
    ratetimeunitid INTEGER,
    doserateperkg BIT,
    dose FLOAT,
    doseunit VARCHAR,
    doserateunit VARCHAR,
    doseunitid INTEGER,    
    doserateunitid INTEGER,
    administered FLOAT,
    administeredunit VARCHAR,
    administeredunitid INTEGER,
    action VARCHAR,
    start BIGINT,
    stop BIGINT,
    duration BIGINT,
    solutionitemid INTEGER,
    solutionitem VARCHAR,
    solutionadministered FLOAT,
    solutionadministeredunit VARCHAR,
    fluidin FLOAT,
    iscontinuous BIT
);

DROP TABLE IF EXISTS freetextitems CASCADE;
CREATE TABLE freetextitems 
(
    admissionid INTEGER,
    itemid BIGINT,
    item VARCHAR,
    value VARCHAR,
    comment VARCHAR,
    measuredat BIGINT,
    registeredat BIGINT,
    registeredby VARCHAR,
    updatedat BIGINT,
    updatedby VARCHAR,
    islabresult BIT
);

DROP TABLE IF EXISTS listitems CASCADE;
CREATE TABLE listitems 
(
    admissionid INTEGER,
    itemid BIGINT,
    item VARCHAR,
    valueid INT,
    value VARCHAR,
    measuredat BIGINT,
    registeredat BIGINT,
    registeredby VARCHAR,
    updatedat BIGINT,
    updatedby VARCHAR,
    islabresult BIT
);

DROP TABLE IF EXISTS numericitems CASCADE;
CREATE TABLE numericitems 
(
    admissionid INTEGER,
    itemid BIGINT,
    item VARCHAR,
    tag VARCHAR,
    value FLOAT,
    unitid INT,
    unit VARCHAR,
    comment VARCHAR,
    measuredat BIGINT,
    registeredat BIGINT,
    registeredby VARCHAR,
    updatedat BIGINT,
    updatedby VARCHAR,
    islabresult BIT,
    fluidout FLOAT
);

DROP TABLE IF EXISTS procedureorderitems CASCADE;
CREATE TABLE procedureorderitems 
(
    admissionid INTEGER,
    orderid BIGINT,
    ordercategoryid INT,
    ordercategoryname VARCHAR,
    itemid INT,
    item VARCHAR,
    registeredat BIGINT,
    registeredby VARCHAR
);

DROP TABLE IF EXISTS processitems CASCADE;
CREATE TABLE processitems 
(
    admissionid INTEGER,
    itemid BIGINT,
    item VARCHAR,
    start BIGINT,
    stop BIGINT,
    duration BIGINT
);