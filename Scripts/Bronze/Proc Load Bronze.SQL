
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -
Description:
    Loads raw CRM and ERP data into Bronze layer tables using BULK INSERT.
    - Truncates tables before load
    - Tracks execution time per table and overall batch

Parameters:
     None.
This stored procedure does not accept any parameters or return any values 

Usage Examples:
EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
		AS
		BEGIN
		DECLARE @START_TIME DATETIME, @END_TIME DATETIME,@Batch_start_time DATETIME, @Batch_end_time DATETIME;
		BEGIN TRY
		SET @Batch_start_time = GETDATE();
		PRINT ' ==============================================================';
		PRINT 'Loading Bronze layer...'
		PRINT ' ==============================================================';


		PRINT '---------------------------------------------------------------';
		PRINT 'Loading CRM Tables...';
		PRINT '---------------------------------------------------------------';
		
		SET @START_TIME = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_cust_info';
		 TRUNCATE TABLE bronze.crm_cust_info;

		 PRINT '>>Inserting Table :bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\yetun\Sql-data-warehouse-project\Datasets\source_crm\cust_info.csv'
			WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @END_TIME = GETDATE();
			PRINT '>>Time taken to load bronze.crm_cust_info: ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) +' seconds';
		SET @START_TIME = GETDATE();
			PRINT '>>Truncating Table: bronze.crm_prd_info';
		 TRUNCATE TABLE bronze.crm_prd_info;
		 PRINT '>>Inserting Table :bronze.crm_prd_info';
		 BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\yetun\Sql-data-warehouse-project\Datasets\source_crm\prd_info.csv'
			WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @END_TIME = GETDATE();
			PRINT '>>Time taken to load bronze.crm_prd_info: ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' seconds';
		SET @START_TIME = GETDATE();
			PRINT '>>Truncating Table: bronze.crm_sales_details';
		 TRUNCATE TABLE bronze.crm_sales_details;
		 PRINT '>>Inserting Table :bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\yetun\Sql-data-warehouse-project\Datasets\source_crm\sales_details.csv'
			WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @END_TIME = GETDATE();
			PRINT '>>Time taken to load bronze.crm_sales_details: ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' seconds';
		PRINT '---------------------------------------------------------------';
		PRINT 'Loading ERP TABLES...';
		PRINT '---------------------------------------------------------------';
		
		SET @START_TIME = GETDATE();
			PRINT '>>Truncating Table:[bronze].[erp_loc_a101]';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>>Inserting Table :[bronze].[erp_loc_a101]';
		BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Users\yetun\Sql-data-warehouse-project\Datasets\source_erp\loc_a101.csv'
			WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @END_TIME = GETDATE();
			PRINT '>>Time taken to load bronze.erp_loc_a101: ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' seconds';
		SET @START_TIME = GETDATE();
			PRINT '>>Truncating Table: bronze.erp_cust_az12';
			TRUNCATE TABLE bronze.erp_cust_az12;
			PRINT '>>Inserting Table :bronze.erp_cust_az12';
			BULK INSERT bronze.erp_cust_az12
				FROM 'C:\Users\yetun\Sql-data-warehouse-project\Datasets\source_erp\cust_az12.csv'
				WITH
				(
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
				SET @END_TIME = GETDATE();
				PRINT '>>Time taken to load bronze.erp_cust_az12: ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' seconds';
		SET @START_TIME = GETDATE();
			PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2';
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;
			PRINT '>>Inserting Table :bronze.erp_px_cat_g1v2';
			BULK INSERT bronze.erp_px_cat_g1v2
				FROM 'C:\Users\yetun\Sql-data-warehouse-project\Datasets\source_erp\px_cat_g1v2.csv'
				WITH
				(
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
				SET @END_TIME = GETDATE();
				PRINT '>>Time taken to load bronze.erp_px_cat_g1v2: ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' seconds';

								SET @Batch_end_time = GETDATE();
								PRINT ' ==============================================================';
								PRINT 'Finished loading Bronze layer!';
								PRINT 'Total time taken to load Bronze layer: ' + CAST(DATEDIFF(SECOND, @Batch_start_time, @Batch_end_time) AS NVARCHAR) + ' seconds';
								PRINT ' ==============================================================';
				END TRY
				BEGIN CATCH
				PRINT ' ==============================================================';
				PRINT 'Error Occured while loading Bronze layer';
					PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(50));
					PRINT 'Error Message: ' + ERROR_MESSAGE();
					PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR(50));
					PRINT 'Error Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'N/A');
				PRINT ' ==============================================================';
				END CATCH;
END;
