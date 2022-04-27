<img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_lccci_square.png?raw=1" alt="Logo LCCCI" width=128px><img src="https://github.com/AmsterdamUMC/AmsterdamUMCdb/blob/master/img/logo_amds.png?raw=1" alt="Logo AMDS" width=128px/>

# AmsterdamUMCdb - Freely Accessible ICU Database
version 1.0.2 March 2020  
Copyright &copy; 2003-2020 Amsterdam UMC - Amsterdam Medical Data Science

# Setup AmsterdamUMCdb
## Requirements
- Access to the AmsterdamUMCdb csv files: request access from [Amsterdam Medical Data Science](https://www.amsterdammedicaldatascience.nl/).
- Operating system: any OS capable of running Python and PostgreSQL, including Windows, macOS and Linux.
- Internal memory: 8GB should suffice for basic analysis and running the Jupyter notebooks. However, the recommended memory specification to run both PostgreSQL and the Jupyter Notebooks on the same machine is 16-32 GB.
- Disk space: Downloading and extracting the database files will require 110 GB of hard disk space. In addition, creating the SQL database requires about 128 GB of hard disk space and and an additional 144 GB for creating the indices to improve query performance. 

## 1. Install a Python distribution
We **strongly recommend** installing Python using Anaconda, a popular distribution that includes many useful modules for data science out-of-the-box. Install the (latest) Python 3.7 version distribution from [Anaconda's](https://www.anaconda.com/distribution) distribution page.

## 2. Install PostgreSQL
PostgreSQL is an open source database management system (DBMS), available for most operating systems, including Windows, macOS and Linux. We recommend the installation of the most recent version of PostgreSQL (version 12) from the PostgreSQL [download](https://www.postgresql.org/download/) page. Please note your password for the `postgres` superuser, and if you did not chose `postgres` as the password, you need to modify these settings in the [`config.SAMPLE.ini`](https://github.com/AmsterdamUMC/AmsterdamUMCdb/tree/master/config.SAMPLE.ini) file in the root of the repository. Save the file as [`config.ini`](https://github.com/AmsterdamUMC/AmsterdamUMCdb/tree/master/config.ini).

## 3. Install psycopg2 module
To connect to your postgreSQL server from Python, the [psycopg2](https://pypi.org/project/psycopg2/) package needs to be installed from the Anaconda Prompt/Shell using conda:

> conda install -c anaconda psycopg2
## 4. Clone the AmsterdamUMCdb GitHub respository
Clone or download the [AmsterdamUMCdb](https://github.com/AmsterdamUMC/AmsterdamUMCdb) repository from GitHub. 
Follow the instructions on GitHub's online step-by-step guide, if needed: https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository. 

## 5. Download the database files
Download the AmsterdamUMCdb zip file from and extract the files from the zip file to the `data` folder of the cloned AmsterdamUMCdb repository.

## 6. Create database tables
Start Jupyter notebook server from the command line (using Command Prompt on Windows or Terminal on Mac/Linux) by running:

> jupyter notebook

From the Jupyter file browser, open the `setup-amsterdamumc.ipynb` file from the `setup-amsterdamumc` folder in the cloned repository. The code in the notebook assumes there is a default postgres installation with a dabase named `postgres`, user `postgres` with password `postgres`. You should change these settings in the [`config.SAMPLE.ini`](https://github.com/AmsterdamUMC/AmsterdamUMCdb/tree/master/config.SAMPLE.ini) file in the root of the repository and save the file as [`config.ini`].
To create the tables in the database run this Jupyter notebook, either cell by cell (▶️ Run) to see what's happening, or use the ⏩ button to to automatically perform all steps. An `amsterdamumc` [schema](https://www.postgresql.org/docs/12/ddl-schemas.html) will be created, and all tables will be added to this schema.

## 7. Verify the database
After the notebook has been run completely, the postgres database should contain all tables with the same number of records we released. The output should state `Verification: PASSED`.
 
## 8. Create database table indices
It's highly recommended to create some useful indices to improve performance for common queries on identifiers like admissionid, itemid and measured times. 

## 9. Jupyter Notebooks
While the indices are being created, the postgreSQL should be available for querying using the notebooks in the [`tables`](https://github.com/AmsterdamUMC/AmsterdamUMCdb/tree/master/tables) folder (with lower performance). We use  plotly (version >4) for interactive plots in some notebooks. Plotly can be installed by 
using conda:

> conda install -c plotly plotly

The `amsterdamumcdb` package contains some utility functions used in the Notebooks. The package can be installed from the Python Package Index respository (PiPy) by running:

> pip install amsterdamumcdb

or if you intend to actively develop the package use (replace `~/AmsterdamUMCdb` with the actual location of the cloned repository):

> pip install -e ~/AmsterdamUMCdb/
