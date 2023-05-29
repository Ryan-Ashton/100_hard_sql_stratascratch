/*Find the popularity percentage for each user on Meta/Facebook. The popularity percentage is defined as the total number of friends the user has divided by the total number of users on the platform, then converted into a percentage by multiplying by 100.
Output each user along with their popularity percentage. Order records in ascending order by user id.
The 'user1' and 'user2' column are pairs of friends. */

WITH total_users AS (
    SELECT
        user1,
        user2
    FROM
        facebook_friends
UNION
    SELECT
        user2,
        user1
    FROM
        facebook_friends
    )
    

SELECT 
    user1,
    (COUNT(user2) / (SELECT COUNT(DISTINCT(user1)) FROM total_users)) * 100 AS pop_perc
FROM
    total_users
GROUP BY
    user1
ORDER BY
    user1