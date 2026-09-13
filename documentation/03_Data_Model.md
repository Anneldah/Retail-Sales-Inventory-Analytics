# Data Model Documentation

## Overview

The data model was designed to create relationships between customers, products, orders and inventory data.

The objective was to create a structured model that could support accurate analysis and reporting in Power BI.

## Main Tables

### Customers

Contains information about customers and their locations.

Example fields include:

- Customer ID
- Customer Name
- City
- Customer details

### Products

Contains information about products available for sale.

Example fields include:

- Product ID
- Product Name
- Category
- Price

### Orders

Contains customer sales and order transactions.

Example fields include:

- Order ID
- Customer ID
- Product ID
- Order Date
- Quantity
- Sales Amount

### Inventory

Contains information about product stock levels.

Example fields include:

- Product ID
- Stock Quantity
- Inventory information

## Relationships

The main relationships between the datasets are based on customer and product identifiers.

Customers
|
| Customer ID
↓
Orders
|
| Product ID
↓
Products
|
| Product ID
↓
Inventory

These relationships allow sales and inventory information to be analysed together.

## Data Quality

Data quality was considered during the ETL process.

The project included logic to identify and handle duplicate records before loading data into the production tables.

SQL functions such as `ROW_NUMBER()` were used where required to identify duplicate records.

## Data Transformation

Stored procedures were used to process data between staging and production tables.

The transformation process supported:

- Insert operations
- Update operations
- Duplicate handling
- Data validation
- Data consistency

## Power BI Data Model

The processed SQL data was connected to Power BI.

Relationships were established between the relevant tables to allow users to analyse:

- Revenue
- Orders
- Average Order Value
- Product performance
- Customer locations
- Inventory levels

The resulting model provides a structured foundation for business intelligence reporting.
