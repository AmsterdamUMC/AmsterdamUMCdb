/*
Load data from CSV file into tables
*/
-- modify `data_dir` to directory where data files locates
-- \cd :data_dir

SET CLIENT_ENCODING TO 'WIN1252';

-- admissions table
\copy admissions FROM 'admissions.csv' DELIMITER ',' CSV HEADER NULL ''
-- drugitems table
\copy drugitems FROM 'drugitems.csv' DELIMITER ',' CSV HEADER NULL ''
-- freetextitems
\copy freetextitems FROM 'freetextitems.csv' DELIMITER ',' CSV HEADER NULL ''
-- listitems
\copy listitems FROM 'listitems.csv' DELIMITER ',' CSV HEADER NULL ''
-- numericitems
\copy numericitems FROM 'numericitems.csv' DELIMITER ',' CSV HEADER NULL ''
-- procedureorderitems
\copy procedureorderitems FROM 'procedureorderitems.csv' DELIMITER ',' CSV HEADER NULL ''
-- processitems
\copy processitems FROM 'processitems.csv' DELIMITER ',' CSV HEADER NULL ''