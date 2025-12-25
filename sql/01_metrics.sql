-- Date range + table sizes
SELECT MIN(signup_date) AS min_signup, MAX(signup_date) AS max_signup, COUNT(*) AS users FROM users;

SELECT MIN(event_time) AS min_event, MAX(event_time) AS max_event, COUNT(*) AS events FROM events;

SELECT MIN(order_time) AS min_order, MAX(order_time) AS max_order, COUNT(*) AS orders,
       SUM(revenue) AS total_revenue
FROM orders;

-- Daily Active Users (DAU)
SELECT DATE(event_time) AS dt,
       COUNT(DISTINCT user_id) AS dau
FROM events
GROUP BY 1
ORDER BY 1;

-- Monthly Active Users (MAU)
SELECT DATE_TRUNC('month', event_time) AS month,
       COUNT(DISTINCT user_id) AS mau
FROM events
GROUP BY 1
ORDER BY 1;

-- Daily Purchasers and Revenue
SELECT DATE(order_time) AS dt,
       COUNT(DISTINCT user_id) AS purchasers,
       SUM(revenue) AS revenue
FROM orders
GROUP BY 1
ORDER BY 1;

-- Daily Conversion Rate
WITH active AS (
  SELECT DATE(event_time) AS dt, user_id
  FROM events
  GROUP BY 1, 2
),
buyers AS (
  SELECT DATE(order_time) AS dt, user_id
  FROM orders
  GROUP BY 1, 2
)
SELECT a.dt,
       COUNT(DISTINCT a.user_id) AS active_users,
       COUNT(DISTINCT b.user_id) AS buyers,
       COUNT(DISTINCT b.user_id) * 1.0 / COUNT(DISTINCT a.user_id) AS conversion_rate
FROM active a
LEFT JOIN buyers b
  ON a.dt = b.dt AND a.user_id = b.user_id
GROUP BY 1
ORDER BY 1;
