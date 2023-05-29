/* Provided a table with user id and the dates they visited the platform, find the top 3 users with the longest continuous streak of visiting the platform as of August 10, 2022. Output the user ID and the length of the streak.
In case of a tie, display all users with the top three longest streaks. */

WITH base AS (
SELECT
    user_id, 
    DATE(date_visited) AS date_visited
FROM 
    user_streaks
WHERE
    date_visited <= '2022-08-10'
GROUP BY
    user_id,
    date_visited),


calc AS 
(SELECT 
    *, 
    row_number () over (PARTITION BY user_id ORDER BY date_visited) AS counting,
    date_visited - row_number () over (PARTITION BY user_id ORDER BY date_visited) as flag
FROM 
    base),

calc2 AS 
(SELECT 
    user_id, 
    flag, 
    COUNT(flag) as streak_count
FROM
    calc 
GROUP BY
    user_id,
    flag)

SELECT 
    user_id,
    MAX(streak_count) AS streak_length
FROM calc2
GROUP BY
    user_id
ORDER BY
    streak_length DESC
LIMIT 3