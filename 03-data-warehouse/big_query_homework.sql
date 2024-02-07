-- dataset name: terraform-demo-412714.green_taxi_2022

-- Create an external table using the Green Taxi Trip Records Data for 2022.
CREATE OR REPLACE EXTERNAL TABLE `terraform-demo-412714.green_taxi_2022.tripdata_external`
    OPTIONS (
    format = 'parquet',
    uris = ['gs://terraform-demo-412714-terra-bucket/green_taxi_2022/d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-*.parquet']
    );


-- Create a table in BQ using the Green Taxi Trip Records for 2022 (do not partition or cluster this table).
CREATE OR REPLACE TABLE terraform-demo-412714.green_taxi_2022.tripdata_materialized AS
SELECT *
FROM terraform-demo-412714.green_taxi_2022.tripdata_external;


-- Q1: Question 1: What is count of records for the 2022 Green Taxi Data??
select count(*)
from terraform-demo-412714.green_taxi_2022.tripdata_materialized; -- 840402


-- Q2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
-- What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?
select count(distinct PULocationID)
from terraform-demo-412714.green_taxi_2022.tripdata_external; -- 0B
select count(distinct PULocationID)
from terraform-demo-412714.green_taxi_2022.tripdata_materialized; -- 6.41MB


-- Q3: How many records have a fare_amount of 0?
select count(*)
from terraform-demo-412714.green_taxi_2022.tripdata_materialized
where fare_amount = 0;
-- 1622


-- Q4: What is the best strategy to make an optimized table in Big Query if your query will always order
-- the results by PUlocationID and filter based on lpep_pickup_datetime? (Create a new table with this strategy)
-- A: Partition by lpep_pickup_datetime Cluster on PUlocationID
CREATE OR REPLACE TABLE terraform-demo-412714.green_taxi_2022.tripdata_partitoned_clustered
    PARTITION BY DATE (lpep_pickup_datetime)
    CLUSTER BY PUlocationID AS
SELECT *
FROM terraform-demo-412714.green_taxi_2022.tripdata_materialized;


-- Q5: Write a query to retrieve the distinct PULocationID
-- between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
-- Use the materialized table you created earlier in your from clause and note the estimated bytes.
-- Now change the table in the from clause to the partitioned table you created for question 4 and
-- note the estimated bytes processed. What are these values?
select count(distinct PULocationID)
from terraform-demo-412714.green_taxi_2022.tripdata_materialized
where lpep_pickup_datetime between '2022-06-01' and '2022-06-30'; -- 12.82MB
select count(distinct PULocationID)
from terraform-demo-412714.green_taxi_2022.tripdata_partitoned_clustered
where lpep_pickup_datetime between '2022-06-01' and '2022-06-30'; -- 1.12MB
