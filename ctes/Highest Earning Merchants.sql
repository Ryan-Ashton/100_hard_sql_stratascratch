/* Each day, you have been asked to find a merchant who earned more money the previous day.
Before comparing totals between merchants, round the total amounts to the nearest 2 decimals places.
Your output should include the date in the format 'YYYY-MM-DD' and the merchant's name, but only for days where data from the previous day is available.
Note: In the case of multiple merchants having the same highest shared amount, your output should include all the names in different rows. */

WITH base AS (
SELECT
    name,
    DATE(order_timestamp) AS date_,
    SUM(total_amount_earned) AS total_amount_earned
FROM
    order_details t1
LEFT JOIN
    merchant_details t2
ON
    t1.merchant_id = t2.id
GROUP BY
    merchant_id,
    date_
ORDER BY
    name,
    date_
),

calc AS (
SELECT
    name,
    date_,
    total_amount_earned,
    DATE_FORMAT(DATE_ADD(date_, INTERVAL 1 DAY), "%Y-%m-%d") AS date,
    LAG(total_amount_earned,1) OVER (PARTITION BY name ORDER BY date_) AS lagging,
    DENSE_RANK() OVER (PARTITION BY date_ ORDER BY ROUND(SUM(total_amount_earned),2)  DESC) AS ranking 
FROM
    base
GROUP BY
    name,
    date_
)

SELECT
    date,
    name
FROM
    calc
WHERE
    ranking = 1