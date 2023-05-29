/* The company for which you work is reviewing its 2021 monthly sales.
For each month of 2021, calculate what percentage of restaurants have reached at least 100$ or more in monthly sales.
Note: Please remember that if an order has a blank value for actual_delivery_time, it has been canceled and therefore does not count towards monthly sales. */

WITH base AS (
SELECT
    delivery_orders.*,
    order_value.sales_amount,
    YEAR(actual_delivery_time) AS year_,
    MONTH(actual_delivery_time) AS month_
FROM
    delivery_orders
LEFT JOIN
    order_value
ON
    delivery_orders.delivery_id = order_value.delivery_id
WHERE
    actual_delivery_time IS NOT NULL),

calc AS (
SELECT
    month_,
    restaurant_id,
    SUM(sales_amount) AS sales_amount,
    CASE WHEN SUM(sales_amount) > 100 THEN 1 ELSE 0 END AS above_100_flag,
    COUNT(*) OVER (PARTITION BY month_) AS total_rows
FROM
    base
WHERE
    year_ = 2021
GROUP BY
    month_,
    restaurant_id)
    
SELECT
    month_ AS month,
    SUM(above_100_flag) / MAX(total_rows) * 100 AS perc_over_100
FROM
    calc
GROUP BY
    month