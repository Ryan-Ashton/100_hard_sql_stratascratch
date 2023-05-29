/*Write a query to calculate the distribution of comments by the count of users that joined Meta/Facebook between 2018 and 2020, for the month of January 2020.
The output should contain a count of comments and the corresponding number of users that made that number of comments in Jan-2020. For example, you'll be counting how many users made 1 comment, 2 comments, 3 comments, 4 comments, etc in Jan-2020. Your left column in the output will be the number of comments while your right column in the output will be the number of users. Sort the output from the least number of comments to highest.
To add some complexity, there might be a bug where an user post is dated before the user join date. You'll want to remove these posts from the result. */

WITH rules AS (SELECT
    user_id,
    COUNT(body) AS comment_cnt
FROM
    fb_users t1
JOIN 
    fb_comments t2
ON 
    t1.id = t2.user_id
WHERE
    created_at BETWEEN '2020-01-01' AND '2020-01-31'
AND
    joined_at BETWEEN '2018-01-01' AND '2020-12-31'
AND
    created_at > joined_at
GROUP BY
    user_id)
    
SELECT
    comment_cnt,
    COUNT(user_id) AS user_id
FROM
    rules
GROUP BY
    comment_cnt
ORDER BY
    comment_cnt


