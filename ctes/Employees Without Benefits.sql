/*Find the ratio between the number of employees without benefits to total employees. Output the job title, number of employees without benefits, total employees relevant to that job title, and the corresponding ratio. Order records based on the ratio in ascending order. */

WITH base AS (
SELECT
    *,
    CASE WHEN benefits <= 0 OR benefits IS NULL THEN 1 ELSE 0 END AS counting
    
FROM
    sf_public_salaries),

calc AS (
SELECT
    jobtitle,
    SUM(counting) AS no_employees_without_benefits,
    COUNT(id) AS total_people
FROM
    base
GROUP BY
    jobtitle)
    
SELECT
    *,
    no_employees_without_benefits / total_people AS rto
FROM
    calc