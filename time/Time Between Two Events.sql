/* Meta/Facebook's web logs capture every action from users starting from page loading to page scrolling. Find the user with the least amount of time between a page load and their first scroll down. Your output should include the user id, page load time, first scroll down time, and time between the two events in seconds. */

WITH base AS
(SELECT
    *,
    CASE WHEN action = 'page_load' THEN timestamp END AS load_time,
    MIN(CASE WHEN action = 'scroll_down' THEN timestamp END) AS scroll_time
    
FROM
    facebook_web_log
GROUP BY
    user_id)
    
SELECT
    user_id,
    load_time,
    scroll_time,
    TIME_FORMAT(TIMESTAMPDIFF(SECOND, load_time, scroll_time), "%H:%i:%s") AS duration
FROM
    base
ORDER BY
    duration
LIMIT 1