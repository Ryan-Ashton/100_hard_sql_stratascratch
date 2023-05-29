/*Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers.
 The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads. */

 WITH cte_base AS (select
    t1.user_id,
    t1.acc_id,
    date,
    paying_customer,
    downloads,
    (CASE WHEN paying_customer = 'no' THEN downloads ELSE 0 END) AS non_paying,
    (CASE WHEN paying_customer = 'yes' THEN downloads ELSE 0 END) AS paying
from
    ms_user_dimension t1
LEFT JOIN 
    ms_acc_dimension t2
ON 
    t1.acc_id = t2.acc_id
LEFT JOIN
    ms_download_facts t3
ON
    t1.user_id = t3.user_id
ORDER BY
    date)
    
SELECT 
    date,
    SUM(non_paying) AS non_paying,
    SUM(paying) AS paying
FROM
    cte_base
GROUP BY
    date
HAVING
    non_paying > paying
ORDER BY
    date ASC
    