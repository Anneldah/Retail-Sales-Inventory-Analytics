-- =============================================
-- Retail Sales & Inventory Analytics
-- Customer Data Load Procedure
-- =============================================

CREATE OR ALTER PROCEDURE dbo.usp_LoadCustomers
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        ;WITH SourceData AS
        (
            SELECT
                CustomerID,
                FirstName,
                LastName,
                Email,
                Phone,
                City,
                CreatedDate,
                ROW_NUMBER() OVER
                (
                    PARTITION BY CustomerID
                    ORDER BY CreatedDate DESC
                ) AS rn
            FROM dbo.stg_Customers
        )

        MERGE dbo.Customers AS Target
        USING
        (
            SELECT
                CustomerID,
                FirstName,
                LastName,
                Email,
                Phone,
                City,
                CreatedDate
            FROM SourceData
            WHERE rn = 1
        ) AS Source
        ON Target.CustomerID = Source.CustomerID

        WHEN MATCHED THEN
            UPDATE SET
                Target.FirstName = Source.FirstName,
                Target.LastName = Source.LastName,
                Target.Email = Source.Email,
                Target.Phone = Source.Phone,
                Target.City = Source.City,
                Target.CreatedDate = Source.CreatedDate

        WHEN NOT MATCHED BY TARGET THEN
            INSERT
            (
                CustomerID,
                FirstName,
                LastName,
                Email,
                Phone,
                City,
                CreatedDate
            )
            VALUES
            (
                Source.CustomerID,
                Source.FirstName,
                Source.LastName,
                Source.Email,
                Source.Phone,
                Source.City,
                Source.CreatedDate
            );

        -- Clear staging table after a successful load
        TRUNCATE TABLE dbo.stg_Customers;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
