/* ==============================================
	Customers Report
   ==============================================
*/
CREATE OR ALTER VIEW report_customers AS 
WITH base_query AS (
	SELECT 
		s.order_id,
		s.order_date,
		s.product_id,
		s.customer_id,
		s.quantity,
		s.revenue,
		s.profit,
		c.age
	FROM dbo.sales s
	LEFT JOIN dbo.customers c
	ON s.customer_id = c.customer_id
	WHERE s.order_id IS NOT NULL
)
,aggregation_customers AS (
	SELECT 
		customer_id,
		age,
		COUNT(order_id) total_orders,
		SUM(quantity) total_quantity,
		SUM(revenue) total_sales,
		SUM(profit) total_profit,
		COUNT(product_id) total_products,
		DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) lifespan_months,
		MAX(order_date) last_order
	FROM base_query
	GROUP BY 
		customer_id,
		age
)
SELECT
	customer_id,
	age,
	CASE 
		WHEN age < 18 THEN 'Minor 0-18'
		WHEN age BETWEEN 19 AND 40 THEN 'Adult 19-40'
		Else 'Senior 40+'
	END age_group,
	total_sales,
	total_orders,
	CASE 
		WHEN total_sales> 500 THEN 'VIP'
		WHEN total_sales BETWEEN 300 AND 500 THEN 'Regular'
		Else 'New'
	END  AS 'status',
	CASE 
		WHEN total_orders = 0 THEN '0'
		ELSE ROUND(total_sales/total_orders, 2) 
	END avg_sales_per_order,
	CASE 
		WHEN lifespan_months = 0 THEN '0'
		ELSE ROUND(total_sales/lifespan_months, 2) 
	END avg_monthly_order,
	CASE 
		WHEN total_orders = 0 THEN '0'
		ELSE ROUND(total_profit/total_orders, 2)
	END avg_profit_per_order,
	total_quantity,
	total_profit,
	DATEDIFF(MONTH,last_order,GETDATE()) recency ,
	total_products,
	lifespan_months,
	last_order
FROM aggregation_customers
GO
