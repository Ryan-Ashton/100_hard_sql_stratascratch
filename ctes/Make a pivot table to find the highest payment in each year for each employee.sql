/*Make a pivot table to find the highest payment in each year for each employee.
Find payment details for 2011, 2012, 2013, and 2014.
Output payment details along with the corresponding employee name.
Order records by the employee name in ascending order */

WITH cte AS (select
    employeename,
    (CASE WHEN year = 2011 THEN totalpay ELSE 0 END) AS pay_2011,
    (CASE WHEN year = 2012 THEN totalpay ELSE 0 END) AS pay_2012,
    (CASE WHEN year = 2013 THEN totalpay ELSE 0 END) AS pay_2013,
    (CASE WHEN year = 2014 THEN totalpay ELSE 0 END) AS pay_2014
from
    sf_public_salaries
ORDER BY
    employeename)
    
SELECT
    employeename,
    SUM(pay_2011) AS pay_2011,
    SUM(pay_2012) AS pay_2012,
    SUM(pay_2013) AS pay_2013,
    SUM(pay_2014) AS pay_2014
FROM
    cte
GROUP BY
    employeename
ORDER BY
    employeename
