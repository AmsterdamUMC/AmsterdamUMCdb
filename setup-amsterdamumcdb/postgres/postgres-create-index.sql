CREATE INDEX admissions_admissionid_index ON admissions (admissionid);
CREATE INDEX admissions_patientid_index ON admissions (patientid);

-- drugitems table
CREATE INDEX drugitems_admissionid_index ON drugitems (admissionid);
CREATE INDEX drugitems_orderid_index ON drugitems (orderid);
CREATE INDEX drugitems_ordercategoryid_index ON drugitems (ordercategoryid);
CREATE INDEX drugitems_itemid_index ON drugitems (itemid);
CREATE INDEX drugitems_start_index ON drugitems (start);
CREATE INDEX drugitems_stop_index ON drugitems (stop);

-- freetextitems table
CREATE INDEX freetextitems_admissionid_index ON freetextitems (admissionid);
CREATE INDEX freetextitems_itemid_index ON freetextitems (itemid);
CREATE INDEX freetextitems_measuredat_index ON freetextitems (measuredat);

-- listitems table
CREATE INDEX listitems_admissionid_index ON listitems (admissionid);
CREATE INDEX listitems_itemid_index ON listitems (itemid);
CREATE INDEX listitems_measuredat_index ON listitems (measuredat);

-- numericitems table
CREATE INDEX numericitems_admissionid_index ON numericitems (admissionid);
CREATE INDEX numericitems_itemid_index ON numericitems (itemid);
CREATE INDEX numericitems_measuredat_index ON numericitems (measuredat);
CREATE INDEX numericitems_admission_item_time_index ON numericitems (admissionid, itemid, measuredat);
CREATE INDEX numericitems_islabresult_index ON numericitems (islabresult);
CREATE INDEX numericitems_fluidout_index ON numericitems (fluidout);

-- procedureorderitems table
CREATE INDEX procedureorderitems_admissionid_index ON procedureorderitems (admissionid);
CREATE INDEX procedureorderitems_itemid_index ON procedureorderitems (itemid);
CREATE INDEX procedureorderitems_ordercategoryid_index ON procedureorderitems (ordercategoryid);
CREATE INDEX procedureorderitems_registeredat_index ON procedureorderitems (registeredat);

-- processitems table
CREATE INDEX processitems_admissionid_index ON processitems (admissionid);
CREATE INDEX processitems_itemid_index ON processitems (itemid);
CREATE INDEX processitems_start_index ON processitems (start);
CREATE INDEX processitems_stop_index ON processitems (stop);