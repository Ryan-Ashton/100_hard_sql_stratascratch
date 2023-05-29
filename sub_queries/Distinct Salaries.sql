/*
Find the top three distinct salaries for each department. Output the department name and the top 3 distinct salaries by each department. Order your results alphabetically by department and then by highest salary to lowest. */

SELECT
    department,
    salary
    
FROM (

select
    *,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS ranking 
from
    twitter_employee) sub_q
    
WHERE
    ranking <= 3
GROUP BY
    department,
    salary