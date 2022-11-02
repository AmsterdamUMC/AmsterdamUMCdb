<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_vu.jpg?raw=1" alt="Logo VU" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_lccci_square.png?raw=1" alt="Logo LCCCI" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo" width=128px/>

# Machine Learning and Reasoning for Health - Vrije Universiteit Amsterdam
## AmsterdamUMCdb - Freely Accessible ICU Database

version 1.0.2 March 2020  
Copyright &copy; 2003-2022 Amsterdam UMC - Amsterdam Medical Data Science

## Introduction
To make the most of your time during the course, access to AmsterdamUMCdb will be provided using Google BigQuery using
Google Colaboratory as the main coding environment. This removes the necessity to download AmsterdamUMCdb, setting up a
database system and installing a coding environment.

## Running Colab
Open Colab with the *AmsterdamUMCdb with Google BigQuery and Colaboratory* **getting_started** notebook from the official AmsterdamUMCdb GitHub
repository: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/bigquery/getting_started.ipynb)

## The challenges

### Track 1: Acute Kidney Injury: avoidable loss?
[Acute kidney injury (AKI)](https://en.wikipedia.org/wiki/Acute_kidney_injury) developed during critical illness is associated with worse outcomes. Treatment strategies are often directed at attempting to increase the perfusion of the kidneys by either intravenous fluids and/or vasopressors. However, both have known serious side-effects. Clinical questions might include: Who will get it and when? Is it avoidable? Can we reduce acute kidney injury by tailored combinations of fluids and/or vasopressors?

### Track 2: Steroids: Should I, shouldn’t I?
The debate about [steroids](https://www.whocc.no/atc_ddd_index/?code=H02AB&showdescription=yes) in sepsis and septic shock will probably go on forever. In this track, teams are asked to look at their use and impact. Questions might address issues such as how well do they actually work? When should they be started, at what dose and in who? RCTs address the population- but can you use data to address the individual?

### Track 3: Mechanical ventilation: the lower, the better?
Mechanical ventilation can be life-saving for patients suffering from respiratory failure. However, mechanical ventilation may lead to ventilator induced lung injury (VILI) so current guidelines for patients with [Acute Respiratory Distress Syndrome (ARDS)](https://en.wikipedia.org/wiki/Acute_respiratory_distress_syndrome) advice to use ventilation with low tidal volumes (6 ml/kg ideal body weight). How low can we go? Do all patients require the same low settings? Do the settings for ventilation (tidal volume/Pressure above PEEP/respiratory rate) have priority over those for oxygenation (PEEP/FIO2)?

### Suggestions for cohort, feature and outcome selection
#### Cohort
Acute kidney injury: Since the main cause of AKI in Intensive Care patients is shock, an approach would be to select all patients present with shock or develop shock with the first 24 hours of ICU admission: 
```
import amsterdamumcdb as adb
adb.get_shock_patients(config_gbq)
````
Steroids: patients with sepsis according to Sepsis-3 criteria
```
import amsterdamumcdb as adb
adb.get_sepsis_patients(config_gbq)
```
Mechanical ventilation: patients receiving invasive mechanical ventilation (via endotracheal tube/tracheostomy)
```
import amsterdamumcdb as adb
ventilation = adb.get_invasive_ventilation_patients(config_gbq)
```

#### Outcomes:
Possible outcomes to predict/improve

- ICU mortality: `admissions['destination'] == 'Overleden'`
- Mortality at 30/90 days etc: `admissions['dateofdeath']`
- ICU length of stay: `admissions['lengthofstay']`
- ventilator free days at 30 days (=30 days minus each day on the ventilator, patients that die < 30 days are counted as 'on ventilator')
dd), see [Mechanical Ventilation](https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/concepts/lifesupport/mechanical_ventilation.ipynb)
- renal replacement therapy free days at 30 days (=30 days minus each day on renal replacement therapy, patients that die < 30 days are counted as 'on renal replacement therapy') 
dd), see [Renal Replacement Therapy](https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/concepts/lifesupport/renal_replacement_therapy.ipynb)
- improvement (delta) SOFA score at 48 or 72 hours hours (SOFA at 48/72 hours - SOFA at admission)

#### Feature selection
The `amsterdamumcdb.get_dictionary()` can be used to retrieve the associated `itemid`s and table names for the following suggestions.

*Patient characteristics* 
- age: `admissions['agegroup']`
- gender: `admissions['gender']`
- weight: `admissions['weightgroup']`
- height: `admissions['heightgroup']`

*Common measurements* 
- heart rate: `76282-3`
- invasive mean arterial pressure (MAP): `76214-6`
- invasive systolic arterial pressure: `76215-3`
- invasive diastolic arterial pressure: `76213-8`
- oxygen saturation SpO2: `59408-5`
- respiratory rate monitor:	`9279-1`
- temperature: `60834-9`, `39106-0`, `76278-1`, `60836-4`, `8332-9`, `8328-7`, `415929009`

*Laboratory results*
- pH: `11558-4`
- PCO2: `11557-6`
- PO2: `11556-8`
- lactate: `32693-4`
- sodium: `2951-2`, `2947-0`
- potassium: `2823-3`, `6298-4`
- serum creatinine: `15045-8`
- glucose: `15074-8`
- hemoglobin:`59260-0`
- platelets: `26515-7`
- white blood cell count: `26464-8`

**Note**: The interpretation of blood gas analysis values requires `itemid == 11646` from `freetextitems` to determine specimen source, since reference values  differ between sample sources.
 
*Mechanical ventilation* 
- mechanical ventilation mode: `20124-4`
- positive end expiratory pressure (PEEP): `20077-4`
- inspired oxygen concentration setting (FiO2): `19994-3`
- pressure control above PEEP setting: `76152-8`
- pressure support above PEEP setting: `20079-0`
- peak inspiratory pressure: `19976-0`
- expiratory tidal volume: `20107-9`
- expiratory minute volume: `76008-2`
- respiratory rate (on ventilator): `19840-8`

*common interventions*
- fluid administration (crystalloids): `B05BB01`
- fluid administration (colloids): `B05AA06`
- blood transfusion, filtered erythrocytes (red blood cells): `B05AX01`
- antibiotics: `J01`
- corticosteroids: `H02AB`
- noradrenalin: `C01CA03`
- enoximone: `C01CE03`
- dobutamine: `C01CA07`


#### fluid balance:
  - fluid in: `drugitems['fluidin_corrected'] = drugitems[['fluidin', 'solutionadministered']].max(axis=1)` but care should be taking with drugs where `rate != 0`, since these infusions are not *instantaneous* but given over the period of `duration` minutes. 
  - fluid out: `numericitems['fluidout'] > 0`
    - urine output: `9187-6`
    
    
**Note**: see [get_fluidbalance.sql](https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/amsterdamumcdb/sql/functions/get_fluidbalance.sql) for an example of correctly calculating fluid balance for a specific time window.

## Troubleshooting

If you run into any problem related to accessing AmsterdamUMCdb on Google BigQuery, please have a look at
the [Frequently Asked Questions](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/bigquery#faq) on
the [AmsterdamUMCdb wiki](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki). 
