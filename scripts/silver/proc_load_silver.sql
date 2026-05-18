/*
===========================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===========================================================

Purpose:
This stored procedure loads cleaned and transformed data
from the bronze schema into the silver schema.

Actions Performed:
- Truncates silver tables
- Cleans and transforms raw data
- Inserts transformed data into silver tables

Usage:
EXEC silver.load_silver;

===========================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME,
            @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '================================================';

        PRINT '------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '------------------------------------------------';

        -- Loading bronze.crm_cust_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>> Inserting Data Into: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM '/var/opt/mssql/data/datasets/source_crm/cust_info.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Loading bronze.CRM_PRD_INFO
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.CRM_PRD_INFO';
        TRUNCATE TABLE bronze.CRM_PRD_INFO;
        PRINT '>> Inserting Data Into: bronze.CRM_PRD_INFO';
        BULK INSERT bronze.CRM_PRD_INFO
        FROM '/var/opt/mssql/data/datasets/source_crm/prd_info.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Loading bronze.CRM_SALES_DETAILS
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.CRM_SALES_DETAILS';
        TRUNCATE TABLE bronze.CRM_SALES_DETAILS;
        PRINT '>> Inserting Data Into: bronze.CRM_SALES_DETAILS';
        BULK INSERT bronze.CRM_SALES_DETAILS
        FROM '/var/opt/mssql/data/datasets/source_crm/SALES_DETAILS.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        PRINT '------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '------------------------------------------------';

        -- Loading bronze.ERP_CUST_AZ12
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.ERP_CUST_AZ12';
        TRUNCATE TABLE bronze.ERP_CUST_AZ12;
        PRINT '>> Inserting Data Into: bronze.ERP_CUST_AZ12';
        BULK INSERT bronze.ERP_CUST_AZ12
        FROM '/var/opt/mssql/data/datasets/source_erp/CUST_AZ12.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Loading bronze.ERP_LOC_A101
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.ERP_LOC_A101';
        TRUNCATE TABLE bronze.ERP_LOC_A101;
        PRINT '>> Inserting Data Into: bronze.ERP_LOC_A101';
        BULK INSERT bronze.ERP_LOC_A101
        FROM '/var/opt/mssql/data/datasets/source_erp/LOC_A101.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Loading bronze.ERP_PX_CAT_G1V2
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.ERP_PX_CAT_G1V2';
        TRUNCATE TABLE bronze.ERP_PX_CAT_G1V2;
        PRINT '>> Inserting Data Into: bronze.ERP_PX_CAT_G1V2';
        BULK INSERT bronze.ERP_PX_CAT_G1V2
        FROM '/var/opt/mssql/data/datasets/source_erp/PX_CAT_G1V2.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        SET @batch_end_time = GETDATE();
        PRINT '================================================';
        PRINT 'Bronze Layer Loaded Successfully!';
        PRINT 'Total Batch Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '================================================';

    END TRY
    BEGIN CATCH
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END

EXEC bronze.load_bronze;
