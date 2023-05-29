/*Find the top 3 medal-winning teams by counting the total number of medals for each event in the Rio De Janeiro 2016 olympics. In case there is a tie, order the countries by name in ascending order. Output the event name along with the top 3 teams as the 'gold team', 'silver team', and 'bronze team', with the team name and the total medals under each column in format "{team} with {number of medals} medals". Replace NULLs with "No Team" string. */

WITH base AS (
SELECT 
    olympics_athletes_events.event,
    team,
    COUNT(medal) AS counting
FROM
    olympics_athletes_events
WHERE
    year=2016
AND 
    medal IS NOT NULL
GROUP BY
    olympics_athletes_events.event,
    team
),

calc_rank AS (

SELECT
    base.event,
    team,
    counting,
    RANK() OVER (PARTITION BY base.event ORDER BY counting DESC, team ASC) AS ranking
FROM
    base
)

SELECT
    calc_rank.event,
    COALESCE(MAX(CASE
        WHEN ranking = 1 THEN CONCAT(team, " with ", counting, " medals") ELSE NULL END), "No Team") AS gold_team,
    COALESCE(MAX(CASE
        WHEN ranking = 2 THEN CONCAT(team, " with ", counting, " medals") ELSE NULL END), "No Team") AS silver_team,
    COALESCE(MAX(CASE
        WHEN ranking = 3 THEN CONCAT(team, " with ", counting, " medals") ELSE NULL END), "No Team") AS bronze_team
FROM
    calc_rank
GROUP BY
    calc_rank.event