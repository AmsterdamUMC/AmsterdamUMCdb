<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/datathons/2021-04-amsterdam-datathon-colab/esicm-datathon-2021.png?raw=1" alt="Logo" width=128px/>

<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo" width=128px/>

# 3rd Critical Care Datathon 2021 on AmsterdamUMCdb - Freely Accessible ICU Database

AmsterdamUMCdb version 1.0.2 March 2020  
Copyright &copy; 2003-2021 Amsterdam UMC - Amsterdam Medical Data Science

# Frequently asked questions

- [Before you begin](#Before-you-begin)
- [Error: OSError: Project was not passed and could not be determined from the environment.](#Error-OSError-Project-was-not-passed-and-could-not-be-determined-from-the-environment)
- [ERROR: 403 Access Denied: Table amsterdamumcdb-data:ams102.admissions: User does not have permission to query table](#ERROR-403-Access-Denied-Table-table_name-User-does-not-have-permission-to-query-table-table_name)
- [Error: The project your_id has not enabled BigQuery.](#error-the-project-your_id-has-not-enabled-BigQuery)

## Before you begin

Please follow the instructions in the getting_started notebook carefully: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/AmsterdamUMC/AmsterdamUMCdb/blob/master/datathons/2021-04-amsterdam-datathon-colab/getting_started.ipynb). If you make a mistake, depending on the API used to access Google BigQuery, it may be easier to fix mistakes by restarting from the beginning by selecting `Runtime` > `Restart Runtime` (`Ctrl+M .`).

## Error: OSError: Project was not passed and could not be determined from the environment

 Make sure to enter your Google Cloud Project ID into the provided text box AND run the cell to set the `PROJECT_ID` variable.

## ERROR: 403 Access Denied: Table `table_name`: User does not have permission to query table `table_name`

Most likely you are not using the Google account we have on file for the datathon. Authenticate with the Google account used during registration for the datathon. In addition, access will only be available during the datathon, unless you have applied for access during the regular procedure on [Amsterdam Medical Data Science](https://amsterdammedicaldatascience.nl/).

## Error: The project `your_id` has not enabled BigQuery

Please make sure your are actually using the Google Project ID, and not the Project Number or Project Name. For more information, see [Locate the Project ID](https://support.google.com/googleapi/answer/7014113?hl=en)
