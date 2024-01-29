# Terraform Project Documentation

## Overview

This Terraform project is used to create and manage infrastructure in the Google Cloud Platform (GCP) environment. It includes the following resources:

- **Google Cloud Storage Bucket**: For data storage.
- **Google BigQuery Dataset**: For analyzing large datasets.

## Structure

The project contains the following files:

- `main.tf`: The main configuration file that defines the required providers and resources.
- `variables.tf`: A file describing the variables used in `main.tf`.

## Prerequisites

Before running this project, ensure that you have Terraform installed and access to Google Cloud Platform is configured.

## Usage

To use this project, follow these steps:

1. Clone the repository.
2. Navigate to the Terraform project directory.
3. Initialize Terraform using `terraform init`.
4. Review the Terraform plan with `terraform plan`.
5. Apply the configuration using `terraform apply`.

## Variables

- `credentials`: Path to the GCP credentials file.
- `project`: GCP project identifier.
- `region`: The region where the resources will be deployed.
- `location`: Location for data storage.
- `bq_dataset_name`: Name of the BigQuery dataset.
- `gcs_bucket_name`: Name of the Google Cloud Storage bucket.
- `gcs_storage_class`: Storage class for the Google Cloud Storage bucket.

## Notes

- Ensure the Google Cloud Storage bucket name is unique.
- Location and region settings should match your requirements.
- Verify that the GCP credentials are in a secure and accessible location.

