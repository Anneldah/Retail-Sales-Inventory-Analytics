# Data Pipeline Documentation

## Overview

The data pipeline is responsible for moving raw CSV data from the source location into a structured SQL database where it can be transformed and consumed by Power BI.

Azure Data Factory was used to orchestrate the movement of data through the different stages of the pipeline.

## Pipeline Flow

CSV Files
↓
Azure Blob Storage
↓
Azure Data Factory
↓
Staging Tables
↓
Data Validation
↓
Data Transformation
↓
Production Tables
↓
Power BI

## Step 1 – Source Data

The project starts with CSV files containing customer, product, order and inventory information.

The files represent raw source data and are stored in the project's `data` folder for documentation and reproducibility.

## Step 2 – Azure Blob Storage

The CSV files were uploaded to Azure Blob Storage.

Blob Storage was used as the landing area for the raw source data before processing.

## Step 3 – Azure Data Factory

Azure Data Factory was used to create and orchestrate the data pipelines.

The pipelines were responsible for connecting to the source files, extracting the data and loading it into the SQL environment.

## Step 4 – Staging Tables

Incoming data was first loaded into staging tables.

The staging layer provides an intermediate area where data can be checked and processed before being loaded into production tables.

## Step 5 – Data Validation and Transformation

The data was validated and transformed using SQL.

The transformation process included:

- Duplicate record handling
- Data validation
- Data cleansing
- Data type handling
- Record matching
- Insert and update processing

SQL stored procedures were used to process the incoming data.

## Step 6 – Production Tables

After validation and transformation, the processed data was loaded into production tables.

The production tables provide a clean and structured dataset for reporting and analysis.

## Step 7 – Power BI

Power BI was connected to the processed SQL data.

The data was modelled and used to create interactive dashboards and visualisations.

## Automation

Pipeline triggers can be used to automate data processing and reduce the need for manual execution.

This demonstrates how a repeatable ETL process can be implemented for ongoing reporting.

## Monitoring and Troubleshooting

During development, pipeline and data issues were investigated by checking:

- Pipeline execution status
- Source data
- SQL errors
- Data load results
- Duplicate records
- Transformation logic

This helped ensure that the final reporting dataset was reliable.
