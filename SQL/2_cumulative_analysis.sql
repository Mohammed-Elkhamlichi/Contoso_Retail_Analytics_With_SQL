/* 
+ Aggregating data progressively over time to track business expansion.
+ Calculating running totals and moving averages using advanced window functions.
 */
 WITH 
SELECT
    TO_CHAR (orderdate, 'YYYY-MM') AS order_year_month,
    ROUND(SUM(quantity * netprice * exchangerate)) AS net_revenue,
    COUNT(orderkey) AS total_orders
FROM
    sales
WHERE
    orderdate IS NOT NULL
GROUP BY
    order_year_month
ORDER BY
    order_year_month