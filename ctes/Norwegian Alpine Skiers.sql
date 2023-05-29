-- Find all Norwegian alpine skiers who participated in 1992 but didn't participate in 1994. Output unique athlete names.

WITH base AS (
SELECT
    *
FROM
    olympics_athletes_events
WHERE
    team = 'Norway'
AND year IN (1992, 1994)
),

calc AS (
SELECT
    name,
    CASE WHEN year = 1992 THEN 1 END AS ninetwo,
    CASE WHEN year = 1994 THEN 1 END AS ninefour
FROM
    base
GROUP BY
    name)
    
SELECT
    name
FROM
    calc
WHERE
    ninetwo = 1
OR
    ninefour = 0