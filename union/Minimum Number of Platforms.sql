/* You are given a day worth of scheduled departure and arrival times of trains at one train station. One platform can only accommodate one train from the beginning of the minute it's scheduled to arrive until the end of the minute it's scheduled to depart. Find the minimum number of platforms necessary to accommodate the entire scheduled traffic. */

WITH base AS (
SELECT
    train_id, 
    arrival_time AS time,
    1 as flag 
FROM
    train_arrivals
UNION ALL 
SELECT
    train_id, 
    departure_time AS time,
    -1 AS flag 
FROM
    train_departures 
ORDER BY
    time),
    
calc AS (
SELECT
    *,
    SUM(flag) OVER (ORDER BY time, flag DESC ) n_trains_on_platform
FROM
    base
)

SELECT
    MAX(n_trains_on_platform)
FROM
    calc