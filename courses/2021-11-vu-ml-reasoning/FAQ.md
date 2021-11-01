<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/courses/2021-11-vu-ml-reasoning/vu.jpg?raw=1" alt="Logo" width=128px/>

<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo" width=128px/>

# Machine Learning and Reasoning for Health - Vrije Universiteit Amsterdam
## AmsterdamUMCdb - Freely Accessible ICU Database

AmsterdamUMCdb version 1.0.2 March 2020  
Copyright &copy; 2003-2021 Amsterdam UMC - Amsterdam Medical Data Science

# Frequently asked questions

- [Before you begin](#before-you-begin)
- [Error: OSError: Project was not passed and could not be determined from the environment.](#project-not-passed)
- [ERROR: 403 Access Denied: Project `project_name`: User does not have bigquery.jobs.create permission in project `project_name`](#denied-job-permission).
- [ERROR: 403 Access Denied: Table `table_name`: User does not have permission to query table `table_name`](#denied-query-permission)
- [Error: The project your_id has not enabled BigQuery.](#bigquery-not-enabled)

<a id="before-you-begin"></a>
## Before you begin

Please follow the instructions in the getting_started notebook carefully: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/courses/2021-11-vu-ml-reasoning/getting_started.ipynb). If you make a mistake, depending on the API used to access Google BigQuery, it may be easier to fix mistakes by restarting from the beginning by selecting `Runtime` > `Restart Runtime` (`Ctrl+M .`).

<a id="project-not-passed"></a>
## Error: OSError: Project was not passed and could not be determined from the environment

Make sure to enter your Google Cloud Project ID into the provided text box AND run the cell to set the `PROJECT_ID` variable.

<a id="denied-job-permission"></a>
## ERROR:403 Access Denied: Project `project_name`: User does not have bigquery.jobs.create permission in project `project_name`

Please make sure your are actually using the Google Project ID, and not the Project Number or Project Name. For more information, see [Locate the Project ID](https://support.google.com/googleapi/answer/7014113?hl=en).

<a id="denied-query-permission"></a>
## ERROR: 403 Access Denied: Table `table_name`: User does not have permission to query table `table_name`

Most likely you are not using the Google account we have on file for the course. Authenticate with the Google account used during registration for the course. Verify that the e-mail address used when registering for the course has been associated with this account. If you already have a Google account, you can add secondary e-mail adresses [here](https://myaccount.google.com/alternateemail), or alternatively create another Google account using the e-mail adress used during registration of the course. In addition, access will only be available during the course, unless you have applied for access during the regular procedure on [Amsterdam Medical Data Science](https://amsterdammedicaldatascience.nl/).

<a id="bigquery-not-enabled"></a>
## Error: The project `your_id` has not enabled BigQuery

Please make sure your are actually using the Google Project ID, and not the Project Number or Project Name. For more information, see [Locate the Project ID](https://support.google.com/googleapi/answer/7014113?hl=en)