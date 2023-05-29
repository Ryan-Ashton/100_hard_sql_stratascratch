/* Find the price that a small handyman business is willing to pay per employee. Get the result based on the mode of the adword earnings per employee distribution. Small businesses are considered to have not more than ten employees. */

WITH cte AS (SELECT
    pay,
    COUNT(pay) AS counting
    
FROM(
SELECT
    *,
    adwords_earnings / n_employees AS pay
FROM
    google_adwords_earnings
WHERE
    n_employees <= 10
AND
    business_type = 'handyman'
ORDER BY
    pay DESC) sub_q
GROUP BY
    pay
ORDER BY
    counting DESC)
    
SELECT
    pay
FROM
    cte
LIMIT 1