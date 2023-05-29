-- Find the highest salary among salaries that appears only once.

SELECT
    MAX(salary) AS max_salary
FROM (    

select
    DISTINCT salary
from
    employee) sub_q