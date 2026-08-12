-- =============================================
-- Retail Sales & Inventory Analytics
-- Inventory Data Load Procedure
-- =============================================

CREATE OR ALTER PROCEDURE dbo.usp_LoadInventory
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
                Warehouse,
                AvailableQty,
                LastUpdated,
                ROW_NUMBER() OVER
                (
                    PARTITION BY ProductCode, Warehouse
                    ORDER BY LastUpdated DESC
                ) AS rn
            FROM dbo.stg_Inventory
        )

        MERGE dbo.Inventory AS Target
        USING
        (
            SELECT
                ProductCode,
                Warehouse,
                AvailableQty,
                LastUpdated
            FROM SourceData
            WHERE rn = 1
        ) AS Source
        ON Target.ProductCode = Source.ProductCode
        AND Target.Warehouse = Source.Warehouse

        WHEN MATCHED THEN
            UPDATE SET
                Target.AvailableQty = Source.AvailableQty,
                Target.LastUpdated = Source.LastUpdated

        WHEN NOT MATCHED BY TARGET THEN
            INSERT
            (
                ProductCode,
                Warehouse,
                AvailableQty,
                LastUpdated
            )
            VALUES
            (
                Source.ProductCode,
                Source.Warehouse,
                Source.AvailableQty,
                Source.LastUpdated
            );

        -- Clear staging table after successful load
        TRUNCATE TABLE dbo.stg_Inventory;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
