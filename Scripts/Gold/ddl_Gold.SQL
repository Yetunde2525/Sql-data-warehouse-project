/*
================================================================================
DDL Script: Create Gold Views
================================================================================

Script Purpose:
    This script creates views for the Gold layer in the data warehouse.
    The Gold layer represents the final dimension and fact tables (Star Schema).

    Each view performs transformations and combines data from the Silver layer
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
================================================================================
*/

-- ============================================================================
-- Create Dimension: gold.dim_customers
-- ============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY c.cst_id) AS customer_key,
    c.cst_id AS customer_id,
    c.cst_key AS customer_number,
    c.cst_firstname AS first_name,
    c.cst_lastname AS last_name,
    l.cntry AS country,
    c.cst_marital_status AS marital_status,
    COALESCE(e.gen, c.cst_gndr) AS gender,
    e.bdate AS birthdate,
    c.cst_create_date AS create_date
FROM Silver.crm_cust_info c
LEFT JOIN Silver.erp_cust_az12 e
    ON c.cst_key = e.cid
LEFT JOIN Silver.erp_loc_a101 l
    ON c.cst_key = l.cid;
GO


-- ============================================================================
-- Dimension: gold.dim_products
-- ============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY p.prd_key) AS product_key,
    p.prd_key AS product_id,
    p.prd_nm AS product_name,
    p.prd_cost AS cost,
    p.prd_line AS product_line,
    c.cat AS category,
    c.subcat AS subcategory,
    p.prd_start_dt AS start_date,
    p.prd_end_dt AS end_date
FROM Silver.crm_prd_info p
LEFT JOIN Silver.erp_px_cat_g1v2 c
    ON p.prd_key = c.id;
GO


-- ============================================================================
-- Fact: gold.fact_sales
-- ============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT
    s.sls_ord_num AS order_number,
    dp.product_key,
    dc.customer_key,

    -- Convert INT dates if needed (handling inconsistent schema)
    TRY_CONVERT(DATE, s.sls_order_dt) AS order_date,
    TRY_CONVERT(DATE, s.sls_ship_dt) AS shipping_date,
    TRY_CONVERT(DATE, s.sls_due_dt) AS due_date,

    s.sls_sales AS sales_amount,
    s.sls_quantity AS quantity,
    s.sls_price AS price
FROM Silver.crm_sales_details s
LEFT JOIN gold.dim_customers dc
    ON s.sls_cust_id = dc.customer_id
LEFT JOIN gold.dim_products dp
    ON s.sls_prd_key = dp.product_id;
GO
