-- =============================================
-- Retail Sales & Inventory Analytics
-- Products Data Load Procedure
-- =============================================

CREATE OR ALTER PROCEDURE dbo.usp_LoadProducts
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        ;WITH SourceData AS
        (
            SELECT
                ProductCode,
                ProductName,
                UnitPrice,
                StockQty,
                Category,
                ROW_NUMBER() OVER
                (
                    PARTITION BY ProductCode
                    ORDER BY ProductCode
                ) AS rn
            FROM dbo.stg_Products
        )

        MERGE dbo.Products AS Target
        USING
        (
            SELECT
                ProductCode,
                ProductName,
                UnitPrice,
                StockQty,
                Category
            FROM SourceData
            WHERE rn = 1
        ) AS Source
        ON Target.ProductCode = Source.ProductCode

        WHEN MATCHED THEN
            UPDATE SET
                Target.ProductName = Source.ProductName,
                Target.UnitPrice = Source.UnitPrice,
                Target.StockQty = Source.StockQty,
                Target.Category = Source.Category

        WHEN NOT MATCHED BY TARGET THEN
            INSERT
            (
                ProductCode,
                ProductName,
                UnitPrice,
                StockQty,
                Category
            )
            VALUES
            (
                Source.ProductCode,
                Source.ProductName,
                Source.UnitPrice,
                Source.StockQty,
                Source.Category
            );

        -- Clear staging table after successful load
        TRUNCATE TABLE dbo.stg_Products;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH
END;
GO
