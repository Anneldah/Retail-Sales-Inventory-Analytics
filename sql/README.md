# SQL Layer

The SQL layer provides the relational data storage and transformation
component of the Retail Sales & Inventory Analytics project.

## Production Tables

The project contains four production tables:

- Customers
- Products
- Inventory
- Orders

## Staging Tables

Incoming CSV data is first loaded into staging tables:

- stg_Customers
- stg_Products
- stg_Inventory
- stg_Orders

## Stored Procedures

The following stored procedures load data from staging into production:

- usp_LoadCustomers
- usp_LoadProducts
- usp_LoadInventory
- usp_LoadOrders

The procedures use MERGE statements to:

- Insert new records
- Update existing records
- Prevent duplicate source records
- Clear staging tables after successful processing
- Roll back transactions when an error occurs

## Data Flow

CSV → Blob Storage → Azure Data Factory → Staging Tables
→ Stored Procedures → Production Tables → Power BI
