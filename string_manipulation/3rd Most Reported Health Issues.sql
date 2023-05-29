/* Each record in the table is a reported health issue and its classification is categorized by the facility type, size, risk score which is found in the pe_description column.
If we limit the table to only include businesses with Cafe, Tea, or Juice in the name, find the 3rd most common category (pe_description). Output the name of the facilities that contain 3rd most common category. */

WITH base AS (
SELECT
    *,
    COUNT(record_id) OVER (PARTITION BY pe_description) AS counting
FROM
    los_angeles_restaurant_health_inspections
WHERE
    REGEXP_LIKE(facility_name,'cafe|juice|tea')
),

calc AS (
SELECT
    pe_description,
    SUM(counting) AS counted
FROM
    base
GROUP BY
    pe_description
ORDER BY
    counted DESC),

description AS (
SELECT
    *,
    DENSE_RANK() OVER (ORDER BY counted DESC) AS ranking
FROM
    calc)

SELECT
    facility_name
FROM
    base
WHERE
    pe_description IN (

SELECT
    pe_description
FROM
    description
WHERE
    ranking = 3)