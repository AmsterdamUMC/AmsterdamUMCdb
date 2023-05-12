<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_esicm_datathon_2023.png?raw=1" alt="Logo Datathon" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_c4i_square.png?raw=1" alt="Logo C4I" width=128px/><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo AMDS" width=128px/>

# 5th ESICM Critical Care Datathon 2023
## AmsterdamUMCdb - Freely Accessible ICU Database

version 1.0.2 March 2020  
Copyright &copy; 2003-2023 Amsterdam UMC - Amsterdam Medical Data Science

## Introduction

To make the most of your time during the datathon, access to AmsterdamUMCdb will be provided using Google BigQuery using
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

## Troubleshooting

If you run into any problem related to accessing AmsterdamUMCdb on Google BigQuery, please have a look at
the [Frequently Asked Questions](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki/bigquery#faq) on
the [AmsterdamUMCdb wiki](https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki). 
