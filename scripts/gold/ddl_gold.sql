/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================

Script Purpose:
    This script creates views for the Gold layer in the data warehouse.
    The Gold layer represents the final dimension and fact tables
    designed using a Star Schema model.

    Each view performs transformations and combines data from the Silver
    layer to generate clean, enriched, and business-ready datasets
    for analytics and reporting purposes.

Usage:
    - These views can be queried directly for reporting and analytics.
    - Used by BI tools, dashboards, and data analysts.
===============================================================================
*/

-- =============================================================================
-- Create Customer Dimension View
-- =============================================================================

CREATE VIEW gold.dim_customers AS

SELECT
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,

    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,

    la.cntry AS country,

    ci.cst_marital_status AS marital_status,

    CASE
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
        ELSE COALESCE(ca.gen, 'n/a')
    END AS gender,

    ca.bdate AS birthdate,

    ci.cst_create_date AS create_date

FROM silver.crm_cust_info ci

LEFT JOIN silver.erp_cust_az12 ca
    ON ci.cst_key = ca.cid

LEFT JOIN silver.erp_loc_a101 la
    ON ci.cst_key = la.cid;

-- =============================================================================
-- View Customer Dimension Data
-- =============================================================================

SELECT *
FROM gold.dim_customers;
