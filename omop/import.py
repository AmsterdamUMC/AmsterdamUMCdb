# pip install google-cloud-storage
# pip install google-cloud-bigquery
# https://cloud.google.com/sdk/docs/install
import os

# Imports the Google Cloud client library
from google.cloud import storage
from google.cloud import bigquery
from tqdm import tqdm

BILLING_PROJECT_ID = "amsterdamumcdb"
STORAGE_PROJECT_ID = "amsterdamumcdb"
DATASET_PROJECT_ID = "amsterdamumcdb"
BUCKET_NAME = "amsterdamumcdb-omop"
DATASET_ID = "version1_5_0"
LOCATION = "EU"

# Instantiates a client
storage_client = storage.Client(project=BILLING_PROJECT_ID)

# Creates the new bucket
bucket = storage_client.bucket(BUCKET_NAME)
bucket.create(location='EU')

print(f"Bucket {bucket.name} created.")

# get size of files to upload
total_size = 0
for root, dirs, files in os.walk("../data/"):
    for filename in files:
        if ".csv" in filename:
            path = os.path.join(root, filename)
            file_size = os.stat(path).st_size  # in bytes
            total_size = total_size + file_size

print(total_size)

# create two tqdm progress bars
pbar_total = tqdm(total=total_size, initial=0, desc='Uploading files',
                  dynamic_ncols=True, unit_scale=1, unit='Bytes',
                  leave=True)

for root, dirs, files in os.walk("../data/"):
    for filename in files:
        if ".csv" in filename:
            path = os.path.join(root, filename)
            file_size = os.stat(path).st_size  # in bytes
            dest = f"AmsterdamUMCdb-v1.5.0/{filename}"

            blob = bucket.blob(dest)
            with open(path, "rb") as f_in:
                with tqdm.wrapattr(f_in, "read", total=file_size, miniters=1,
                                   desc=f"Current file: {filename}") as file_obj:
                    blob.upload_from_file(
                        file_obj,
                        size=file_size,
                    )

            pbar_total.update(file_size)


# Construct a BigQuery client object.
def_config = bigquery.job.QueryJobConfig(default_dataset=DATASET_PROJECT_ID + "." + DATASET_ID)
client = bigquery.Client(project=BILLING_PROJECT_ID, location=LOCATION, default_query_job_config=def_config)


# Construct a full Dataset object to send to the API.
dataset = bigquery.Dataset(DATASET_PROJECT_ID + "." + DATASET_ID)

# Specify the geographic location where the dataset should reside.
dataset.location = LOCATION

# Send the dataset to the API for creation, with an explicit timeout.
# Raises google.api_core.exceptions.Conflict if the Dataset already
# exists within the project.
dataset = client.create_dataset(dataset, timeout=30)  # Make an API request.
print(f"Created dataset {client.project}.{dataset.dataset_id}")


# create tables using DDL
sql_filename = "./sql/ddl/bigquery.sql"
print(f"Executing DDL '{sql_filename}'...")
with open(sql_filename, 'r') as sql_file:
    sql = sql_file.read()

query_job = client.query(sql)
query_job.result()

for root, dirs, files in os.walk("../data/"):
    for filename in files:
        if ".csv" in filename:
            uri = f"gs://amsterdamumcdb-omop/AmsterdamUMCdb-v1.5.0/{filename}"

            # Set table_id to the ID of the table to create.
            table_id = f"{DATASET_ID}.{filename.split('.csv')[0]}"

            job_config = bigquery.LoadJobConfig(
                skip_leading_rows=1,

                # allow newlines inside values, e.g. for comments
                allow_quoted_newlines=True,
                # The source format defaults to CSV, so the line below is optional.
                source_format=bigquery.SourceFormat.CSV
            )

            load_job = client.load_table_from_uri(
                uri, table_id, job_config=job_config
            )  # Make an API request.

            load_job.result()  # Waits for the job to complete.
            destination_table = client.get_table(table_id)  # Make an API request.

            print(f"{table_id}: loaded {destination_table.num_rows} rows.")