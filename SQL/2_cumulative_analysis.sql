/* 
+ Aggregating data progressively over time to track business expansion.
+ Calculating running totals and moving averages using advanced window functions.
 */
WITH
    order_data AS (
        SELECT
            TO_CHAR (orderdate, 'MM') AS order_year_month,
            COUNT(orderkey) AS total_orders,
            ROUND(SUM(quantity * netprice * exchangerate)) AS net_revenue
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
    net_revenue,
    SUM(total_orders) OVER (
        ORDER BY
            order_year_month
    ) AS cumulative_orders,
    SUM(net_revenue) OVER (
        ORDER BY
            order_year_month
    ) AS cumulative_net_revenue
FROM
    order_data