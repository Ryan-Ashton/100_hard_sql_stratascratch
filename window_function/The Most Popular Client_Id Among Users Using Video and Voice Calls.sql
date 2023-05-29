/* Select the most popular client_id based on a count of the number of users who have at least 50% of their events from the following list: 'video call received', 'video call sent', 'voice call received', 'voice call sent'. */

WITH base AS (
SELECT
    user_id,
    client_id,
    COUNT(event_id) AS counting_client_id,
    SUM(COUNT(event_id)) OVER (PARTITION BY user_id) AS total_count,
    COUNT(event_id)  / SUM(COUNT(event_id)) OVER (PARTITION BY user_id) AS perc
FROM
    fact_events
GROUP BY
    user_id,
    client_id
ORDER BY
    user_id)
    
SELECT
    client_id
FROM
    base
WHERE
    perc >= .5
GROUP BY
    client_id
ORDER BY
    COUNT(client_id) DESC
LIMIT 1