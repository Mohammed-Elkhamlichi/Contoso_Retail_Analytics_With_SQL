-- ====================================================================
-- Phase 1: Change Over Time Analysis
-- Database: Contoso Retail Data Warehouse
-- Objective: Track revenue, order volume, customer count, and quantity
-- ====================================================================
-- --------------------------------------------------------------------
-- 1.1 Yearly Performance
-- Objective: High-level annual growth trajectory (2015 - 2024)
-- --------------------------------------------------------------------
SELECT
    TO_CHAR (orderdate, 'YYYY') AS order_year,
    ROUND(SUM(quantity * netprice * exchangerate)) AS net_revenue,
    COUNT(orderkey) AS total_orders,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(quantity) AS total_quantity
FROM
    sales
GROUP BY
    order_year
ORDER BY
    order_year;

-- --------------------------------------------------------------------
-- 1.2 Monthly Seasonality (Aggregated Across All Years)
-- Objective: Identify seasonal peaks (e.g., February spike vs. April trough)
-- Note: Replaced alias 'order_year' with 'order_month' for accuracy
-- --------------------------------------------------------------------
SELECT
    TO_CHAR (orderdate, 'MM') AS order_month,
    ROUND(SUM(quantity * netprice * exchangerate)) AS net_revenue,
    COUNT(orderkey) AS total_orders,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(quantity) AS total_quantity
FROM
    sales
GROUP BY
    order_month
ORDER BY
    order_month;

-- --------------------------------------------------------------------
-- 1.3 Year-Month Time Series Trend
-- Objective: Detailed monthly revenue trajectory across the full timeline
-- --------------------------------------------------------------------
SELECT
    TO_CHAR (orderdate, 'YYYY-MM') AS order_year_month,
    ROUND(SUM(quantity * netprice * exchangerate)) AS net_revenue,
    COUNT(orderkey) AS total_orders,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(quantity) AS total_quantity
FROM
    sales
GROUP BY
    order_year_month
ORDER BY
    order_year_month;