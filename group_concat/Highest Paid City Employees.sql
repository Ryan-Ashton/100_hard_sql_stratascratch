/* Find the top 2 highest paid City employees for each job title. Output the job title along with the corresponding highest and second-highest paid employees. */

WITH base AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY jobtitle ORDER BY totalpaybenefits DESC) AS ranking
FROM
    sf_public_salaries),
    
cterank AS (SELECT
    jobtitle,
    CASE WHEN ranking = 1 THEN employeename END best,
    CASE WHEN ranking = 2 THEN employeename END second_best
FROM
    base
WHERE
    ranking IN (1,2))
    
SELECT
    jobtitle,
    GROUP_CONCAT(best),
    GROUP_CONCAT(second_best)
FROM
    cterank
GROUP BY
    jobtitle