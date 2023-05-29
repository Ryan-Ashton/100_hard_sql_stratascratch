/* For each unique user in the dataset, find the latest date when their flags got reviewed. Then, find total number of distinct videos that were removed on that date (by any user).
Output the the first and last name of the user (in two columns), the date and the number of removed videos. Only include these users who had at least one of their flags reviewed by Youtube. If no videos got removed on a certain date, output 0. */

WITH base AS (
SELECT
    t1.*,
    t2.reviewed_by_yt,
    t2.reviewed_date,
    reviewed_outcome
FROM
    user_flags t1
LEFT JOIN
    flag_review t2
ON
    t1.flag_id = t2.flag_id

),


map AS (

SELECT
    user_firstname,
    user_lastname,
    MAX(reviewed_date) AS reviewed_date
FROM
    base
WHERE
    reviewed_date IS NOT NULL
GROUP BY
    user_firstname,
    user_lastname

),
    
latest AS (
SELECT
    reviewed_date,
    IFNULL(count(distinct video_id),0) as n_removed
FROM
    flag_review t1
LEFT JOIN
    user_flags t2
ON
    t1.flag_id = t2.flag_id
WHERE
    reviewed_outcome IN ('REMOVED')
GROUP BY
    reviewed_date
)


SELECT
    t1.user_firstname,
    t1.user_lastname,
    t1.reviewed_date,
    COALESCE(n_removed,0) AS n_removed
FROM
    map t1
LEFT JOIN
    latest t2
ON
    t1.reviewed_date = t2.reviewed_date