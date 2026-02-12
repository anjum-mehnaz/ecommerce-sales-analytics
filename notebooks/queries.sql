-- Monthly revenue trend
SELECT
  TO_CHAR(order_purchase_timestamp::timestamp, 'YYYY-MM') AS month,
  SUM(revenue) AS total_revenue
FROM sales
GROUP BY month
ORDER BY month;

-- Top products/categories
SELECT
  product_category_name,
  SUM(revenue) AS total_revenue
FROM sales
GROUP BY product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Repeat vs new customers
WITH customer_orders AS (
  SELECT customer_unique_id, COUNT(order_id) AS orders
  FROM sales
  GROUP BY customer_unique_id
)
SELECT
  CASE WHEN orders = 1 THEN 'New' ELSE 'Repeat' END AS customer_type,
  COUNT(*) AS customer_count
FROM customer_orders
GROUP BY customer_type;

-- Region-wise performance
SELECT
  customer_state,
  SUM(revenue) AS total_revenue
FROM sales
GROUP BY customer_state
ORDER BY total_revenue DESC;
