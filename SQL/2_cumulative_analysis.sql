/* 
+ Aggregating data progressively over time to track business expansion.
+ Calculating running totals and moving averages using advanced window functions.
 */
WITH
    order_data AS (
        SELECT
            TO_CHAR (orderdate, 'YYYY-MM') AS order_year_month,
            COUNT(orderkey) AS total_orders,
            ROUND(SUM(quantity * netprice * exchangerate)) AS total_net_revenue
        FROM
            sales
        WHERE
            orderdate IS NOT NULL
        GROUP BY
            order_year_month
        ORDER BY
            order_year_month
    )
SELECT
    order_year_month,
    total_orders,
    total_net_revenue,
    SUM(total_orders) OVER (
        ORDER BY
            order_year_month
    ) AS cumulative_total_orders,
    SUM(total_net_revenue) OVER (
        ORDER BY
            order_year_month
    ) AS cumulative_total_net_revenue
FROM
    order_data