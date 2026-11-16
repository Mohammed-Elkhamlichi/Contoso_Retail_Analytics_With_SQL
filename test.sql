WITH product_info AS (
    SELECT 
        p.productname,
        p.subcategoryname,
        ROUND(
            COALESCE(
                s.quantity * s.netprice * exchangerate, 0
            )
        ) AS generated_revenue
    FROM product p
    LEFT JOIN sales s ON s.productkey = p.productkey

),
p_segements_by_revenue AS (
    SELECT
        *,
        CASE 
            WHEN generated_revenue > 10000 
                THEN 'High Ticket Product'
            WHEN generated_revenue BETWEEN 1000 AND 10000 
                THEN 'Medium Ticket Product'
            ELSE 'Low Ticket Product'
        END AS product_segments
    FROM product_info

),
product_rank AS (
    SELECT
        productname,
        product_segments,
        subcategoryname,
        generated_revenue,
        ROW_NUMBER() OVER(PARTITION BY product_segments ORDER BY generated_revenue DESC) AS ranking
    FROM p_segements_by_revenue

)SELECT 
    productname,
    subcategoryname,
    product_segments,
    generated_revenue,
    ranking
FROM product_rank

WHERE ranking <= 3