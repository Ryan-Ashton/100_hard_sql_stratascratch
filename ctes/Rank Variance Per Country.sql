/* Which countries have risen in the rankings based on the number of comments between Dec 2019 vs Jan 2020? Hint: Avoid gaps between ranks when ranking countries. */

WITH dec_ AS (

SELECT
    country,
    SUM(number_of_comments) AS dec_comments,
    DENSE_RANK() OVER (ORDER BY SUM(number_of_comments) DESC) AS dec_ranking
FROM
    fb_comments_count t1
LEFT JOIN
    fb_active_users t2
ON
    t1.user_id = t2.user_id
WHERE
    created_at Between '2019-12-01' AND '2019-12-31'
AND
    t2.country IS NOT NULL
GROUP BY
    country
),



jan AS (

SELECT
    country,
    SUM(number_of_comments) AS jan_comments,
    DENSE_RANK() OVER (ORDER BY SUM(number_of_comments) DESC) AS jan_ranking
FROM
    fb_comments_count t1
LEFT JOIN
    fb_active_users t2
ON
    t1.user_id = t2.user_id
WHERE
    created_at Between '2020-01-01' AND '2020-01-31'
AND
    t2.country IS NOT NULL
GROUP BY
    country
),

calc AS (
SELECT
    jan.country,
    dec_comments,
    jan_comments,
    dec_ranking,
    jan_ranking
FROM
    dec_
RIGHT JOIN
    jan
ON
    dec_.country = jan.country)
    
SELECT
    country
FROM
    calc
WHERE
    jan_ranking < COALESCE(dec_ranking,99)