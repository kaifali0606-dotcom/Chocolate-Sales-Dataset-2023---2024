--======================================
--Creating Tables
--======================================
IF OBJECT_ID('customers', 'U') IS NOT NULL
	DROP TABLE customers;
GO
CREATE TABLE customers(
	customer_id NVARCHAR(50),
	age INT,
	gender NVARCHAR(50),
	loyalty_member INT,
	join_date DATE
)
IF OBJECT_ID('products', 'U') IS NOT NULL
	DROP TABLE products;
GO
CREATE TABLE products(
	product_id NVARCHAR(50),
	product_name NVARCHAR(50),
	brand NVARCHAR(50),
	category NVARCHAR(50),
	cocoa_percent INT,
	weight_g INT
)
IF OBJECT_ID('sales', 'U') IS NOT NULL
	DROP TABLE sales;
GO
CREATE TABLE sales(
	order_id NVARCHAR(50),
	order_date DATE,
	product_id NVARCHAR(50),
	store_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	quantity INT,
	unit_price FLOAT,
	discount FLOAT,
	revenue FLOAT,
	cost FLOAT,
	profit FLOAT
)
IF OBJECT_ID('calender', 'U') IS NOT NULL
	DROP TABLE calender;
GO
CREATE TABLE calender(
	date_ DATE,
	year_ INT,
	month_ INT,
	day_ INT,
	week_ INT,
	day_of_week INT
)
IF OBJECT_ID('stores', 'U') IS NOT NULL
	DROP TABLE stores;
GO
CREATE TABLE stores(
	store_id NVARCHAR(50),
	store_name NVARCHAR(50),
	city NVARCHAR(50),
	country NVARCHAR(50),
	store_type NVARCHAR(50)
)
