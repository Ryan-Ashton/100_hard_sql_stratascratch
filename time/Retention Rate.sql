/* Find the monthly retention rate of users for each account separately for Dec 2020 and Jan 2021. Retention rate is the percentage of active users an account retains over a given period of time. In this case, assume the user is retained if he/she stays with the app in any future months. For example, if a user was active in Dec 2020 and has activity in any future month, consider them retained for Dec. You can assume all accounts are present in Dec 2020 and Jan 2021. Your output should have the account ID and the Jan 2021 retention rate divided by Dec 2020 retention rate. */

WITH base AS (
SELECT
    user_id,
    account_id,
    MIN(date) as min_date,
    MAX(date) as max_date
FROM
    sf_events

GROUP BY
    user_id),
    
calc AS
(
SELECT
    user_id,
    account_id,
    CASE WHEN max_date > '2020-12-31' THEN 1 ELSE 0 END AS dec_ret,
    CASE WHEN max_date > '2021-01-31' THEN 1 ELSE 0 END AS jan_ret 
FROM
    base) 

SELECT
    account_id,
    ROUND(SUM(jan_ret)/SUM(dec_ret)) AS retention_rate
FROM
    calc
GROUP BY
    account_id