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
   - Business Date Columns
4. Stored Procedure Naming
5. Known Data Quality Exceptions


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

Business Date Columns
- Business dates carried over from the source systems drop their table prefix when exposed in Gold, in line with the Gold renaming pattern (e.g. `cst_create_date` -> `create_date`, `prd_start_dt` -> `start_date`).
- `create_date` in `gold.dim_customers` is the customer's original creation date from the CRM source system (`silver.crm_cust_info.cst_create_date`) — it reflects when the record was first created upstream, not when it was loaded here.
- This is easy to confuse with `dwh_create_date`: `create_date` is a business date from the source, `dwh_create_date` is ETL metadata recording when this warehouse loaded the row. The two can (and normally do) have completely different values.


Stored Procedure Naming

- Procedures that load a layer follow the pattern `load_<layer>`.
  - `bronze.load_bronze` — loads raw CRM/ERP CSVs into the Bronze layer.
  - `silver.load_silver` — cleans and loads Bronze data into the Silver layer.


Known Data Quality Exceptions

These are gaps in the source data itself, not bugs in the load procedures — the pipeline surfaces them correctly rather than papering over them, so they're expected to show up on every load.

- **`gold.fact_sales.order_date` is `NULL` for 19 rows.** Their source `sls_order_dt` in `bronze.crm_sales_details` isn't a valid 8-digit date, so `silver.load_silver`'s date-cleansing logic deliberately nulls it out rather than fabricate or error on a bad value.
- **`gold.dim_products.category` / `subcategory` / `maintenance` are `NULL` for 7 rows.** Those are all pedal products (`prd_key` like `PD-M282`, `PD-R347`, etc.), whose raw CRM product key is prefixed `CO-PE-...`, extracting to category code `CO_PE`. But `erp_px_cat_g1v2` has no `CO_PE` entry — it lists Pedals under `CO_PD` instead (`CO_PD,Components,Pedals,No`). CRM and ERP simply used different abbreviations (`PE` vs `PD`) for the same category; the extraction logic works correctly for all 36 other categories, it's just faithfully surfacing this one cross-system master-data inconsistency rather than guessing at a remapping. The `LEFT JOIN` in `gold.dim_products` correctly returns `NULL` rather than dropping the products.
