-- ====================================================================
-- Phase 2: Cumulative Analysis (Running Totals & Moving Averages)
-- Objective: Track progressive business expansion over time
-- ====================================================================

WITH order_data AS (
    SELECT
        TO_CHAR(orderdate, 'YYYY-MM') AS order_year_month,
        COUNT(orderkey) AS total_orders,
        ROUND(SUM(quantity * netprice * exchangerate)) AS total_net_revenue,
        AVG(quantity * netprice * exchangerate) AS average_order_value
    FROM sales
    WHERE orderdate IS NOT NULL
    GROUP BY order_year_month
)
SELECT
    order_year_month,
    total_orders,
    total_net_revenue,
    
    -- average monthly orders across the entire dataset
    ROUND(AVG(total_orders) OVER (ORDER BY order_year_month)) AS global_avg_monthly_orders,

    -- Cumulative Running Total of Orders (chronological accumulation)
    SUM(total_orders) OVER (
        ORDER BY order_year_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_total_orders,

    -- Cumulative Running Total of Net Revenue (chronological accumulation)
    SUM(total_net_revenue) OVER (
        ORDER BY order_year_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_net_revenue

FROM order_data
ORDER BY order_year_month;