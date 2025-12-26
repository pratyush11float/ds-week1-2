-- 03_retention.sql (fixed)
WITH cohorts AS (
  SELECT
    user_id AS user_id,
    DATE_TRUNC('week', signup_date) AS cohort_week
  FROM users
),
activity AS (
  SELECT DISTINCT
    user_id AS user_id,
    DATE_TRUNC('week', event_time) AS active_week
  FROM events
  WHERE event_type = 'app_open'
),
cohort_activity AS (
  SELECT
    c.user_id AS user_id,                 
    c.cohort_week AS cohort_week,
    a.active_week AS active_week,
    DATE_DIFF('week', c.cohort_week, a.active_week) AS week_index
  FROM cohorts c
  JOIN activity a
    ON c.user_id = a.user_id              
  WHERE a.active_week >= c.cohort_week
),
cohort_sizes AS (
  SELECT cohort_week, COUNT(*) AS cohort_size
  FROM cohorts
  GROUP BY 1
)
SELECT
  ca.cohort_week,
  ca.week_index,
  COUNT(DISTINCT ca.user_id) AS active_users,
  cs.cohort_size,
  COUNT(DISTINCT ca.user_id) * 1.0 / cs.cohort_size AS retention_rate
FROM cohort_activity ca
JOIN cohort_sizes cs
  ON ca.cohort_week = cs.cohort_week      
WHERE ca.week_index BETWEEN 0 AND 8
GROUP BY 1, 2, 4
ORDER BY 1, 2;
