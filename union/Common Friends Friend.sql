/* Find the number of a user's friends' friend who are also the user's friend. Output the user id along with the count. */

WITH base AS (
SELECT
    * 
FROM
    google_friends_network
UNION
SELECT
    friend_id,
    user_id
FROM
    google_friends_network),
    
calc AS (
SELECT
    t1.user_id,
    t2.friend_id
FROM 
    base t1
INNER JOIN
    base t2
ON
    t1.friend_id = t2.user_id
WHERE
    t1.friend_id = t2.user_id)
    
SELECT
    t1.user_id,
    COUNT(DISTINCT t2.friend_id) AS n_friends
FROM
    base t1
INNER JOIN
    calc t2
ON
    t1.user_id = t2.user_id
AND
    t2.friend_id = t1.friend_id
GROUP BY
    t1.user_id