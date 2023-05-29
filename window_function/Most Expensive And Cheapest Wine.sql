/*
Find the cheapest and the most expensive variety in each region. Output the region along with the corresponding most expensive and the cheapest variety. Be aware that there are 2 region columns, the price from that row applies to both of them.
Note: The results set contains no ties.
*/

WITH cte_base AS (
    SELECT
        region_1 AS region, variety, price
    FROM
        winemag_p1
    WHERE
        region_1 IS NOT NULL AND price IS NOT NULL
    UNION ALL
    SELECT
        region_2 AS region, variety, price
    FROM
        winemag_p1
    WHERE
        region_2 IS NOT NULL AND price IS NOT NULL
),

cte_calc AS (SELECT
    region,
    first_value(variety) OVER(partition by region order by price DESC) most_expensive_variety,
    first_value(variety) OVER(partition by region order by price ASC) cheapest_variety
FROM
    cte_base
)
    
SELECT
    *
FROM
    cte_calc
GROUP BY
    region



    