/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start DATETIME, @batch_end DATETIME;
    BEGIN TRY
        PRINT '========================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '========================================';

        -- BATCH START TIME
        SET @batch_start = GETDATE();

        -- CRM CUST INFO
        SET @start_time = GETDATE();
        TRUNCATE TABLE BRONZE.crm_cust_info;
        BULK INSERT BRONZE.crm_cust_info
        FROM '/var/opt/mssql/data/datasets/source_crm/cust_info.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '-->> CRM_CUST_INFO Loaded: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

        -- CRM PRD INFO
        SET @start_time = GETDATE();
        TRUNCATE TABLE BRONZE.CRM_PRD_INFO;
        BULK INSERT BRONZE.CRM_PRD_INFO
        FROM '/var/opt/mssql/data/datasets/source_crm/prd_info.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '-->> CRM_PRD_INFO Loaded: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

        -- CRM SALES DETAILS
        SET @start_time = GETDATE();
        TRUNCATE TABLE BRONZE.CRM_SALES_DETAILS;
        BULK INSERT BRONZE.CRM_SALES_DETAILS
        FROM '/var/opt/mssql/data/datasets/source_crm/SALES_DETAILS.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '-->> CRM_SALES_DETAILS Loaded: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

        -- ERP CUST AZ12
        SET @start_time = GETDATE();
        TRUNCATE TABLE BRONZE.ERP_CUST_AZ12;
        BULK INSERT BRONZE.ERP_CUST_AZ12
        FROM '/var/opt/mssql/data/datasets/source_erp/CUST_AZ12.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '-->> ERP_CUST_AZ12 Loaded: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

        -- ERP LOC A101
        SET @start_time = GETDATE();
        TRUNCATE TABLE BRONZE.ERP_LOC_A101;
        BULK INSERT BRONZE.ERP_LOC_A101
        FROM '/var/opt/mssql/data/datasets/source_erp/LOC_A101.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '-->> ERP_LOC_A101 Loaded: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

        -- ERP PX CAT G1V2
        SET @start_time = GETDATE();
        TRUNCATE TABLE BRONZE.ERP_PX_CAT_G1V2;
        BULK INSERT BRONZE.ERP_PX_CAT_G1V2
        FROM '/var/opt/mssql/data/datasets/source_erp/PX_CAT_G1V2.csv'
        WITH(FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '-->> ERP_PX_CAT_G1V2 Loaded: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

        -- BATCH END TIME
        SET @batch_end = GETDATE();

        PRINT '========================================';
        PRINT 'BRONZE LAYER LOADED SUCCESSFULLY!';
        PRINT 'TOTAL BATCH DURATION: ' + CAST(DATEDIFF(second,@batch_start,@batch_end) AS NVARCHAR) + ' seconds';
        PRINT '========================================';

    END TRY
    BEGIN CATCH
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END
