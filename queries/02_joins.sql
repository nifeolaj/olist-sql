-- Which state brings in the most revenue, and how many orders?
SELECT 
	c.customer_state, 
	SUM(i.price) revenue,
	COUNT(DISTINCT o.order_id) orders
FROM orders o
JOIN order_items i
ON i.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 2 DESC;


-- Are there sellers that have never sold anything?
SELECT s.seller_id
FROM sellers s
LEFT JOIN order_items i
ON s.seller_id = i.seller_id
WHERE i.seller_id IS NULL


-- Which sellers deliver late most often? (only sellers with at least 30 orders)
WITH late AS (SELECT i.seller_id,
		COUNT(DISTINCT i.order_id) late_deliveries
FROM orders o
JOIN order_items i
ON o.order_id = i.order_id
WHERE o.order_status = 'delivered' AND 
order_delivered_customer_date > order_estimated_delivery_date
GROUP BY seller_id)
,
total AS (SELECT i.seller_id,
		COUNT(DISTINCT i.order_id) total_deliveries
FROM orders o
JOIN order_items i
ON o.order_id = i.order_id
WHERE o.order_status = 'delivered' 
GROUP BY seller_id)

SELECT t.seller_id, late_deliveries, total_deliveries, 
ROUND((COALESCE(late_deliveries, 0) * 100.0 /total_deliveries), 2) pct_late
FROM late l
RIGHT JOIN total t
ON l.seller_id = t.seller_id
WHERE total_deliveries >= 30
ORDER BY pct_late DESC, 1;



