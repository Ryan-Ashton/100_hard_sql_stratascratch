/*Find the median total pay for each job. Output the job title and the corresponding total pay, and sort the results from highest total pay to lowest.*/

WITH cte_calc AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY jobtitle ORDER BY totalpay DESC) AS median_helper,
    COUNT(*) OVER (PARTITION BY jobtitle) AS total
FROM
    sf_public_salaries
ORDER BY
    jobtitle ASC)
   

SELECT
    jobtitle,
    AVG(totalpay) AS median_pay
FROM
    cte_calc
WHERE
    IF(total % 2 = 0, total/2, CEILING(total/2)) = median_helper
    OR
    IF(total % 2 = 0, total/2 + 1, CEILING(total/2)) = median_helper
GROUP BY
    jobtitle
ORDER BY
    median_pay DESC