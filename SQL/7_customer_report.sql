WITH customer_info AS (
	SELECT
		c.customerkey,
		--
		CONCAT(c.title, ' ', c.givenname, ' ', c.surname) AS customer_name,
		c.age AS customer_age,
		COALESCE(s.quantity * s.netprice * s.exchangerate, 0) AS spents,
		s.quantity,
		s.orderkey,
		s.orderdate,
		s.productkey
	FROM
		customer c
	LEFT JOIN sales s ON
		s.customerkey = c.customerkey
), 
customer_aggregated AS (
	SELECT
		customerkey,
		customer_name,
		customer_age,
		-- total orders by each customer
		COUNT(DISTINCT orderkey) AS total_orders,
		
		-- total spents by each customer
		COALESCE(ROUND(SUM(spents)), 0) AS total_spents,
		
		-- total products by each customer
		COALESCE(COUNT(DISTINCT productkey), 0) AS total_products,
		
		-- total quantities by each customer
		COALESCE(SUM(quantity), 0) AS total_quantity,
		
		-- lifespan calculated by the difference between the first order date and the last order date 
		COALESCE(ROUND((MAX(orderdate) - MIN(orderdate)) / 30.0), 0) AS lifespan_months,
		
		-- (contoso_100k.sql) dataset historical timeline ends in April 2024,
		-- we calculate the recency of the customer based on the last order date by this customer 
		-- and the last order made in or datasets (April 2024) 
		-- the results in day and we converted it to months by dividing it on 30 days
		COALESCE(ROUND((MAX(MAX(orderdate)) OVER () - MAX(orderdate)) / 30.0), 0) AS recency_in_months

	FROM
		customer_info
	GROUP BY
		customerkey,
		customer_name,
		customer_age
),
customer_report AS (
	SELECT 
		customerkey,
		customer_name,
		customer_age,
		recency_in_months,
		-- Classify customers into segments based on their age
		CASE WHEN customer_age < 25 THEN 'Under 25'
			WHEN customer_age BETWEEN 25 AND 39 THEN '25 - 39'
			WHEN customer_age BETWEEN 40 AND 54 THEN '40 - 54'
			WHEN customer_age BETWEEN 55 AND 64 THEN '55 - 64'
			ELSE '65+'
			END AS age_segment,
		total_spents,
		total_orders,
		-- average order value
		CASE WHEN total_orders = 0 THEN 0
			ELSE  total_spents / total_orders
		  	END AS average_order_value,
		total_products,
		total_quantity,
		lifespan_months,
		-- Classify customers into segments based on their spending and lifespan
		CASE
			WHEN lifespan_months >= 12
			AND total_spents > ROUND(AVG(total_spents) OVER ()) * 2 THEN 'VIP Customer'
			--
			WHEN lifespan_months >= 12
			AND total_spents BETWEEN ROUND(AVG(total_spents) OVER ()) * 1 AND ROUND(AVG(total_spents) OVER ()) * 2 THEN 'High-Value Customer'
			--
			WHEN lifespan_months >= 12
			AND total_spents BETWEEN ROUND(AVG(total_spents) OVER ()) * 0.5 AND ROUND(AVG(total_spents) OVER ()) * 1 THEN 'Medium-Value Customer'
			-- 
			ELSE 'Low-Value Customer'
		END AS customer_segment
	FROM
		customer_aggregated
)SELECT 
	*
FROM customer_report

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
===============================================================================
*/
