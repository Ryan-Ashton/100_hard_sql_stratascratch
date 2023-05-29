/*
Find the average points difference between each and previous years starting from the year 2000. Output the year, average points, previous average points, and the difference between them.
If you're unable to calculate the average points rating for a specific year, use an 87 average points rating for that year (which is the average of all wines starting from 2000).
*/

WITH base AS (
SELECT
    regexp_substr(title,  '[0-9]{4}') AS year_,
    ROUND(AVG(points),3) AS avg_points
FROM
    winemag_p2
WHERE
    regexp_substr(title,  '[0-9]{4}') >= 2000
GROUP BY
    year_
ORDER BY
    year_)
    
SELECT
    *,
    COALESCE(LAG(avg_points, 1) OVER (), 87) AS prev_avg_points,
    avg_points - COALESCE(LAG(avg_points, 1) OVER (), 87) AS difference
FROM
    base