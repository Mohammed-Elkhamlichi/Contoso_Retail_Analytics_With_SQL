-- ==================================================================== --
/* 
Phase 6: Customers Segmentation & Profiling
Objective: Segment customers into spending ranges and count the number of 
customers in each range to identify customer value tiers and potential marketing strategies. 

VIP Customers: Customers who spend significantly above the portfolio average (e.g., more than double the average spend) and have a long-term loyal relationship with a customer lifespan of at least 12 months.

High-Value Customers: Customers who spend above the portfolio average (e.g., between 1.0x and 2.0x the average spend) and maintain a solid tenure with a lifespan of at least 12 months.

Medium-Value Customers: Customers who spend around the portfolio average (e.g., steady buyers right around 0.5x to 1.0x of the average) and have a stable customer lifespan of at least 12 months.

Low-Value Customers: Customers who spend below the portfolio average (less than half the average) and have a short-term relationship spanning less than 12 months (typically one-off or trial buyers).

====================================================================
*/
-- ==================================================================== --

WITH customer_info AS (
    SELECT
        s.customerkey,
        concat(c.title, ' ', c.givenname, ' ', c.surname) AS customer_name,
        MIN(s.orderdate) AS first_order_date,
        MAX(s.orderdate) AS last_order_date,
        ROUND(SUM(s.quantity * s.netprice * s.exchangerate)) AS total_spent
    FROM sales s
    LEFT JOIN customer c ON c.customerkey = s.customerkey
    GROUP BY
        s.customerkey,
        customer_name
),customer_segmentation AS (
    SELECT
        customerkey,
        customer_name,

        -- Calculate the customer lifespan in months
        (last_order_date - first_order_date) / 30 AS lifespan_months,
        total_spent,
        -- Calculate the average spend across all customers for segmentation
        ROUND(AVG(total_spent) OVER ()) AS avg_spent_all_customers
    FROM customer_info

), classified_customers AS (
        SELECT
        customerkey,
        customer_name,
        lifespan_months,
        total_spent,
        avg_spent_all_customers,

        -- Classify customers into segments based on their spending and lifespan
        CASE 
            --  VIP Customers: Customers who spend significantly above the portfolio average (e.g., more than double the average spend) and have a long-term loyal relationship with a customer lifespan of at least 12 months.
            WHEN lifespan_months >= 12 AND total_spent > avg_spent_all_customers * 2 THEN 'VIP Customer'
            -- High-Value Customers: Customers who spend above the portfolio average (e.g., between 1.0x and 2.0x the average spend) and maintain a solid tenure with a lifespan of at least 12 months.
            WHEN lifespan_months >= 12 AND total_spent BETWEEN avg_spent_all_customers * 1 AND avg_spent_all_customers * 2 THEN 'High-Value Customer'
            -- Medium-Value Customers: Customers who spend around the portfolio average (e.g., steady buyers right around 0.5x to 1.0x of the average) and have a stable customer lifespan of at least 12 months.
            WHEN lifespan_months >= 12 AND total_spent BETWEEN avg_spent_all_customers * 0.5 AND avg_spent_all_customers * 1 THEN 'Medium-Value Customer'
            -- Low-Value Customers: Customers who spend below the portfolio average (less than half the average) and have a short-term relationship spanning less than 12 months (typically one-off or trial buyers).
            ELSE 'Low-Value Customer'
        END AS customer_segment

    FROM customer_segmentation
)
SELECT 
    customer_segment,
    -- Count the number of customers in each segment
    COUNT(customerkey) AS total_customers_in_this_profile,
    -- Calculate the average spend for each customer segment
    ROUND(AVG(total_spent)) AS average_spend_in_tier
FROM classified_customers 

GROUP BY customer_segment
ORDER BY average_spend_in_tier DESC;