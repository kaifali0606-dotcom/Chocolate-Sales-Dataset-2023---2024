/*===============================
	Report VIEW for stores
===============================*/
CREATE OR ALTER VIEW report_stores AS 
WITH base_query AS(
	SELECT 
		st.store_id,
		st.store_name,
		st.city,
		st.country,
		st.store_type,
		sl.order_id,
		sl.order_date,
		sl.product_id,
		sl.customer_id,
		sl.quantity,
		sl.revenue
	FROM dbo.sales sl
	LEFT JOIN dbo.stores st
	ON sl.store_id = st.store_id
)
,aggregation_stores AS(
	SELECT 
		store_id,
		store_name,
		city,
		country,
		store_type,
		ROUND(SUM(revenue),2) total_sales,
		SUM(quantity) total_quantity,
		COUNT(order_id) total_orders,
		MAX(order_date) last_order,
		DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) lifespan
	FROM base_query
	GROUP BY 
		store_id,
		store_name,
		country,
		city,
		store_type
)
SELECT 
		store_id,
		store_name,
		city,
		country,
		store_type,
		total_sales,
		CASE 
			WHEN total_orders = 0 THEN '0'
			ELSE ROUND(total_sales/total_orders,2)
		END avg_sales_per_order,
		total_quantity,
		total_orders,
	    last_order,
		lifespan
FROM aggregation_stores
GO


SELECT *
FROM dbo.report_stores