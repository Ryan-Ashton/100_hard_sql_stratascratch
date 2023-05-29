/* For every year, find the worst business in the dataset. The worst business has the most violations during the year. You should output the year, business name, and number of violations. */

WITH cte AS (
SELECT
    year(inspection_date) AS year_,
    business_name,
    COUNT(DISTINCT violation_id) AS violations
FROM
    sf_restaurant_health_violations
GROUP BY
    year_,
    business_name
ORDER BY
    violations DESC, year_, business_name),
    
cte_calc AS(
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY year_ ORDER BY violations DESC) AS ranking
FROM
    cte)
    
SELECT
    year_ AS year,
    business_name,
    violations
FROM
    cte_calc
WHERE
    ranking = 1