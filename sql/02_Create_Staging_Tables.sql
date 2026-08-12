-- =============================================
-- Retail Sales & Inventory Analytics
-- Staging Table Creation
-- =============================================

-- 1. Staging Customers
CREATE TABLE dbo.stg_Customers
(
    CustomerID INT,
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Email NVARCHAR(255),
    Phone NVARCHAR(20),
    City NVARCHAR(100),
    CreatedDate DATE
);


-- 2. Staging Products
CREATE TABLE dbo.stg_Products
(
    ProductCode NVARCHAR(20),
    ProductName NVARCHAR(150),
    UnitPrice DECIMAL(10,2),
    StockQty INT,
    Category NVARCHAR(100)
);


-- 3. Staging Inventory
CREATE TABLE dbo.stg_Inventory
(
    ProductCode NVARCHAR(20),
    Warehouse NVARCHAR(50),
    AvailableQty INT,
    LastUpdated DATE
);


-- 4. Staging Orders
CREATE TABLE dbo.stg_Orders
(
    OrderID INT,
    CustomerID INT,
    OrderDate DATE,
    ProductCode NVARCHAR(20),
    Quantity INT,
    OrderTotal DECIMAL(10,2)
);
