/*
===============================================================================
Stored Procedure: Load Data Into Tables
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'tables' schema from external CSV files. 
    It performs the following actions:
    - Truncates the tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to the tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.
*/
-- FOR execution : EXEC chocolate;
CREATE OR ALTER PROCEDURE chocolate AS 
BEGIN 
    DECLARE @start_time DATETIME,@end_time DATETIME,@start_batch_time DATETIME,@end_batch_time DATETIME;
    BEGIN TRY 
        SET @start_batch_time = GETDATE();
        SET @start_time = GETDATE();
        PRINT '=====================================';
        PRINT 'Loading Data';
        PRINT '=====================================';
        PRINT '-------------------------------------';
        PRINT 'Truncating Table : customers';
        TRUNCATE TABLE dbo.customers;
        PRINT 'Inserting Data into Table : customers';
        BULK INSERT dbo.customers 
        FROM 'D:\Chocolate Sales Dataset 2023 - 2024\customers.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading Time ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' Seconds';
        PRINT '-------------------------------------';
        SET @start_time = GETDATE();
        PRINT 'Truncating Table : products';
        TRUNCATE TABLE dbo.products;
        PRINT 'Inserting Data into Table : products';
        BULK INSERT dbo.products
        FROM 'D:\Chocolate Sales Dataset 2023 - 2024\products.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading Time ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' Seconds';
        PRINT '-------------------------------------';
        SET @start_time = GETDATE();
        PRINT 'Truncating Table : sales';

        TRUNCATE TABLE dbo.sales;
        PRINT 'Inserting Data into Table : sales';

        BULK INSERT dbo.sales 
        FROM 'D:\Chocolate Sales Dataset 2023 - 2024\sales.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading Time ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' Seconds';
        PRINT '-------------------------------------';
        SET @start_time = GETDATE();
        PRINT 'Truncating Table : calender';

        TRUNCATE TABLE dbo.calender;
        PRINT 'Inserting Data into Table : calender';

        BULK INSERT dbo.calender
        FROM 'D:\Chocolate Sales Dataset 2023 - 2024\calendar.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading Time ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' Seconds';
        PRINT '-------------------------------------';
        SET @start_time = GETDATE();
        PRINT 'Truncating Table : stores';

        TRUNCATE TABLE dbo.stores;
        PRINT 'Inserting Data into Table : stores';
        
        BULK INSERT dbo.stores 
        FROM 'D:\Chocolate Sales Dataset 2023 - 2024\stores.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading Time ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' Seconds';
        PRINT '-------------------------------------';
        SET @end_batch_time = GETDATE();
        PRINT '=====================================';
        PRINT 'Loading Completed';
        PRINT 'Loading Time ' + CAST(DATEDIFF(SECOND,@start_batch_time,@end_batch_time) AS NVARCHAR) + ' Seconds';
        PRINT '=====================================';
    END TRY
    BEGIN CATCH
        PRINT '=====================================';
        PRINT 'Error Message : ' + ERROR_MESSAGE();
        PRINT 'Error Message : ' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message : ' + CAST (ERROR_STATE() AS NVARCHAR);
        PRINT '=====================================';
    END CATCH
END;


