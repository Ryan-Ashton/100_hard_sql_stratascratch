-- Find all wines from the winemag_p2 dataset which are produced in the country that have the highest sum of points in the winemag_p1 dataset.

SELECT
    *
FROM
    winemag_p2
WHERE
    country IN (

SELECT
    country
FROM(
SELECT
    country,
    SUM(points)
FROM
    winemag_p1
GROUP BY
    country
LIMIT 1) sub_q)