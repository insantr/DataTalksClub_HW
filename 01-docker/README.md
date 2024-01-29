### 1. Start PostgreSQL and pgAdmin
To set up the PostgreSQL database and pgAdmin, use Docker Compose:
```bash
docker-compose up
```

### 2. Build the Docker Image
Build a custom Docker image for data ingestion:
```bash
docker build -t ingest_data ./
```

### 3. Ingest Data
Run the Docker container to ingest data into the PostgreSQL database.

#### Ingest `green_tripdata`:
```bash
docker run --rm ingest_data:latest --user=root --password=root --host=192.168.1.133 --port=5432 --db=ny_taxi --table_name=green_tripdata --url=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz
```

#### Ingest `taxi_zone_lookup`:
```bash
docker run --rm ingest_data:latest --user=root --password=root --host=192.168.1.133 --port=5432 --db=ny_taxi --table_name=taxi_zone_lookup --url=https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv
```

### 4. Execute SQL Queries
After ingesting data, log in to pgAdmin and run all SQL queries from the `hw_question.sql` file.
