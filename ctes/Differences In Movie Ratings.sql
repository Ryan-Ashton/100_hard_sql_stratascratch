/* Calculate the average lifetime rating and rating from the movie with second biggest id across all actors and all films they had acted in. Remove null ratings from the calculation.
Role type is "Normal Acting". Output a list of actors, their average lifetime rating, rating from the film with the second biggest id (use id column), and the absolute difference between the two ratings. */

WITH base AS (
SELECT
    name
FROM
    nominee_filmography
WHERE
    role_type = 'Normal Acting'
),

second_last AS (
SELECT
    name,
    LEAD(rating, 1) OVER (PARTITION BY name ORDER BY id DESC) AS second_last_rating
FROM
    nominee_filmography
WHERE
    role_type = 'Normal Acting'
AND
    rating IS NOT NULL
),



lifetime AS (
SELECT
    name,
    AVG(rating) AS lifetime_rating
FROM
    nominee_filmography
WHERE
    rating IS NOT NULL
AND
    role_type = 'Normal Acting'
GROUP BY
    name)


SELECT
    base.name,
    MAX(second_last_rating) AS second_last_rating,
    MAX(lifetime_rating) AS lifetime_rating,
    ABS(MAX(lifetime_rating) - MAX(second_last_rating)) AS variance
FROM
    base
LEFT JOIN
    second_last
ON
    base.name = second_last.name
LEFT JOIN
    lifetime
ON
    base.name = lifetime.name
GROUP BY
    base.name
HAVING 
    second_last_rating IS NOT NULL