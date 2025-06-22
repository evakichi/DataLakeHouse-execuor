# DataLakeHouse-executor
DataLakeHouse Execution system

## How to 

1. Set .env variavle.  
```
TZ="Your country's tiemzone."
DOMAIN_NAME="Your hostname"
STORAGE_SERVER_NAME="Your DataLakeHouse-storage hostname"
SPARK_CATALOG_NAME="Catalog name"
POSTGRES_PORT="Postgres port"
POSTGRES_DBNAME="set same as POSTGRES_USERNAME "
POSTGRES_USERNAME="Username for PosgreSQL."
SPARK_WAREHOUSE_NAME="Spark warehouse name."
MINIO_CLI_NGINX_PORT="Port for MinIO CLI."
SPARK_ENDPOINT_NAME="Bucket name."
POSTGRES_PASSWORD="Password for PostgreSQL."
SPARK_JUPYTER_NOTEBOOK_PORT="Jupyter notebook port."
SPARK_APPLICATION_WEB_UI_PORT="Spark web UI port."
SPARK_JOB_HISTORY_WEB_UI_PORT="Spark history web UI port."
MINIO_ROOT_USER="Admin name for MinIO."
MINIO_ROOT_PASSWORD="Admin password for MinIO."
```

2. Set following certs.
  - *Hostname (FQDN)*.crt -> selfsigned certificate. 
  - *Hostname (FQDN)*.key -> selfdigned private key(No password).
  - *Storage Server (FQDN)*.ca.crt -> selfsigned CA root certificate of storage server.

3. Run ./init.sh

4. (When you want to stop service) run ./down.sh

5. (When you want to restart service) run ./up.sh

6. (When you want to destroy service) run ./finalize.sh

7. That's it 

