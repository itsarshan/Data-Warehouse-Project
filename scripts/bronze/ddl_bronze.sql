/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================

Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
USE DATAWAREHOUSE
GO
IF OBJECT_ID('BRONZE.crm_cust_info','U') IS NOT NULL
   DROP TABLE BRONZE.crm_cust_info;
CREATE TABLE BRONZE.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVArCHAR(50),
    cst_material_status NVArCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE

);
IF OBJECT_ID('BRONZE.crm_PRD_info','U') IS NOT NULL
   DROP TABLE BRONZE.crm_PRD_info;
CREATE TABLE BRONZE.CRM_PRD_INFO(
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME

);
IF OBJECT_ID('BRONZE.CRM_SALES_DETAILS','U') IS NOT NULL
BEGIN
    DROP TABLE BRONZE.CRM_SALES_DETAILS;
END

CREATE TABLE BRONZE.CRM_SALES_DETAILS(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);
IF OBJECT_ID('BRONZE.ERP_CUST_AZ12','U') IS NOT NULL
   DROP TABLE BRONZE.ERP_CUST_AZ12;
CREATE TABLE BRONZE.ERP_CUST_AZ12(
    CID NVARCHAR(50),
    BDATE DATE,
    GEN NVARCHAR(50)
);
if object_id('BRONZE.ERP_LOC_A101','U') IS NOT NULL
   DROP TABLE BRONZE.ERP_LOC_A101;
CREATE TABLE BRONZE.ERP_LOC_A101(
    CID NVARCHAR(50),
    CNTRY NVARCHAR(50)
);
IF OBJECT_ID('BRONZE.ERP_PX_CAT_G1V2','U') IS NOT NULL 
  DROP TABLE  BRONZE.ERP_PX_CAT_G1V2;
CREATE TABLE BRONZE.ERP_PX_CAT_G1V2(
    ID NVARCHAR(50),
    CAT NVARCHAR(50),
    SUBCAT NVARCHAR(50),
    MAINTENANCE VARCHAR(50)
);
