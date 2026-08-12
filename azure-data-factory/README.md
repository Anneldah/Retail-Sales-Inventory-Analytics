# Azure Data Factory

Azure Data Factory (ADF) was used to build the data ingestion and automation layer of the Retail Sales & Inventory Analytics project.

## Purpose

The Azure Data Factory pipelines automate the movement of CSV data from Azure Blob Storage into Azure SQL Database.

The solution uses staging tables and stored procedures to safely load and update production tables.

## Architecture

The data flow follows this process:

CSV Files
   ↓
Azure Blob Storage
   ↓
Azure Data Factory
   ↓
Staging Tables
   ↓
Stored Procedures
   ↓
Production SQL Tables
   ↓
Power BI

## Azure Resources

The project uses the following Azure services:

- Azure Storage Account
- Azure Blob Storage
- Azure Data Factory
- Azure SQL Database
- Power BI

## Data Sources

The source data consists of CSV files containing:

- Customers
- Products
- Inventory
- Orders

The CSV files are stored in Azure Blob Storage and are used as the source for the ADF pipelines.

## Pipelines

Four main ingestion pipelines were created:

| Pipeline | Source | Destination | Purpose |
|---|---|---|---|
| Customers Pipeline | Blob Storage | SQL Staging | Load customer data |
| Products Pipeline | Blob Storage | SQL Staging | Load product data |
| Inventory Pipeline | Blob Storage | SQL Staging | Load inventory data |
| Orders Pipeline | Blob Storage | SQL Staging | Load order data |

## Data Loading Process

Each pipeline follows the same general process:

1. Read CSV files from Azure Blob Storage.
2. Copy the data into the appropriate SQL staging table.
3. Execute the corresponding SQL stored procedure.
4. The stored procedure validates and merges the staging data into the production table.
5. Existing records are updated when required.
6. New records are inserted.
7. Duplicate source records are handled using `ROW_NUMBER()`.
8. The staging table is truncated after a successful load.

## Staging Tables

Staging tables were created to separate incoming data from the production tables.

The staging tables include:

- `dbo.stg_Customers`
- `dbo.stg_Products`
- `dbo.stg_Inventory`
- `dbo.stg_Orders`

This approach allows the incoming data to be processed before it is merged into the production tables.

## Stored Procedures

The following stored procedures are used to load the production tables:

- `dbo.usp_LoadCustomers`
- `dbo.usp_LoadProducts`
- `dbo.usp_LoadInventory`
- `dbo.usp_LoadOrders`

The procedures use `MERGE` statements to:

- Insert new records
- Update existing records
- Prevent duplicate source records from causing merge errors
- Clear staging data after a successful transaction

## Error Handling

The stored procedures use:

- `TRY...CATCH`
- Transactions
- `SET XACT_ABORT ON`
- `ROLLBACK`
- `THROW`

This ensures that if a loading operation fails, the transaction can be rolled back rather than leaving partially loaded data.

## Pipeline Dependencies

The pipelines were configured with dependencies so that the data loading process can run in the correct sequence.

The successful completion of an upstream activity is required before the next dependent activity executes.

## Automation

Azure Data Factory provides the orchestration layer for the solution.

The pipeline design allows new CSV data to be processed through the same ingestion and SQL loading process without manually inserting records into the production tables.

## Key Learning Outcomes

This part of the project provided practical experience with:

- Azure Data Factory
- Azure Blob Storage
- Azure SQL Database
- Linked Services
- Datasets
- Copy Data activities
- Pipeline dependencies
- Stored procedure activities
- Data staging
- ETL/ELT concepts
- Error handling
- Automated data ingestion

## Project Outcome

Azure Data Factory successfully connects the cloud-based file storage layer with the SQL database layer, creating an automated data ingestion process that feeds the Power BI reporting layer.
