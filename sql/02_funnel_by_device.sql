-- 02_funnel.sql
-- Funnel by device (user-level "did event" funnel)

WITH base AS (
  SELECT
    e.user_id,
    u.device,
    -- did the user do each step at least once?
    MAX(e.event_type = 'view_item')::INT    AS did_view,
    MAX(e.event_type = 'add_to_cart')::INT  AS did_cart,
    MAX(e.event_type = 'checkout')::INT     AS did_checkout,
    MAX(e.event_type = 'purchase')::INT     AS did_purchase
  FROM events e
  JOIN users u USING (user_id)
  GROUP BY 1, 2
)
SELECT
  device,
  COUNT(*) AS users_total,
  SUM(did_view) AS users_view,
  SUM(did_cart) AS users_add_to_cart,
  SUM(did_checkout) AS users_checkout,
  SUM(did_purchase) AS users_purchase,

  -- step conversion rates
  SUM(did_cart) * 1.0 / NULLIF(SUM(did_view), 0) AS view_to_cart,
  SUM(did_checkout) * 1.0 / NULLIF(SUM(did_cart), 0) AS cart_to_checkout,
  SUM(did_purchase) * 1.0 / NULLIF(SUM(did_checkout), 0) AS checkout_to_purchase,

  -- overall conversion from view → purchase
  SUM(did_purchase) * 1.0 / NULLIF(SUM(did_view), 0) AS view_to_purchase
FROM base
GROUP BY 1
ORDER BY users_total DESC;
