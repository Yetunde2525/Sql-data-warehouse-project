Naming Conventions

This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in this data warehouse.

Table of Contents

1. General Principles
2. Table Naming Conventions
   - Bronze Rules
   - Silver Rules
   - Gold Rules
3. Column Naming Conventions
   - Surrogate Keys
   - Technical Columns
4. Stored Procedure Naming


General Principles

- Schemas, tables, views, and columns use snake_case: lowercase letters with underscores (`_`) separating words.
- All names are in English.
- SQL reserved words are avoided as object names.


Table Naming Conventions

Bronze Rules
- Table names start with the source system name and keep the same shape as the source table, since Bronze is a raw, as-is copy.
- Pattern: `<sourcesystem>_<entity>`
  - `<sourcesystem>`: the originating system (`crm`, `erp`).
  - `<entity>`: the entity/table name as it appears in the source system.
  - Examples: `bronze.crm_cust_info`, `bronze.crm_prd_info`, `bronze.crm_sales_details`, `bronze.erp_cust_az12`, `bronze.erp_loc_a101`, `bronze.erp_px_cat_g1v2`.

Silver Rules
- Table names mirror their Bronze counterpart 1:1, since Silver only cleans and standardizes the same entities — it doesn't rename or restructure them.
- Pattern: `<sourcesystem>_<entity>` (identical to Bronze)
  - Examples: `silver.crm_cust_info`, `silver.crm_prd_info`, `silver.crm_sales_details`, `silver.erp_cust_az12`, `silver.erp_loc_a101`, `silver.erp_px_cat_g1v2`.

Gold Rules
- Gold objects are views, named for their business role rather than their source system.
- Pattern: `<category>_<entity>`
  - `<category>`: role of the object — `dim` for a dimension, `fact` for a fact table.
  - `<entity>`: business-aligned name of the entity (`customers`, `products`, `sales`).
  - Examples: `gold.dim_customers`, `gold.dim_products`, `gold.fact_sales`.


Column Naming Conventions

Surrogate Keys
- Surrogate keys in Gold dimension tables use the suffix `_key`.
- Pattern: `<entity>_key`
  - Examples: `customer_key` in `gold.dim_customers`, `product_key` in `gold.dim_products`.

Technical Columns
- System-generated metadata columns are prefixed with `dwh_`.
- Pattern: `dwh_<column_name>`
  - Example: `dwh_create_date` — the DATETIME2 column, defaulted to `GETDATE()`, recording when a row was loaded into the Silver layer.


Stored Procedure Naming

- Procedures that load a layer follow the pattern `load_<layer>`.
  - `bronze.load_bronze` — loads raw CRM/ERP CSVs into the Bronze layer.
  - `silver.load_silver` — cleans and loads Bronze data into the Silver layer.
