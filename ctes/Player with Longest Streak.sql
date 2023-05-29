/* You are given a table of tennis players and their matches that they could either win (W) or lose (L). Find the longest streak of wins. A streak is a set of consecutive won matches of one player. The streak ends once a player loses their next match. Output the ID of the player or players and the length of the streak. */

WITH base AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY match_date) AS id
    
FROM
    players_results
ORDER BY
    player_id,
    match_date),

calc AS (
SELECT
    player_id,
    match_result,
    id,
    ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY match_date) AS id2,
    id - ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY match_date) AS diff
FROM
    base
WHERE
    match_result = 'W'
),

calc2 AS (
SELECT
    player_id,
    diff,
    COUNT(*) AS streak
FROM
    calc
GROUP BY
    player_id,
    diff),

calc3 AS (
SELECT
    player_id,
    streak,
    RANK() OVER(ORDER BY streak DESC) AS ranking
FROM
    calc2
GROUP BY
    player_id)


SELECT
    player_id,
    streak AS streak_length
FROM
    calc3
WHERE
    ranking = 1