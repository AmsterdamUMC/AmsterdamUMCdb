<img src="../../img/logo_amds.png" alt="Logo" height="128px"/>

# AmsterdamUMCdb - Freely Accessible ICU Database
version 1.0.2 March 2020  
Copyright &copy; 2003-2020 Amsterdam UMC - Amsterdam Medical Data Science

# Severity Scores
This folder contains code to calculate ICU severity of ilness scores. 

## APACHE II
The Acute Physiology and Chronic Health Evaluation (APACHE) APACHE II is a severity-of-ilness scoring and mortality predicting system (Knaus et al., 1985) based on the first 24 hours of ICU admission. It was superseded by APACHE IV (Zimmerman et al., 2006), though it continued to be in use for historical comparison for quite some time.

The scoring system uses physiologic variables (part A), Age point (part B) and Chronic Health Points (part C). The Chronic Health Points-calculation has currently not been implemented because they have not been documented consistently. The code performs some data cleanup and calculates the score for all patients in database. 

## Sequential Organ Failure Assessment (SOFA)
The sequential organ failure assessment score (SOFA score), originally published as as the Sepsis-related Organ Failure Assessment score ([Vincent et al., 1996](http://link.springer.com/10.1007/BF01709751)), is a disease severity score designed to track the severity of critical ilness throughout the ICU stay. In contrast to APACHE (II/IV), which only calculates a score for the first 24 hours, it can be used sequentially for every following day. The code performs some data cleanup and calculates the SOFA score for the first 24 hours of ICU admission for all patients in the database.
