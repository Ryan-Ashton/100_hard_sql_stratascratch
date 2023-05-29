/* Find the latest inspection date for the most sanitary restaurant(s). Assume the most sanitary restaurant is the one with the highest number of points received in any inspection (not just the last one). Only businesses with 'restaurant' in the name should be considered in your analysis.
Output the corresponding facility name, inspection score, latest inspection date, previous inspection date, and the difference between the latest and previous inspection dates. And order the records based on the latest inspection date in ascending order. */

WITH base AS (
SELECT
    *,
    RANK() OVER( ORDER BY score DESC) ranking,
    LAG(activity_date, 1) OVER (PARTITION BY facility_name ORDER BY activity_date) AS prev_activity_date
FROM
    los_angeles_restaurant_health_inspections
WHERE
    facility_name LIKE '%restaurant%'),
    
max_date AS (
SELECT
    facility_name,
    MAX(activity_date) AS max_activity_date
FROM
    base
GROUP BY
    facility_name
)

SELECT
    DISTINCT t1.facility_name,
    t1.score,
    t1.activity_date,
    t1.prev_activity_date,
    DATEDIFF(t1.activity_date, t1.prev_activity_date) AS number_of_days_between_high_scoring_inspections
FROM
    base t1
INNER JOIN
    max_date t2
ON
    t1.activity_date = t2.max_activity_date
WHERE
    ranking = 1
ORDER BY
    activity_date