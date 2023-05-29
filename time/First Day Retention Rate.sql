/* Calculate the first-day retention rate of a group of video game players. The first-day retention occurs when a player logs in 1 day after their first-ever log-in.
Return the proportion of players who meet this definition divided by the total number of players. */

WITH base AS (
SELECT
    *,
    RANK() OVER (PARTITION BY player_id ORDER BY login_date) AS first_day
FROM
    players_logins),
    
    
calc AS (    
SELECT
    *,
    DATEDIFF(login_date, LAG(login_date, 1) OVER (PARTITION BY player_id)) AS flag

FROM
    base
WHERE
    first_day IN (1, 2))
    
SELECT
    SUM(CASE WHEN flag = 0 OR flag = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT player_id) AS retention_rate
FROM
    calc