/*Find the top 5 highest paid and top 5 least paid employees in 2012.
Output the employee name along with the corresponding total pay with benefits.
Sort records based on the total payment with benefits in ascending order. */

WITH cte AS (select
    *,
    ROW_NUMBER() OVER (ORDER BY totalpaybenefits DESC) AS ranking_up,
    ROW_NUMBER() OVER (ORDER BY totalpaybenefits ASC) AS ranking_down
from
    sf_public_salaries
WHERE
    year = 2012)

SELECT
    employeename,
    MAX(totalpaybenefits) AS totalpaybenefits
FROM
    cte
WHERE
    ranking_up <=5
OR
    ranking_down <= 5
GROUP BY
    employeename