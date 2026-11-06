-- ==================================================================== --
/* Phase 3: Performance Analysis (Quartile Tiering & Benchmarking)
 Objective: Segment products by revenue contribution and benchmark 
 them against global portfolio averages.

 Evaluate and benchmark store performance, product categories, or time periods against baseline targets 
 (such as historical averages, top-quartile thresholds, or year-over-year growth) to isolate key revenue drivers and identify underperforming segments. */
-- ==================================================================== --
WITH yearly_product_sales AS (
    SELECT
        --  Year of the order
        TO_CHAR(s.orderdate, 'YYYY') AS order_year,
        p.productname,

        -- Total Net Revenue per product per year
        ROUND(SUM(s.quantity * s.netprice * s.exchangerate)) AS product_net_revenue

    FROM
        sales s
    LEFT JOIN product p ON
        p.productkey = s.productkey

    WHERE
        s.orderdate IS NOT NULL

    GROUP BY
        productname,
        order_year

), product_avg_revenue AS (
    -- Calculate the average net revenue per product across all years
    SELECT
        order_year,
        productname,
        product_net_revenue,

        -- Net Revenue average per product across all years
        ROUND(AVG(product_net_revenue)  OVER (PARTITION BY productname)) AS avg_net_revenue,

        -- Year-over-Year (YoY) revenue change for each product
        LAG(product_net_revenue) OVER (PARTITION BY productname ORDER BY order_year) AS previous_year_revenue
        
    FROM yearly_product_sales
)
SELECT
        order_year,
        productname,
        
    -- Net Revenue variance from the average per product across all years
    product_net_revenue,
    product_net_revenue - avg_net_revenue AS net_revenue_variance,

    -- Performance tiering based on net revenue variance
    CASE   
        WHEN product_net_revenue - avg_net_revenue > 0 THEN 'Above Average'
        WHEN product_net_revenue - avg_net_revenue < 0 THEN 'Below Average'
        ELSE 'Average'
    END AS performance_tier,

    -- Year-over-Year (YoY) revenue change for each product
    previous_year_revenue,
    product_net_revenue - previous_year_revenue AS yoy_revenue_change,

    CASE   
        WHEN product_net_revenue - previous_year_revenue > 0 THEN 'Increased'
        WHEN product_net_revenue - previous_year_revenue < 0 THEN 'Decreased'
        ELSE 'Stable'
    END AS yoy_performance_tier

FROM product_avg_revenue

ORDER BY 
    productname,
    order_year
