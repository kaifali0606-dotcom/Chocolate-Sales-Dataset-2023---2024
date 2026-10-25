/*===============================
	Report VIEW for products
===============================*/
CREATE OR ALTER VIEW report_products AS 
WITH base_query AS(
	SELECT 
		s.order_id,
		s.order_date,
		s.product_id,
		s.customer_id,
		s.quantity,
		s.revenue,
		s.unit_price,
		p.product_name,
		p.brand,
		p.category
	FROM dbo.sales s
	LEFT JOIN dbo.products p
	ON s.product_id = p.product_id
)
,aggregration_products AS(
	SELECT
		product_id,
		product_name,
		brand,
		category,
		SUM(revenue) total_sales,
		COUNT(order_id) total_orders,
		COUNT(customer_id) total_customer,
		SUM(quantity) total_quantity,
		MAX(order_date) last_order,
		DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) lifespan
	FROM base_query
	GROUP BY 
		product_id,
		product_name,
		brand,
		category
)
SELECT 
	product_id,
	product_name,
	brand,
	category,
	total_sales,
	CASE 
		WHEN total_orders = 0 THEN '0'
		ELSE ROUND(total_sales/total_orders,2)
	END avg_sales_per_order,
	CASE 
		WHEN total_orders = 0 THEN '0'
		ELSE ROUND(total_quantity/total_orders,2)
	END avg_quantity_per_order,
	total_orders,
	total_customer,
	total_quantity,
	last_order,
	lifespan,
	DATEDIFF(MONTH,last_order,GETDATE()) recency
FROM aggregration_products
GO

SELECT *
FROM dbo.report_products