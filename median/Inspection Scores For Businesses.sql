/* Find the median inspection score of each business and output the result along with the business name. Order records based on the inspection score in descending order.
Try to come up with your own precise median calculation. In Postgres there is percentile_disc function available, however it's only approximation. */

WITH cte_calc AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY business_name ORDER BY inspection_score DESC) AS median_helper,
    COUNT(business_name) OVER (PARTITION BY business_name) AS total
FROM
    sf_restaurant_health_violations
WHERE
    inspection_score IS NOT NULL
ORDER BY
    business_name ASC)
   

SELECT
    business_name,
    AVG(inspection_score) AS median_inspection_score
FROM
    cte_calc
WHERE
    IF(total % 2 = 0, total/2, CEILING(total/2)) = median_helper
    OR
    IF(total % 2 = 0, total/2 + 1, CEILING(total/2)) = median_helper
        
GROUP BY
    business_name
HAVING
    median_inspection_score IS NOT NULL
ORDER BY
    median_inspection_score DESC