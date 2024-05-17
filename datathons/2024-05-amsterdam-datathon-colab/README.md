<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_esicm_datathon_2024.png?raw=1" alt="Logo Datathon" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_c4i_square.png?raw=1" alt="Logo C4I" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo AMDS" width=128px/>

# 6th ESICM Critical Care Datathon 2024
## AmsterdamUMCdb - Freely Accessible ICU Database

version 1.5.0 May 2024
Copyright &copy; 2003-2024 Amsterdam UMC - Amsterdam Medical Data Science

## Introduction

To make the most of your time during the datathon, access to AmsterdamUMCdb will be provided using Google BigQuery using
Google Colaboratory as the main coding environment. This removes the necessity to download AmsterdamUMCdb, setting up a
database system and installing a coding environment. 

To improve reusability of the data and code, AmsterdamUMCdb will be made available in the OMOP Common Data Model format. To get a head start, you may want to have a look [here](https://www.ohdsi.org/data-standardization/).

## Running Colab

Open Colab with the *AmsterdamUMCdb with Google BigQuery and Colaboratory* **getting_started** notebook from the official AmsterdamUMCdb GitHub
repository: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/bigquery/getting_started.ipynb)

## The challenges

# Track 1 - To transfuse or not to transfuse? That is the question
- We all know about the Janus face of blood transfusion
  * Oxygen carriage vs microvascular and immune consequences
  * Restrictive transfusion thresholds are en vogue but does one size fit everyone?
- Questions you might ask
  * Do current Hb thresholds work for everyone? Or can you find sub-groups where this could be individualised?
  * Do all patients respond the same to transfusion? Physiologically? Immunologically?
  * What about other blood products? Platelets or plasma?

# Track 2 - The true value of blood gases
- Blood gases are common and data-rich!
  * Does it matter?
- Questions to consider include (but not limited to)
  * Ok, you ventilate protectively. Do you care about acidaemia at all? Should you care (and how much)? 
  * Are there blood gas phenotypes? Can you model their trajectories?
  * Can you validate acid-base physiology? How strong are strong ions? Is albumin key? Or does it not matter?
  * Don’t forget glucose (measured as part of routine blood gas analysis in our database): just another target or marker of metabolic stress?

# Track 3 - ICUr type: phenotypes from data
- We measure blood pressure, urine output, blood gases, ventilatory parameters. What does it mean?
  * Can you find meaningful similarities between patients in the data?
- Questions include
  * Can you find phenotypes (clusters of similar patients) from the data? 
  * How do phenotypes evolve over time? Are there temporal phenotypes?
  * Are they plausible biologically?
  * Do different phenotypes respond differently to targets or treatment strategies?

## Troubleshooting

If you run into any problem related to accessing AmsterdamUMCdb on Google BigQuery, please have a look at
the [Frequently Asked Questions](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/bigquery#faq) on
the [AmsterdamUMCdb wiki](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki). 
