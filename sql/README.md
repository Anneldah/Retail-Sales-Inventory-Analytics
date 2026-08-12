# SQL Layer

The SQL layer provides the relational data storage and transformation
component of the Retail Sales & Inventory Analytics project.

## Production Tables

The project uses four production tables:

- `Customers`
- `Products`
- `Inventory`
- `Orders`

These tables store the cleaned and processed business data used by
Power BI for reporting and analysis.

## Staging Tables

Incoming data from Azure Blob Storage is first loaded into staging tables:

- `stg_Customers`
- `stg_Products`
- `stg_Inventory`
- `stg_Orders`

The staging layer separates raw incoming data from the production tables
and allows the data to be validated and processed before being made
available for reporting.

## Stored Procedures

The following stored procedures move data from staging tables into the
production tables:

| Stored Procedure | Target Table |
|---|---|
| `usp_LoadCustomers` | `Customers` |
| `usp_LoadProducts` | `Products` |
| `usp_LoadInventory` | `Inventory` |
| `usp_LoadOrders` | `Orders` |

## Data Loading Logic

The stored procedures use the following approach:

1. Begin a database transaction.
2. Read data from the appropriate staging table.
3. Identify duplicate source records using `ROW_NUMBER()`.
4. Keep the latest record where applicable.
5. Use `MERGE` to compare staging data with production data.
6. Update existing records.
7. Insert new records.
8. Clear the staging table after a successful load.
9. Commit the transaction.
10. Roll back the transaction if an error occurs.

## Duplicate Handling

Duplicate records are handled using `ROW_NUMBER()`.

For example, customers are partitioned by:

```sql
PARTITION BY CustomerID
