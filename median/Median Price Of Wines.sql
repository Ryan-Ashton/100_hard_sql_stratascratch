/*Find the median price for each wine variety across both datasets. Output distinct varieties along with the corresponding median price.*/

WITH all_cte AS (SELECT
    variety,
    price
FROM
    winemag_p1
WHERE
    price IS NOT NULL

UNION ALL

SELECT
    variety,
    price
FROM
    winemag_p2
WHERE
    price IS NOT NULL),
    
cte_calc AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY variety ORDER BY price ASC) AS median_helper,
    COUNT(*) OVER (PARTITION BY variety) AS total
FROM
    all_cte
ORDER BY
    variety ASC)
   

SELECT
    variety,
    AVG(price) AS median_price
FROM
    cte_calc
WHERE
    IF(total % 2 = 0, total/2, CEILING(total/2)) = median_helper
    OR
    IF(total % 2 = 0, total/2 + 1, CEILING(total/2)) = median_helper
GROUP BY
    variety