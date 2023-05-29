-- Find the IDs of the drivers who completed at least one trip a month for at least two months in a row.

WITH base AS (
SELECT
    driver_id,
    MONTH(trip_date) AS month_,
    LEAD(MONTH(trip_date), 1) OVER (PARTITION BY driver_id ORDER BY trip_date) AS calc
    
FROM
    uber_trips
WHERE
    is_completed = 1
GROUP BY
    month_,
    driver_id
ORDER BY
    driver_id,
    month_)
    
SELECT
    driver_id
FROM
    base
WHERE
    calc - month_ = 1
OR
    calc - month_ = -11
GROUP BY
    driver_id