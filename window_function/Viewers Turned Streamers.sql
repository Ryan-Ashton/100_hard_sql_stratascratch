/* From users who had their first session as a viewer, how many streamer sessions have they had? Return the user id and number of sessions in descending order. In case there are users with the same number of sessions, order them by ascending user id. */

WITH user_flag AS (
SELECT
    *,
    CASE WHEN RANK() OVER (PARTITION BY user_id ORDER BY session_end) = 1 AND session_type='viewer' THEN 1 ELSE 0 END AS flag
FROM
    twitch_sessions)
    
SELECT
    user_flag.user_id,
    SUM(CASE WHEN twitch_sessions.session_type = 'streamer' THEN 1 ELSE 0 END) AS n_sessions
FROM
    user_flag
LEFT JOIN
    twitch_sessions
ON
    user_flag.user_id = twitch_sessions.user_id
WHERE
    flag = 1
GROUP BY
    user_flag.user_id