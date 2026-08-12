-- =============================================
-- Retail Sales & Inventory Analytics
-- Production Table Creation
-- =============================================

-- 1. Customers
CREATE TABLE dbo.Customers
(
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) NULL,
    City NVARCHAR(100) NULL,
    CreatedDate DATE NULL
);


-- 2. Products
CREATE TABLE dbo.Products
(
    ProductCode NVARCHAR(20) PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    StockQty INT NOT NULL,
    Category NVARCHAR(100) NULL
);


-- 3. Inventory
CREATE TABLE dbo.Inventory
(
    ProductCode NVARCHAR(20) NOT NULL,
    Warehouse NVARCHAR(50) NOT NULL,
    AvailableQty INT NOT NULL,
    LastUpdated DATE NOT NULL,

    CONSTRAINT PK_Inventory
    PRIMARY KEY(ProductCode, Warehouse)
);


-- 4. Orders
CREATE TABLE dbo.Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    ProductCode NVARCHAR(20) NOT NULL,
    Quantity INT NOT NULL,
    OrderTotal DECIMAL(10,2) NOT NULL
);
