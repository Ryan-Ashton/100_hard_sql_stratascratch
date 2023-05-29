/* Write a query to return Territory and corresponding Sales Growth. Compare growth between periods Q4-2021 vs Q3-2021.
If Territory (say T123) has Sales worth $100 in Q3-2021 and Sales worth $110 in Q4-2021, then the Sales Growth will be 10% [ i.e. = ((110 - 100)/100) * 100 ]
Output the ID of the Territory and the Sales Growth. Only output these territories that had any sales in both quarters. */

WITH base AS (
SELECT
    t1.*,
    t2.territory_id,
    YEAR(order_date) AS year_,
    QUARTER(order_date) AS quarter_

FROM
    fct_customer_sales t1
LEFT JOIN
    map_customer_territory t2
ON
    t1.cust_id = t2.cust_id
WHERE
    YEAR(order_date) = 2021),
    
calc AS (
SELECT
    territory_id,
    year_,
    quarter_,
    CASE WHEN quarter_ = 3 THEN SUM(order_value) ELSE 0 END AS q3,
    CASE WHEN quarter_ = 4 THEN SUM(order_value) ELSE 0 END AS q4
FROM
    base
WHERE
    year_ = 2021
AND
    quarter_ = 3 OR quarter_ = 4
GROUP BY
    territory_id,
    year_,
    quarter_
ORDER BY
    territory_id)

SELECT
    territory_id,
    ROUND((SUM(q4) / SUM(q3) - 1) * 100,3) AS sales_growth
FROM
    calc
GROUP BY
    territory_id
HAVING
    sales_growth IS NOT NULL