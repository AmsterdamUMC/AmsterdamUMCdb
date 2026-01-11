## <img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_esicm_datathon_2025.jpg?raw=1" alt="Logo Datathon" width=128px/>
<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_c4i_square.png?raw=1" alt="Logo C4I" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo AMDS" width=128px/>

# 8th ESICM Critical Care Datathon 2026
## AmsterdamUMCdb - Freely Accessible ICU Database

version Van Gogh 2026.01  
Copyright &copy; 2003-2026 Amsterdam UMC - Amsterdam Medical Data Science

## Introduction

To make the most of your time during the datathon, access to AmsterdamUMCdb will be provided using Google BigQuery using
Google Colaboratory as the main coding environment. This removes the necessity to download AmsterdamUMCdb, setting up a
database system and installing a coding environment. 

To improve reusability of the data and code, AmsterdamUMCdb will be made available in the OMOP Common Data Model format. To get a head start, you may want to have a look [here](https://www.ohdsi.org/data-standardization/).

## Running Colab

Open Colab with the *AmsterdamUMCdb with Google BigQuery and Colaboratory* **getting_started** notebook from the official AmsterdamUMCdb GitHub
repository: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/bigquery/getting_started_v2.ipynb)

## The challenges

### Track 1 - Personalized mechanical ventilation
We all know mechanical ventilation is life saving but also potentially lung damaging. Are our current standard settings right for everyone? Can you predict how a given combination of PEEP, FiO2, tidal volume and mode will affect an individual patient, or do some benefit much more than others? Dive into real ICU data to untangle these relationships and get closer to truly personalized mechanical ventilation.

### Track 2 - Deterioration and stabilisation
Low blood pressure, desaturation, rising lactate, and low pH are key signs of deterioration that we want to predict early. Their causes, and therefore the best next steps, differ across patients. Can you forecast impending deterioration and estimate the likely impact of actions such as fluids, vasoactive drugs, and ventilator or oxygen setting changes? Choose a clinical scenario and a short-term (minutes to hours) or long-term (days) prediction window, and ideally make it actionable with expected response trajectories and recommendations on what to try next.

## Troubleshooting

If you run into any problem related to accessing AmsterdamUMCdb on Google BigQuery, please have a look at
the [Frequently Asked Questions](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/bigquery#faq) on
the [AmsterdamUMCdb wiki](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki). 
