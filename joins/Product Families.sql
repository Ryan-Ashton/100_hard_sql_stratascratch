/* The CMO is interested in understanding how the sales of different product families are affected by promotional campaigns. To do so, for each product family, show the total number of units sold, as well as the percentage of units sold that had a valid promotion among total units sold. If there are NULLS in the result, replace them with zeroes. Promotion is valid if it's not empty and it's contained inside promotions table. */

WITH base AS (select
    product_family,
    COALESCE(SUM(t2.units_sold),0) AS units_sold,
    COALESCE(SUM(CASE WHEN date BETWEEN start_date AND end_date THEN t2.units_sold END),0) AS promo
from
    facebook_products t1
LEFT JOIN
    facebook_sales t2
ON
    t1.product_id = t2.product_id
LEFT JOIN
    facebook_sales_promotions t3
ON
    t2.promotion_id = t3.promotion_id
GROUP BY
    product_family)
    
SELECT
    product_family,
    units_sold,
    COALESCE(promo/units_sold * 100,0)
FROM
    base