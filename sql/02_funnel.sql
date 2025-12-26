-- Funnel analysis SQL query
WITH step_times AS (
  SELECT
    user_id,
    MIN(CASE WHEN event_type='view_item' THEN event_time END)    AS t_view,
    MIN(CASE WHEN event_type='add_to_cart' THEN event_time END)  AS t_cart,
    MIN(CASE WHEN event_type='checkout' THEN event_time END)     AS t_checkout,
    MIN(CASE WHEN event_type='purchase' THEN event_time END)     AS t_purchase
  FROM events
  GROUP BY 1
),
qualified AS (
  SELECT
    user_id,
    (t_view IS NOT NULL)::INT AS view_ok,
    (t_view IS NOT NULL AND t_cart IS NOT NULL AND t_cart >= t_view)::INT AS cart_ok,
    (t_cart IS NOT NULL AND t_checkout IS NOT NULL AND t_checkout >= t_cart)::INT AS checkout_ok,
    (t_checkout IS NOT NULL AND t_purchase IS NOT NULL AND t_purchase >= t_checkout)::INT AS purchase_ok
  FROM step_times
)
SELECT
  SUM(view_ok) AS users_view,
  SUM(cart_ok) AS users_add_to_cart,
  SUM(checkout_ok) AS users_checkout,
  SUM(purchase_ok) AS users_purchase,
  SUM(cart_ok) * 1.0 / NULLIF(SUM(view_ok), 0) AS view_to_cart,
  SUM(checkout_ok) * 1.0 / NULLIF(SUM(cart_ok), 0) AS cart_to_checkout,
  SUM(purchase_ok) * 1.0 / NULLIF(SUM(checkout_ok), 0) AS checkout_to_purchase
FROM qualified;
