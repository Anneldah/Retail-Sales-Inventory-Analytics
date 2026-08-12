-- =============================================
-- Retail Sales & Inventory Analytics
-- Orders Data Load Procedure
-- =============================================

CREATE OR ALTER PROCEDURE dbo.usp_LoadOrders
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        ;WITH SourceData AS
        (
            SELECT
                OrderID,
                CustomerID,
                OrderDate,
                ProductCode,
                Quantity,
                OrderTotal,
                ROW_NUMBER() OVER
                (
                    PARTITION BY OrderID
                    ORDER BY OrderDate DESC
                ) AS rn
            FROM dbo.stg_Orders
        )

        MERGE dbo.Orders AS Target
        USING
        (
            SELECT
                OrderID,
                CustomerID,
                OrderDate,
                ProductCode,
                Quantity,
                OrderTotal
            FROM SourceData
            WHERE rn = 1
        ) AS Source
        ON Target.OrderID = Source.OrderID

        WHEN MATCHED THEN
            UPDATE SET
                Target.CustomerID = Source.CustomerID,
                Target.OrderDate = Source.OrderDate,
                Target.ProductCode = Source.ProductCode,
                Target.Quantity = Source.Quantity,
                Target.OrderTotal = Source.OrderTotal

        WHEN NOT MATCHED BY TARGET THEN
            INSERT
            (
                OrderID,
                CustomerID,
                OrderDate,
                ProductCode,
                Quantity,
                OrderTotal
            )
            VALUES
            (
                Source.OrderID,
                Source.CustomerID,
                Source.OrderDate,
                Source.ProductCode,
                Source.Quantity,
                Source.OrderTotal
            );

        -- Clear staging table after successful load
        TRUNCATE TABLE dbo.stg_Orders;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH
END;
GO
