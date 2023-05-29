/* Find the connection between the number of letters in the athlete's first name and the number of medals won for each type for medal, including no medals. Output the length of the name along with the corresponding number of no medals, bronze medals, silver medals, and gold medals. */

WITH base AS (SELECT
    *,
    LENGTH(SUBSTRING_INDEX(name, ' ', 1)) AS length_of_name,
    CASE WHEN medal IS NULL THEN 1 ELSE 0 END AS no_medals,
    CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END AS bronze_medals,
    CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END AS silver_medals,
    CASE WHEN medal = 'Gold' THEN 1 ELSE 0 END AS  gold_medals
FROM
    olympics_athletes_events
)

SELECT
    length_of_name,
    SUM(no_medals) AS no_medals,
    SUM(bronze_medals) AS bronze_medals,
    SUM(silver_medals) AS silver_medals,
    SUM(gold_medals) AS gold_medals
FROM
    base
GROUP BY
    length_of_name