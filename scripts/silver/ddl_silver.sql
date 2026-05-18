/*
===========================================================
DDL Script: Create Silver Tables
===========================================================

Purpose:
This script creates tables in the silver schema.

The silver layer contains cleaned and transformed data
from the bronze layer.

===========================================================
*/USE DATAWAREHOUSE;
GO

IF OBJECT_ID('silver.crm_cust_info','U') IS NOT NULL
   DROP TABLE silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.CRM_PRD_INFO','U') IS NOT NULL
   DROP TABLE silver.CRM_PRD_INFO;
CREATE TABLE silver.CRM_PRD_INFO(
    prd_id INT,
    cat_id NVARCHAR(50),
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.CRM_SALES_DETAILS','U') IS NOT NULL
    DROP TABLE silver.CRM_SALES_DETAILS;
CREATE TABLE silver.CRM_SALES_DETAILS(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,          -- ✅ Fix 1
    sls_order_dt DATE,        -- ✅ Fix 2
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.ERP_CUST_AZ12','U') IS NOT NULL
   DROP TABLE silver.ERP_CUST_AZ12;
CREATE TABLE silver.ERP_CUST_AZ12(
    CID NVARCHAR(50),
    BDATE DATE,
    GEN NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.ERP_LOC_A101','U') IS NOT NULL
   DROP TABLE silver.ERP_LOC_A101;
CREATE TABLE silver.ERP_LOC_A101(
    CID NVARCHAR(50),
    CNTRY NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.ERP_PX_CAT_G1V2','U') IS NOT NULL
   DROP TABLE silver.ERP_PX_CAT_G1V2;
CREATE TABLE silver.ERP_PX_CAT_G1V2(
    ID NVARCHAR(50),
    CAT NVARCHAR(50),
    SUBCAT NVARCHAR(50),
    MAINTENANCE VARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
