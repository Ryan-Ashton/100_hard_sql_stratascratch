/* Given the users' sessions logs on a particular day, calculate how many hours each user was active that day.
Note: The session starts when state=1 and ends when state=0. */

WITH l AS (SELECT
    *,
    LEAD(timestamp) OVER (PARTITION BY cust_id ORDER BY timestamp) AS not_active
FROM 
    cust_tracking
),
    
calc AS (    
    
SELECT
    *,
    CASE WHEN state = 1 THEN (TIME_TO_SEC(not_active) / (60 * 60)) - (TIME_TO_SEC(timestamp) / (60*60)) ELSE 0 END AS duration
FROM
    l)
   
   
SELECT
    cust_id,
    SUM(duration)
FROM
    calc
GROUP BY
    cust_id