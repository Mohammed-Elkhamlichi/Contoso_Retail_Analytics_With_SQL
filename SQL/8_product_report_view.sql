
/*==========================
Product Report View
==========================
Purpose:
- Creates a reusable database view for the Phase 8 Product Report.
- Enables direct live connections for Power BI, Excel, or downstream analytics.*/

CREATE OR REPLACE VIEW vw_product_report AS
/*==========================
Product Report
==========================
Purpose:
- This report consolidates key product metrics and behaviors.

Highlights:
1. Gathers essential fields such as product name, category, subcategory, and cost.
2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers
3. Aggregates product-level metrics:
- total orders
- total sales
- total quantity sold
- total customers (unique)
- lifespan (in months)
4. Calculates valuable KPIs:
- recency (months since last sale)
- average order revenue (AOR)
- average monthly revenue
==========================*/
    WITH product_info AS (
        SELECT 
            p.productkey,
            p.productname,
            p.categoryname,
            p.subcategoryname,
            p.cost,
            p.price,
            
            -- total orders
            COUNT(s.orderkey) AS total_orders,
            
            -- total unique customers
            COUNT(DISTINCT s.customerkey) AS total_customers,
            
            -- total quantities sold
            COALESCE(SUM(s.quantity),0) AS total_quantity_sold,
            
            -- first sale date for each product
            MIN(s.orderdate) AS first_sale_date,
            
            -- last sale date for each product
            MAX(s.orderdate) AS last_sale_date,
            
            -- total generated net revenue from each product
            COALESCE(ROUND(SUM(s.quantity * s.netprice * s.exchangerate)),0) AS total_generated_revenue
            
        FROM
            product p
            
        LEFT JOIN sales s ON
            p.productkey = s.productkey
            
            
        GROUP BY 
            p.productkey,
            p.productname, 
            p.categoryname,
            p.subcategoryname
            
    ), 
    product_aggregation AS (

        SELECT 
            *,
            -- lifespan of a product base on the last and the first sale of this product	
            COALESCE(((last_sale_date  - first_sale_date) / 30), 0) AS lifespan_in_months,
            
            -- the average generated revenue from all products
            COALESCE(ROUND(AVG(total_generated_revenue) over()), 0) AS avg_generated_revenue_overall,
            
            -- the last sale date in our datasets, we will use it later to calculate the product recency
            CASE 
                WHEN last_sale_date IS NOT NULL THEN MAX(last_sale_date) OVER () 
            END AS last_order_date_overall
            
        FROM
            product_info
    ), 
    product_report AS (

        SELECT 
            *,
            -- product recency
            CASE 
                WHEN last_order_date_overall IS NOT NULL AND last_sale_date IS NOT NULL 
                THEN (last_order_date_overall  - last_sale_date) / 30
            END AS recency_in_months,
            
            -- The Average Order Revenue  (AOR)
            CASE 
                WHEN total_orders = 0 THEN 0
                ELSE ROUND(total_generated_revenue / total_orders )
                END AS avg_order_revenue,
                
            -- The Average Monthly Revenue
                CASE 
                    WHEN lifespan_in_months = 0 THEN total_generated_revenue
                    ELSE ROUND(total_generated_revenue / lifespan_in_months)
                    END AS avg_monthly_revenue,
                
            -- Segments products by compering total generated revenue to portfolio average generated revenue.
                
            CASE 
                -- High-Performer: Total generated revenue >= portfolio average * 1.5
                WHEN total_generated_revenue >= avg_generated_revenue_overall*1.5 THEN 'High-Performer'
                
                -- Low-Performer: Total generated revenue < portfolio average * 0.5 (or zero sales)
                WHEN total_generated_revenue <= avg_generated_revenue_overall*0.5 THEN 'Low-Performer'
                
                -- Mid-Range Product: Total generated revenue between portfolio average * 0.5 and * 1.5
                ELSE 'Mid-Range'
                
                END AS product_segments
                
        FROM product_aggregation
    ) 
    SELECT * FROM product_report 
