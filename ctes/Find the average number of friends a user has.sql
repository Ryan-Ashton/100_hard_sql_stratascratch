-- Find the average number of friends a user has.

WITH base AS (select
    * 
from
    google_friends_network

UNION

SELECT
    friend_id,
    user_id
FROM
    google_friends_network),

calc AS (
SELECT
    user_id,
    COUNT( DISTINCT friend_id) AS counting
FROM
    base
GROUP BY
    user_id)
    
SELECT
    AVG(counting) AS avg_fr
FROM
    calc