/* Write a query to find the number of days between the longest and least tenured employee still working for the company. Your output should include the number of employees with the longest-tenure, the number of employees with the least-tenure, and the number of days between both the longest-tenured and least-tenured hiring dates. */

WITH base AS (
SELECT
    *,
    DATEDIFF(COALESCE(termination_date, CURDATE()), hire_date) AS diff
FROM
    uber_employees
WHERE
    termination_date IS NULL),
    
calc AS (
SELECT
    *,
    MIN(diff) OVER () AS minimum,
    MAX(diff) OVER () AS maximum
FROM
    base)
    
SELECT
    SUM(IF(minimum=diff, 1, 0)) AS shortest_tenured_count,
    SUM(IF(maximum=diff, 1, 0)) AS longest_tenured_count,
    maximum - minimum AS days_diff
FROM
    calc