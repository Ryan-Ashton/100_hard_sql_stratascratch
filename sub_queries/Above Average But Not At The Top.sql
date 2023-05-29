/* Find all people who earned more than the average in 2013 for their designation but were not amongst the top 5 earners for their job title.
 Use the totalpay column to calculate total earned and output the employee name(s) as the result. */

SELECT
    employeename
FROM(

select
    *,
    AVG(totalpay) OVER (PARTITION BY jobtitle) AS avg_pay,
    ROW_NUMBER() OVER (PARTITION BY jobtitle ORDER BY totalpay DESC) AS ranking_
from
    sf_public_salaries
WHERE
    year = 2013) sub_q
WHERE
    totalpay > avg_pay
AND
    ranking_ > 5