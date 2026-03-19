/*
===============================================================
Create DataWarehouse Database and Schemas
===============================================================

Script Purpose:
This script initializes a new database named `DataWarehouse`.
- If the database already exists, it will be dropped and recreated.
- It also creates three schemas to support a medallion architecture:
  - bronze: raw data layer
  - silver: cleaned and transformed data
  - gold: business-ready data

WARNING:
Running this script will DROP the entire `DataWarehouse` database if it exists.
All data will be permanently deleted.

Proceed with caution and ensure you have proper backups before running this script.
===============================================================
*/

USE master;
GO

-- Drop and recreate the DataWarehouse database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse 
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouse;
END;
GO

-- Create the DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create schemas for medallion architecture
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
