# Technical Documentation

## Technology Architecture

The project combines cloud data services, database technologies and business intelligence tools.

### Azure Blob Storage

Used as the landing location for raw CSV files.

### Azure Data Factory

Used for data ingestion and pipeline orchestration.

### Azure SQL Database

Used to store structured data and support SQL-based transformations.

### SQL

T-SQL was used for:

- Data validation
- Data transformation
- Duplicate handling
- Insert and update operations
- Stored procedures
- Data processing

### Power BI

Used for:

- Data modelling
- DAX calculations
- Interactive reporting
- KPI visualisation
- Business analysis

### GitHub

Used for version control and project documentation.

## Data Processing Approach

The project follows a layered approach:

### Raw Layer

Contains the original CSV source data.

### Staging Layer

Temporarily stores incoming data before validation and transformation.

### Production Layer

Contains cleaned and structured data that is ready for reporting.

### Reporting Layer

Power BI consumes the processed data and presents it through interactive dashboards.

## Duplicate Handling

Duplicate records can affect reporting accuracy.

To address this, duplicate records were identified during the SQL processing stage.

`ROW_NUMBER()` was used to identify duplicate records where required, allowing the appropriate record to be retained before loading the production dataset.

## Stored Procedures

Stored procedures were used to centralise data processing logic.

The procedures support the movement and transformation of data between staging and production tables.

This approach improves consistency and reduces the need to manually execute multiple SQL statements.

## Error Handling and Troubleshooting

During development, issues were investigated by reviewing:

- Pipeline execution results
- SQL errors
- Source data
- Target table data
- Data types
- Duplicate records
- Transformation logic

Problems were resolved by tracing the data through each stage of the pipeline.

## Security Considerations

Sensitive or personally identifiable information should not be stored in a public GitHub repository.

The portfolio project uses non-sensitive datasets suitable for demonstrating the technical solution.

Credentials, passwords, connection strings and access keys should never be committed to GitHub.

## Key Skills Demonstrated

This project demonstrates practical experience in:

- Data ingestion
- ETL development
- Azure Data Factory
- Azure Blob Storage
- Azure SQL
- SQL and T-SQL
- Stored procedures
- Data cleansing
- Data validation
- Data modelling
- Power BI
- DAX
- Business intelligence
- Cloud data solutions
- Data pipeline troubleshooting
- Git and GitHub
