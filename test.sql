SELECT 
    customer_id,
    order_date,
    -- total orders
    COUNT(order_id) AS total_orders,
    -- amount
    SUM(amount) AS total_amount

FROM Orders

GROUP BY 
    customer_id, 
    order_date
    
-- customers who placed more than one order on the same day
HAVING COUNT(order_id) > 1

ORDER BY 
    order_date, 
    customer_id;