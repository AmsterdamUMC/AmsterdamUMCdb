<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_vu.jpg?raw=1" alt="Logo VU" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_c4i_square.png?raw=1" alt="Logo C4I" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo" width=128px/>

# Machine Learning and Reasoning for Health - Vrije Universiteit Amsterdam
## AmsterdamUMCdb - Freely Accessible ICU Database

version 1.5.0 May 2024
Copyright &copy; 2003-2025 Amsterdam UMC - Amsterdam Medical Data Science

## Introduction
To make the most of your time during the course, access to AmsterdamUMCdb will be provided using Google BigQuery using
Google Colaboratory as the main coding environment. This removes the necessity to download AmsterdamUMCdb, setting up a
database system and installing a coding environment.

## Running Colab
Open Colab with the *AmsterdamUMCdb with Google BigQuery and Colaboratory* **getting_started** notebook from the official AmsterdamUMCdb GitHub
repository: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/bigquery/getting_started.ipynb)

## Tracks

### Acute Kidney Injury

#### What is Acute Kidney Injury?
The kidneys are vital organs responsible for filtering waste from the blood, regulating fluid levels, balancing electrolytes, and maintaining blood pressure. Acute Kidney Injury (AKI) is a sudden decline in kidney function, which can happen quickly and may be temporary or permanent. AKI is common among ICU patients due to the stress their bodies undergo during severe illness, trauma, or surgery.

#### Why is AKI Important in the ICU?
AKI can have a serious impact on patient outcomes, often leading to longer ICU stays, increased costs, and a higher risk of death. Preventing or treating AKI effectively can improve recovery and decrease complications. However, AKI is tricky to predict and prevent because many factors, such as blood pressure changes, medications, or infections, contribute to its development.

#### What Causes AKI?
AKI can be caused by several factors, such as:
- **Low blood pressure**: When blood pressure drops, less blood flows to the kidneys, which can cause kidney cells to suffer and eventually stop working.
- **Medications**: Some drugs, especially those used to fight infections (antibiotics) or treat heart conditions, can be harmful to the kidneys if not monitored carefully.
- **Infections**: Sepsis, a severe infection spreading throughout the body, can disrupt kidney function as the body redirects resources to fight the infection.

#### How is AKI Treated?
- **Fluids**: Giving fluids through an IV (intravenous) line can help raise blood pressure and improve blood flow to the kidneys.
- **Vasopressors**: These medications are used to increase blood pressure. However, both fluids and vasopressors come with risks. Too much fluid can lead to swelling and strain on other organs, while vasopressors can reduce blood flow to certain areas if used excessively.

#### Potential Research Questions
- Can machine learning predict which patients are at risk of developing AKI based on ICU admission data?
- What clinical factors contribute most significantly to AKI onset, and can they be modified to reduce risk?
- Are there patient-specific predictors that could guide fluid vs. vasopressor treatment decisions?
- Can ML models predict AKI reversibility? Which factors indicate whether AKI will be temporary or permanent, and how can these be leveraged to guide treatment?
- Is it possible to create a real-time AKI risk score? Can continuous patient monitoring data be used to dynamically assess AKI risk throughout an ICU stay?

### Optimal Treatment Strategies for Septic Shock

#### What is Septic Shock?
Sepsis is a dangerous condition where an infection triggers an extreme immune response, leading to inflammation throughout the body. Septic Shock is the most severe stage of sepsis, in which a patient’s blood pressure drops to dangerously low levels. This drop in blood pressure can prevent vital organs like the brain, heart, and kidneys from getting enough oxygen.

#### Why is Septic Shock Challenging to Treat?
In septic shock, the patient’s body is overwhelmed by the infection and immune response, causing blood vessels to expand (dilate) and blood pressure to fall. This is a life-threatening condition that requires immediate treatment to prevent multiple organ failure. However, the best way to treat septic shock is still debated in medicine.

#### How is Septic Shock Treated?
- **Fluids**: Doctors often start by giving fluids to fill blood vessels and increase pressure, helping maintain blood flow to organs.
- **Vasopressors**: If fluids aren’t enough, vasopressors are given to tighten blood vessels and raise blood pressure. However, both treatments have risks, and finding the right balance is a challenge.

#### Controversies in Treatment
There is no universally agreed-upon approach for septic shock treatment. Some patients may respond better to fluids, while others need vasopressors. Too much fluid can overload the heart and lungs, whereas too much vasopressor can reduce blood flow to certain parts of the body.

#### Potential Research Questions
- How do we know which treatment will work best? Machine learning can help identify patterns in patient data to predict who will respond better to fluids or vasopressors.
- What are the best treatment thresholds? By analyzing historical data, you can help define when it’s best to start vasopressors and in which dosage, and how much fluid to give.
- What patient characteristics predict a favorable response to early fluid administration? Can we identify specific patient subgroups who benefit most from fluids versus vasopressors?
- What combination of treatments is most effective in reducing mortality? Are there synergistic effects between fluids, vasopressors, and other treatments like steroids or antibiotics?

### Extubation

#### What is Extubation?

Extubation is the removal of a breathing tube after a period of mechanical ventilation. It marks the transition from machine-supported breathing back to patient-controlled breathing and is a pivotal step in ICU recovery.

#### Why is Extubation Hard in the ICU?

Extubating too early risks respiratory failure and reintubation, which is painful, costly, and linked to worse outcomes. Extubating too late prolongs sedation and ventilation, increases complications (e.g., delirium, ventilator-associated-pneumonia risk, muscle weakness), and delays recovery. The window for “just right” is narrow and patient-specific.

#### How Is Readiness Assessed?

Clinicians combine physiology and trajectory:

* Gas exchange and workload: oxygenation (e.g., FiO₂/positive end-expiratory pressure), minute ventilation, respiratory rate, tidal volume, PaCO₂ trends.
* Reserve and mechanics: spontaneous breathing trial (SBT) performance, rapid shallow breathing index, cough strength, cuff-leak, airway protection.
* Global stability: hemodynamics, sedation level (e.g., RASS), delirium, ongoing procedures, secretion burden.

#### Potential Research Questions

* Can a prediction model estimate extubation success within 24–72 hours using routinely collected ICU data?
* Which features (levels and trends) most strongly predict failure and reintubation, and how do they vary across subgroups?
* Can we build a real-time “readiness” score that updates with new vitals, blood gases, and ventilator settings?
* Can reinforcement learning learn a safe “extubate now vs. wait” policy, and does it outperform clinician-timed extubation in off-policy evaluation?
* What is the net clinical benefit of model-assisted extubation decisions when accounting for reintubation harms and prolonged ventilation costs?


## Database

### Possible cohorts
- Sepsis patients
- Shock patients
- General ICU patients

### Possible Outcomes
- Occurrence of AKI 1-3 according to KDIGO guidelines
- Necessity of renal replacement therapy
- Necessity of reintubation 
- In-hospital or in-ICU mortality
- ICU length-of-stay

### Features

#### Patient Characteristics
- Age
- Gender
- Weight
- Height

#### Common Vital Signs Measurements
- Heart rate
- Invasive mean arterial pressure
- Invasive systolic arterial pressure
- Invasive diastolic arterial pressure
- Oxygen saturation (SpO2)
- Respiratory rate
- Temperature

#### Common Lab Results

- **Kidney Function**
  - Serum creatinine: Indicates kidney function and filtration capacity
  - Blood Urea Nitrogen (BUN): Helps assess kidney function and hydration status

- **Electrolytes**
  - Sodium
  - Potassium
  - Chloride
  - Magnesium

- **Arterial Blood Gasses (ABGs)**
  - pH: Indicates acid-base status of the blood
  - Partial pressure of Oxygen (PaO2): Reflects oxygen levels in the blood; low levels indicate hypoxemia
  - Partial pressure of Carbon Dioxide (PaCO2): Indicates how well carbon dioxide is being removed from the body
  - Bicarbonate (HCO3-): Part of the body’s buffering system to maintain pH balance
  - Oxygen saturation (SaO2): Percentage of hemoglobin saturated with oxygen

- **Hematology**
  - Complete Blood Count (CBC)
    - White Blood Cells (WBC): Indicates infection, inflammation or immune response
    - Hemoglobin: Reflects the blood’s oxygen-carrying capacity
    - Hematocrit: Measures the proportion of red blood cells in the blood
    - Platelets: Important for blood clotting; low levels increase bleeding risk
  - Coagulation studies
    - Prothrombin Time (PT) and International Normalized Ratio (INR): Measure clotting ability, particularly in patients on blood thinners
    - Activated Partial Thromboplastin Time (aPTT): Assesses blood’s ability to clot, often used to monitor heparin therapy
    - Fibrinogen: A protein essential for clot formation; low levels suggest a bleeding risk or disseminated intravascular coagulation (DIC)

- **Liver Function Tests**
  - Aspartate Aminotransferase (AST) and Alanine Aminotransferase (ALT): Enzymes that indicate liver cell injury
  - Alkaline Phosphatase: High levels suggest bile duct or liver issues
  - Bilirubin: Byproduct of red blood cell breakdown; high levels indicate liver dysfunction or bile flow issues
  - Albumin: A protein produced by the liver; low levels may indicate liver dysfunction, malnutrition or general illness
  - Lactate Dehydrogenase (LDH): Elevated in liver injury and tissue breakdown

- **Inflammatory Markers**
  - C-reactive Protein (CRP): A general marker of inflammation; high levels suggest infection or inflammation

- **Endocrine Function**
  - Glucose
  - Thyroid Function Tests (T3, T4, TSH)

#### Mechanical Ventilation Parameters
- Mechanical ventilator mode
- Positive end expiratory pressure (PEEP)
- Inspired oxygen concentration setting
- Pressure control above PEEP setting
- Pressure support above PEEP setting
- Peak inspiratory pressure
- Expiratory tidal volume
- Expiratory minute volume
- Respiratory rate (on ventilator)

#### Common Medications
- Fluid administration (crystalloids)
- Fluid administration (colloids)
- Blood transfusion, filtered erythrocytes (red blood cells)
- Vasopressors
- Sedatives
- Antibiotics
- Corticosteroids
- Noradrenaline
- Enoximone
- Dobutamine

#### Fluid Balance
- Fluid in
- Fluid out
  - Urine output

## Troubleshooting

If you run into any problem related to accessing AmsterdamUMCdb on Google BigQuery, please have a look at
the [Frequently Asked Questions](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/bigquery#faq) on
the [AmsterdamUMCdb wiki](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki). 
