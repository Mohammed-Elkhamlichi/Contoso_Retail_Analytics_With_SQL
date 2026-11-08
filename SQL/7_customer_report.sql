WITH customer_info AS (
	SELECT
		c.customerkey,
		concat(c.title, ' ', c.givenname, ' ', c.surname) AS customer_name,
		c.age AS customer_age,
		s.quantity * s.netprice * s.exchangerate AS net_revenue,
		s.quantity,
		s.orderkey,
		s.orderdate,
		s.productkey
	FROM
		customer c
	LEFT JOIN sales s ON
		s.customerkey = c.customerkey
)SELECT
	customerkey,
	customer_name,
	customer_age,
	count(DISTINCT orderkey) AS total_orders,
	ROUND(SUM(net_revenue)) AS generated_revenue,
	COUNT(DISTINCT productkey) AS total_products,
	SUM(quantity) AS total_quantity,
	MIN(orderdate) AS first_order_date,
	MAX(orderdate) AS last_order_date,
	(
		EXTRACT(YEAR FROM age(MAX(orderdate), MIN(orderdate))) * 12
	) + EXTRACT(MONTH FROM age(MAX(orderdate), MIN(orderdate))) AS lifespan_in_months

	
FROM
	customer_info
GROUP BY 
	customerkey,
	customer_name,
	customer_age
ORDER BY
	total_orders DESC


/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
        - total orders
        - total sales
        - total quantity purchased
        - total products
        - lifespan (in months)
    4. Calculates valuable KPIs:
        - recency (months since last order)
        - average order value
        - average monthly spend
===============================================================================
*/
