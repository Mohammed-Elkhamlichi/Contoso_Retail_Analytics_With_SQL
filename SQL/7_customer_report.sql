/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, High-Value, Medium-Value, Low-Value) and age groups.
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
		-- recency_in_months,

		-- Classify customer activity status based on recency (Threshold: 6 months)
		CASE 
			WHEN total_orders = 0 OR recency_in_months IS NULL THEN 'No Orders / Prospect'
		 	WHEN recency_in_months <= 6 THEN 'Active'
			ELSE 'Inactive'
			END AS customer_status,

		-- Classify customers into segments based on their age
		CASE 
			WHEN customer_age < 25 THEN 'Under 25'
			WHEN customer_age BETWEEN 25 AND 39 THEN '25 - 39'
			WHEN customer_age BETWEEN 40 AND 54 THEN '40 - 54'
			WHEN customer_age BETWEEN 55 AND 64 THEN '55 - 64'
			ELSE '65+'
			END AS age_group,
		--
		total_spents,
		total_orders,

		-- average order value
		CASE 
			WHEN total_orders = 0 THEN 0
			ELSE  total_spents / total_orders
		  	END AS average_order_value,

		total_products,
		total_quantity,
		lifespan_months,

		-- Classify customers into segments based on their spending and lifespan
		CASE
			--  VIP Customers: Customers who spend more than double the average and have a long-term loyal relationship with a customer lifespan of at least 12 months.
			WHEN lifespan_months >= 12
			AND total_spents > ROUND(AVG(total_spents) OVER ()) * 2 THEN 'VIP Customer'

			-- High-Value Customers: Customers who spend between 1.0x and 2.0x of the average and maintain a solid tenure with a lifespan of at least 12 months.
			WHEN lifespan_months >= 12
			AND total_spents BETWEEN ROUND(AVG(total_spents) OVER ()) * 1 AND ROUND(AVG(total_spents) OVER ()) * 2 THEN 'High-Value Customer'

			-- Medium-Value Customers: Customers who spend between 0.5x to 1.0x of the average and have a stable customer lifespan of at least 12 months.
			WHEN lifespan_months >= 12
			AND total_spents BETWEEN ROUND(AVG(total_spents) OVER ()) * 0.5 AND ROUND(AVG(total_spents) OVER ()) * 1 THEN 'Medium-Value Customer'

			-- Low-Value Customers: Customers who spend less than half the average) and have a short-term relationship spanning less than 12 months (typically one-off or trial buyers). 
			ELSE 'Low-Value Customer'
		END AS customer_segment

	FROM
		customer_aggregated

)SELECT 
	*
FROM customer_report


