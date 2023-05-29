/* For the video (or videos) that received the most user flags, how many of these flags were reviewed by YouTube? Output the video ID and the corresponding number of reviewed flags. */

SELECT
    video_id,
    num_flags_reviewed_by_yt
FROM(

    SELECT
        video_id,
        COUNT(t1.flag_id) AS count_flag,
        SUM(reviewed_by_yt) AS num_flags_reviewed_by_yt
    FROM
        user_flags t1
    LEFT JOIN
        flag_review t2
    ON
        t1.flag_id = t2.flag_id
    GROUP BY
        video_id) sub_q

WHERE count_flag = (
    SELECT MAX(count_flag)
    FROM (
        SELECT
            video_id,
            COUNT(t1.flag_id) AS count_flag
        FROM
            user_flags t1
        LEFT JOIN
            flag_review t2 ON t1.flag_id = t2.flag_id
        GROUP BY
            video_id) sub_q2)