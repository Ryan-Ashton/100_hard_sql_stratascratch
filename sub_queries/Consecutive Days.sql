-- Find all the users who were active for 3 consecutive days or more.

SELECT
    user_id
FROM
(
SELECT
    user_id,
    DATEDIFF(date, LAG(date,2) OVER (PARTITION BY user_id ORDER BY date)) + 1 AS flag
FROM
    sf_events) sub_q

WHERE flag = 3