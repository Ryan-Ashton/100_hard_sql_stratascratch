/*
Find the number of police officers (job title contains substring police), firefighters (job title contains substring fire), and medical staff employees (job title contains substring medical) based on the employee name.
Output each job title along with the corresponding number of employees.
*/

SELECT
    company,
    COUNT(company) AS n_employees
FROM(
select
    *,
    CASE WHEN LOWER(jobtitle) LIKE '%firefighter' THEN 'Firefighter'
        WHEN LOWER(jobtitle) LIKE '%police%' THEN 'Police'
        WHEN LOWER(jobtitle) LIKE '%medical%' THEN 'Medical Staff'
        END AS company
from
    sf_public_salaries
WHERE
    LOWER(jobtitle) LIKE '%firefighter%'
OR
    LOWER(jobtitle) LIKE '%police%'
OR
    LOWER(jobtitle) LIKE '%medical%') sub_q
    
GROUP BY
    company
ORDER BY
    n_employees