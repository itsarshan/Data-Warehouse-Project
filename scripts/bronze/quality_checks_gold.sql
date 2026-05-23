/*
==========================================================
Quality Checks - Gold Layer
==========================================================

Purpose:
This script validates the integrity and consistency
of Gold Layer tables.

Checks Included:
- Duplicate surrogate keys
- Null keys
- Referential integrity
- Relationship validation

==========================================================
*/

-- ======================================================
-- Check gold.dim_customers
-- ======================================================

-- Check duplicate customer keys
SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- ======================================================
-- Check gold.dim_products
-- ======================================================

-- Check duplicate product keys
SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- ======================================================
-- Check Referential Integrity
-- ======================================================

-- Fact table customer keys missing in dimension
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;


-- Fact table product keys missing in dimension
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL;
