# Data Warehouse Homework - Week 3

## Overview

This repository contains my homework submission for Week 3 of the DataTalksClub Data Warehouse course. The assignment focuses on working with the 2022 Green Taxi Trip Record Parquet Files from New York City Taxi Data.

## Files in the Repository

- `green_taxi_2022_urls.tsv`: A TSV file listing URLs to the 2022 Green Taxi Trip Record Parquet Files. This file was used to transfer Parquet files into a Google Cloud Storage bucket.
- `big_query_homework.sql`: Contains the SQL queries executed to answer the homework questions.

## Data Source

The data used for this homework is the 2022 Green Taxi Trip Record Parquet Files, which can be found at the [NYC Taxi & Limousine Commission website](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page).

## Setup Instructions

### Creating an External Table

1. Navigate to the Google Cloud Console and select your project.
2. Go to BigQuery and create a new dataset if necessary.
3. Within the dataset, create an external table pointing to the Green Taxi Trip Records Data for 2022 located in your Google Cloud Storage bucket. Use the PARQUET file format for the external table.

### Creating a Materialized Table in BigQuery

1. After setting up the external table, create a materialized table in BigQuery using the Green Taxi Trip Records for 2022.
2. Import data from the external table into the materialized table without partitioning or clustering.

## Homework Questions and SQL Queries

This section outlines the SQL queries used to answer the homework questions. The questions focused on data analysis tasks such as counting records, identifying unique pickup locations, analyzing fare amounts, and optimizing table structures for query performance.

For detailed queries and analysis, refer to the `big_query_homework.sql` file.

## Submission

The solution was submitted via the [DataTalksClub course submission form](https://courses.datatalks.club/de-zoomcamp-2024/homework/hw3).

## Notes

- It's essential to follow best practices when loading data into BigQuery and when creating external and materialized tables.
- The homework emphasizes the importance of understanding how to optimize BigQuery tables for specific query patterns.
