/*Find the top 5 least paid employees for each job title.
Output the employee name, job title and total pay with benefits for the first 5 least paid employees. Avoid gaps in ranking. */

SELECT
    employeename,
    jobtitle,
    totalpaybenefits
FROM(

select
    *,
    ROW_NUMBER() OVER (PARTITION BY jobtitle ORDER BY totalpaybenefits) AS ranking
from
    sf_public_salaries) sub_q
    
WHERE 
    ranking <= 5