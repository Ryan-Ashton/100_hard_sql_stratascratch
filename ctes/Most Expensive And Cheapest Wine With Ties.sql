/* Find the cheapest and the most expensive variety in each region. Output the region along with the corresponding most expensive and the cheapest variety. Be aware that there are 2 region columns, the price from that row applies to both of them.
Note: The results set contains ties, so your solution should account for this.
For example in the event of a tie for the cheapest wine your output should look similar to this: */

WITH base AS (
SELECT
    region_1,
    variety,
    price
FROM
    winemag_pd
WHERE
    region_1 is not null
AND
    price is not null
UNION

SELECT
    region_2,
    variety,
    price
FROM
    winemag_pd
WHERE
    region_2 is not null
AND
    price is not null),
    
    
calc AS (    
SELECT
    *,
    rank() OVER (PARTITION BY region_1 ORDER BY price ) ranking_asc,
    rank() OVER (PARTITION BY region_1 ORDER BY price desc) ranking_desc
FROM
    base),
    
calc2 AS (
SELECT
    region_1,
    CASE WHEN ranking_desc = 1 THEN variety ELSE NULL END AS most_expensive_variety,
    CASE WHEN ranking_asc = 1 THEN variety ELSE NULL END AS cheapest_variety
FROM
    calc),


expensive AS (
SELECT
    region_1,
    most_expensive_variety
FROM
    calc2
WHERE
    most_expensive_variety IS NOT NULL
GROUP BY
    region_1,
    most_expensive_variety),
    
cheap AS (
SELECT
    region_1,
    cheapest_variety
FROM
    calc2
WHERE
    cheapest_variety IS NOT NULL
GROUP BY
    region_1,
    cheapest_variety
)

SELECT 
    t1.region_1,
    most_expensive_variety,
    cheapest_variety
FROM
    expensive t1
JOIN
    cheap t2 
ON
    t1.region_1 = t2.region_1
GROUP BY
    t1.region_1,
    most_expensive_variety,
    cheapest_variety