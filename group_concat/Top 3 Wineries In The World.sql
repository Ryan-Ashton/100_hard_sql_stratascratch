/*Find the top 3 wineries in each country based on the average points earned. In case there is a tie, order the wineries by winery name in ascending order. Output the country along with the best, second best, and third best wineries. If there is no second winery (NULL value) output 'No second winery' and if there is no third winery output 'No third winery'. For outputting wineries format them like this: "winery (avg_points)"*/

WITH cte AS (
SELECT
    country,
    CASE WHEN ranking = 1 THEN CONCAT(winery, ' (', ROUND(avg_points,0), ')')  END AS top_winery,
    CASE WHEN ranking = 2 THEN CONCAT(winery, ' (', ROUND(avg_points,0), ')')  END AS second_winery,
    CASE WHEN ranking = 3 THEN CONCAT(winery, ' (', ROUND(avg_points,0), ')' ) END AS third_winery
FROM(

SELECT
    *,
    AVG(points) AS avg_points,
    RANK() OVER(PARTITION BY country ORDER BY AVG(points) DESC, winery) ranking
FROM
    winemag_p1
GROUP BY
    country,
    winery) sub_q)
    
SELECT
  country,
  GROUP_CONCAT(DISTINCT top_winery ORDER BY top_winery ASC SEPARATOR ', ') AS top_wineries,
  COALESCE(GROUP_CONCAT(DISTINCT second_winery ORDER BY second_winery ASC SEPARATOR ', '),'No second winery') AS second_wineries,
  COALESCE(GROUP_CONCAT(DISTINCT third_winery ORDER BY third_winery ASC SEPARATOR ', '), 'No third winery') AS third_wineries
FROM
  cte
GROUP BY
  country
    
