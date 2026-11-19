-- Number of orders received per month
SELECT DATE_TRUNC('Month', order_purchase_timestamp)::date AS month, 
	COUNT(*) AS orders
FROM orders
GROUP BY 1
ORDER BY 1;


-- Average order value
-- how much does the average order bring in? (item prices only, freight excluded)
SELECT ROUND(SUM(price) / COUNT(DISTINCT order_id), 2) AS avg_order_value 
FROM order_items;


-- Top 10 product categories by revenue
-- which product categories earn the most?
SELECT p.product_category_name, SUM(i.price) AS revenue FROM order_items i
INNER JOIN products p
ON p.product_id = i.product_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- orders by status
-- what happens to orders? How many are delivered, canceled, and so on?
SELECT order_status, COUNT(*) orders, 
ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM orders), 2) AS pct
FROM orders
GROUP BY order_status
ORDER BY COUNT(*) DESC;

-- average delivery time in days
-- how long does delivery take, from purchase to the customer receiving it?

SELECT AVG(EXTRACT(EPOCH FROM AGE(order_delivered_customer_date, order_purchase_timestamp))/86400) FROM orders
