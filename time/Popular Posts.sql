/* The column 'perc_viewed' in the table 'post_views' denotes the percentage of the session duration time the user spent viewing a post. Using it, calculate the total time that each post was viewed by users. Output post ID and the total viewing time in seconds, but only for posts with a total viewing time of over 5 seconds. */

WITH base AS (SELECT
    session_id,
    TIMESTAMPDIFF(SECOND, session_starttime, session_endtime) AS active_sesh
FROM
    user_sessions
WHERE
    TIMESTAMPDIFF(SECOND, session_starttime, session_endtime) > 5
),

calc2 AS (
SELECT
    t1.*,
    t2.active_sesh,
    (t1.perc_viewed / 100) * t2.active_sesh total_viewtime
FROM
    post_views t1
LEFT JOIN
    base t2
ON
    t1.session_id = t2.session_id
)

SELECT
    post_id,
    SUM(total_viewtime) AS total_viewtime
FROM
    calc2
GROUP BY
    post_id
HAVING
    total_viewtime > 5