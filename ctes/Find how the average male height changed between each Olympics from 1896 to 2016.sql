/* Find how the average male height changed between each Olympics from 1896 to 2016.
Output the Olympics year, average height, previous average height, and the corresponding average height difference.
Order records by the year in ascending order.


If avg height is not found, assume that the average height of an athlete is 172.73. */

WITH base AS (
SELECT
    DISTINCT id,
    year,
    height
FROM
    olympics_athletes_events
WHERE
    sex = 'M'),
    
calc AS (    
SELECT
    year,
    AVG(height) AS avg_height
FROM
    base
GROUP BY
    year
ORDER BY
    year),
    
calc_two AS (    
SELECT
    *,
    COALESCE(LAG(avg_height) OVER (), 172.73) AS prev_avg_height 
FROM 
    calc)
    
SELECT
    *,
    avg_height - prev_avg_height AS avg_height_diff
FROM
    calc_two