-- Find the advertising channel with the smallest maximum yearly spending that still brings in more than 1500 customers each year.

WITH cte AS (
SELECT
    *,
    MAX(money_spent) OVER (PARTITION BY advertising_channel) As max_spend
FROM
    uber_advertising
WHERE
    customers_acquired > 1500),

cte_rank AS (

SELECT
    *,
    RANK() OVER (ORDER BY max_spend) AS ranking
FROM
    cte)
    
SELECT
    advertising_channel
FROM
    cte_rank
WHERE
    ranking = 1
GROUP BY
    advertising_channel