/* Find the median employee salary of each department.
Output the department name along with the corresponding salary rounded to the nearest whole dollar. */

WITH cte_calc AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS median_helper,
    COUNT(*) OVER (PARTITION BY department) AS total
FROM
    employee
ORDER BY
    department ASC)
   

SELECT
    department,
    AVG(salary) AS median_salary
FROM
    cte_calc
WHERE
    IF(total % 2 = 0, total/2, CEILING(total/2)) = median_helper
    OR
    IF(total % 2 = 0, total/2 + 1, CEILING(total/2)) = median_helper
GROUP BY
    department