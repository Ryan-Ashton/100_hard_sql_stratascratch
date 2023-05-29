/*
Find how the number of drivers that have churned changed in each year compared to the previous one. Output the year (specifically, you can use the year the driver left Lyft) along with the corresponding number of churns in that year, the number of churns in the previous year, and an indication on whether the number has been increased (output the value 'increase'), decreased (output the value 'decrease') or stayed the same (output the value 'no change').
*/

WITH base AS (select
    *,
    year(start_date) AS start_date_year,
    year(end_date) AS end_date_year,
    CASE WHEN end_date IS NOT NULL THEN 1 END AS counting
from
    lyft_drivers),
    
cte_churn AS (

SELECT
    end_date_year,
    SUM(counting) AS n_churned
FROM
    base
WHERE end_date_year IS NOT NULL
GROUP BY
    end_date_year
ORDER BY
    end_date_year),

cte_prev AS (
SELECT
    *,
    COALESCE(LAG(n_churned) OVER (),0) AS n_churned_prev
FROM
    cte_churn)
    
SELECT
    *,
    CASE WHEN n_churned > n_churned_prev THEN 'increase' WHEN n_churned = n_churned_prev THEN 'no change' ELSE 'decrease' END AS case_
FROM
    cte_prev