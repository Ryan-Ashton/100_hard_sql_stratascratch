/* Find the gender ratio between the number of men and women who participated in each Olympics.
Output the Olympics name along with the corresponding number of men, women, and the gender ratio. If there are Olympics with no women, output a NULL instead of a ratio. */

WITH males AS (
SELECT
    games,
    COUNT(DISTINCT id) AS male_count
    
FROM
    olympics_athletes_events
WHERE
    sex = 'M'
GROUP BY
    games),
    
females AS (
select
    games,
    COUNT(DISTINCT id) AS female_count
    
from
    olympics_athletes_events
WHERE
    sex = 'F'
GROUP BY
    games
)

SELECT
    DISTINCT t1.games,
    COALESCE(male_count,0) AS male_count,
    COALESCE(female_count,0) AS female_count,
    CASE
    WHEN female_count = 0 AND male_count > 0 THEN NULL
    WHEN female_count > 0 AND male_count = 0 OR male_count IS NULL THEN 0 
    ELSE male_count / female_count END AS gender_ratio
FROM
    olympics_athletes_events t1
LEFT JOIN
    males
ON
    t1.games = males.games
LEFT JOIN
    females
ON
    t1.games = females.games