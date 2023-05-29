/* 
Find the number of medals earned in each category by Chinese athletes from the 2000 to 2016 summer Olympics. For each medal category, calculate the number of medals for each olympic games along with the total number of medals across all years. Sort records by total medals in descending order.
*/

WITH base AS (
SELECT
    medal,
    CASE WHEN year = 2000 THEN COUNT(medal) ELSE 0 END AS medals_2000,
    CASE WHEN year = 2004 THEN COUNT(medal) ELSE 0 END AS medals_2004,
    CASE WHEN year = 2008 THEN COUNT(medal) ELSE 0 END AS medals_2008,
    CASE WHEN year = 2012 THEN COUNT(medal) ELSE 0 END AS medals_2012,
    CASE WHEN year = 2016 THEN COUNT(medal) ELSE 0 END AS medals_2016
FROM
    olympics_athletes_events
WHERE
    team = 'China'
GROUP BY
    medal)
    
SELECT
    *,
    (medals_2000 + medals_2004 + medals_2008 + medals_2012 + medals_2016)  AS total_medals
FROM
    base
GROUP BY
    medal