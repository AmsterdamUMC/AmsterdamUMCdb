<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_vu.jpg?raw=1" alt="Logo VU" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_c4i_square.png?raw=1" alt="Logo C4I" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo" width=128px/>

# Machine Learning and Reasoning for Health - Vrije Universiteit Amsterdam
## AmsterdamUMCdb - Freely Accessible ICU Database

version 1.0.2 March 2020  
Copyright &copy; 2003-2023 Amsterdam UMC - Amsterdam Medical Data Science

## Introduction
To make the most of your time during the course, access to AmsterdamUMCdb will be provided using Google BigQuery using
Google Colaboratory as the main coding environment. This removes the necessity to download AmsterdamUMCdb, setting up a
database system and installing a coding environment.

## Running Colab
Open Colab with the *AmsterdamUMCdb with Google BigQuery and Colaboratory* **getting_started** notebook from the official AmsterdamUMCdb GitHub
repository: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/bigquery/getting_started.ipynb)

## The challenges
### Track 1: “I’ve got the power”
Not over-ventilating is one of the few areas of ICU care where the evidence seems clear. However the ARDSNet dogma on restricting tidal volume was necessarily simplistic and one-size-fits-all. The concept of mechanical power (MP) has been around for a while and measures the energy delivery to the lungs dynamically. Since ventilators record the various components, you have the power too. Questions you might ask include how does MP associate with outcome? Are there subgroups of patients where MP is important? Does MP predict subsequent lung injury? Are all the components of MP the same?

### Track 2: “To transfuse, or not to transfuse? That is the question.”
We all know about the Janus face of blood transfusion: sure, carrying oxygen is good but what about the microvascular and immune effects, to mention just two? But are current trigger haemoglobin values really a magic threshold for everyone? What are the physiological effects of blood transfusion in reality? Can you predict them? Are the effects the same in everyone or do some benefit more? What about transfusions of plasma or platelets- can you discover effects of these?

### Track 3: “Fill me up”
ICU beds are precious. And expensive. So, how many do you need to make it unlikely that you will run out? The thing is that the future is inherently uncertain. Using the characteristics of the patients in the database, can you build a simulation that predicts bed occupancy? You know how long patients with different conditions tend to stay. You could pick a set of ‘imaginary' virtual patients with random lengths of stay and see how occupancy changes with time, number of beds, rate of admission. Do it lots of times and you can calculate the probabilities for these. Can you ‘design’ an ICU that has enough beds so that you only exceed capacity once a year, for example? Can you use your model to plan how many surge beds you would need in another pandemic? That would be super-useful!

### Suggestions for cohort, feature and outcome selection
#### Cohort
Mechanical ventilation: patients receiving invasive mechanical ventilation (via endotracheal tube/tracheostomy)
```
import amsterdamumcdb as adb
ventilation = adb.get_invasive_ventilation_patients(config_gbq)
```

Blood transfusion: 
> Search dictionary for: `B05AX01` (blood transfusion, filtered erythrocytes (red blood cells))

Length of stay:
> ICU length of stay: `admissions['lengthofstay']`

#### Outcomes:
Possible outcomes to predict/improve

- ICU mortality: `admissions['destination'] == 'Overleden'`
- Mortality at 30/90 days etc: `admissions['dateofdeath']`
- ICU length of stay: `admissions['lengthofstay']`
- ventilator free days at 30 days (=30 days minus each day on the ventilator, patients that die < 30 days are counted as 'on ventilator')
dd), see [Mechanical Ventilation](https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/concepts/lifesupport/mechanical_ventilation.ipynb)
- renal replacement therapy free days at 30 days (=30 days minus each day on renal replacement therapy, patients that die < 30 days are counted as 'on renal replacement therapy') 
dd), see [Renal Replacement Therapy](https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/concepts/lifesupport/renal_replacement_therapy.ipynb)
- improvement (delta) SOFA score at 48 or 72 hours (SOFA at 48/72 hours - SOFA at admission)

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
