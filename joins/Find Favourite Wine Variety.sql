/*
Find each taster's favorite wine variety.
Consider that favorite variety means the variety that has been tasted by most of the time.
Output the taster's name along with the wine variety.
*/

WITH cte_calc AS 
(SELECT
    *,
    COUNT(variety) OVER (PARTITION BY taster_name, variety) AS counting
FROM
    winemag_p2
WHERE 
    taster_name IS NOT NULL
ORDER BY
    taster_name)

SELECT
    t1.taster_name,
    t1.variety
FROM
    cte_calc t1
    
INNER JOIN
(
SELECT
    taster_name,
    MAX(counting) AS max_
FROM
    cte_calc
GROUP BY
    taster_name) t2
ON
    t1.taster_name = t2.taster_name
    AND
    t1.counting = t2.max_
GROUP BY
    taster_name,
    variety

