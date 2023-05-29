/* A movie theater gave you two tables: seats that are available for an upcoming screening and neighboring seats for each seat listed. You are asked to find all pairs of seats that are both adjacent and available.
Output only distinct pairs of seats in two columns such that the seat with the lower number is always in the first column and the one with the higher number is in the second column. */

WITH base AS (
    SELECT 
        seat_number AS base_seat_number,
        seat_left AS adjacent
    FROM theater_seatmap
    UNION ALL
    SELECT 
        seat_number AS base_seat_number,
        seat_right AS adjacent
    FROM theater_seatmap
),
calc AS (
    SELECT *
    FROM base t1
    INNER JOIN (SELECT seat_number FROM theater_availability WHERE is_available = 1) t2
    ON t1.base_seat_number = t2.seat_number
    WHERE adjacent IS NOT NULL
),

calc2 AS (
SELECT 
    t1.base_seat_number,
    t1.adjacent,
    t1.base_seat_number + t1.adjacent AS check_
FROM
    calc t1
INNER JOIN
    (SELECT seat_number FROM theater_availability WHERE is_available = 1) t2
ON 
    t1.adjacent = t2.seat_number
ORDER BY
    base_seat_number),

calc3 AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY check_ ORDER BY base_seat_number ASC) keep 
FROM
    calc2)
    
SELECT
    base_seat_number AS available_seat_1,
    adjacent AS available_seat_2
FROM
    calc3
WHERE
    keep = 1
