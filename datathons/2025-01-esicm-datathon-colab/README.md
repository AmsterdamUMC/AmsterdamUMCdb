<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_esicm_datathon_2025.jpg?raw=1" alt="Logo Datathon" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_c4i_square.png?raw=1" alt="Logo C4I" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo AMDS" width=128px/>

# 7th ESICM Critical Care Datathon 2025
## AmsterdamUMCdb - Freely Accessible ICU Database

version 1.5.0 May 2024  
Copyright &copy; 2003-2025 Amsterdam UMC - Amsterdam Medical Data Science

## Introduction

To make the most of your time during the datathon, access to AmsterdamUMCdb will be provided using Google BigQuery using
Google Colaboratory as the main coding environment. This removes the necessity to download AmsterdamUMCdb, setting up a
database system and installing a coding environment. 

To improve reusability of the data and code, AmsterdamUMCdb will be made available in the OMOP Common Data Model format. To get a head start, you may want to have a look [here](https://www.ohdsi.org/data-standardization/).

## Running Colab

Open Colab with the *AmsterdamUMCdb with Google BigQuery and Colaboratory* **getting_started** notebook from the official AmsterdamUMCdb GitHub
repository: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/bigquery/getting_started.ipynb)

## The challenges

### Track 1 - Digital twins
Digital twins are creating a buzz and for good reason as they may inform us how to treat their physical counterparts - your intensive care patients (!) - in real time. However, there is often much confusion on what digital twins really are, and how they can be developed for the specific context of intensive care medicine. Therefore, we challenge you to create what you think is a digital twin or a component of a digital twin. For inspiration, you might think of developing a reinforcement learning model to guide treatment choices for circulatory or respiratory failure. Or perhaps improve a physiological model of circulation or ventilation with real world data? Can large language models play a role here? Or perhaps something completely different. The choice is yours!

### Track 2 - Real world evidence
Clinical trials are important pillars of evidence based medicine. However, they are very resource intensive and often either too narrow or too wide. If they are too narrow, the results may not apply to the patient you have in front of you. If they are too wide their findings also fail to provide guidance because of heterogeneity between included patients. This is where data science techniques leveraging large-scale real-world data can provide valuable insights.Therefore we challenge you to use data to generate the evidence you need to inform your practice. You could think of attempting to replicate a well known trial in a real world population, using target trial emulation. Or you could investigate whether routine interventions work better or worse or equally in specific patients or circumstances. Or you might determine individual treatment effects for established treatment strategies. Up to you!


## Troubleshooting

If you run into any problem related to accessing AmsterdamUMCdb on Google BigQuery, please have a look at
the [Frequently Asked Questions](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/bigquery#faq) on
the [AmsterdamUMCdb wiki](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki). 
