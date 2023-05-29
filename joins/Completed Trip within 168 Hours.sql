/* An event is logged in the events table with a timestamp each time a new rider attempts a signup (with an event name 'attempted_su') or successfully signs up (with an event name of 'su_success').
For each city and date, determine the percentage of signups in the first 7 days of 2022 that completed a trip within 168 hours of the signup date. HINT: driver id column corresponds to rider id column */

WITH signups AS (
SELECT
    *,
    DATE(timestamp) AS date_,
    DATE_ADD(timestamp, INTERVAL +7 DAY) seven_days
FROM
    signup_events
WHERE
    (DATE(timestamp) BETWEEN "2022-01-01" AND "2022-01-07")
AND
    event_name = 'su_success')
    
SELECT
    t1.city_id,
    t1.date_, 
    COUNT(DISTINCT t2.driver_id) * 100 / COUNT(DISTINCT t1.rider_id) as percentage
FROM
    signups t1 
LEFT JOIN
    trip_details t2 
ON
    t1.rider_id = t2.driver_id

-- Maintain the number of rows on the left by continuining the join
AND 
    t2.status = 'completed'
-- Maintain the number of rows on the left by continuining the join
AND 
    t2.request_at >= t1.date_
-- Maintain the number of rows on the left by continuining the join
AND 
    t2.request_at < DATE_ADD(DATE(timestamp), INTERVAL +7 DAY) 
GROUP BY
    t1.city_id,
    t1.date_

