/* Find the top 3 facilities for each owner. The top 3 facilities can be identified using the highest average score for each owner name and facility address grouping.
The output should include 4 columns: owner name, top 1 facility address, top 2 facility address, and top 3 facility address. Order facilities with the same score alphabetically. */

WITH base AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY owner_name ORDER BY AVG(score) DESC) AS ranking
FROM
    los_angeles_restaurant_health_inspections
GROUP BY
    owner_name,
    facility_address)
    
SELECT
    owner_name,
    MAX(CASE
        WHEN ranking = 1
        THEN facility_address
        ELSE NULL END) AS facility_1,
    MAX(CASE
        WHEN ranking = 2
        THEN facility_address
        ELSE NULL END) AS facility_2,
    MAX(CASE
        WHEN ranking = 3
        THEN facility_address
        ELSE NULL END) AS facility_3
        
FROM
    base
GROUP BY
    owner_name
ORDER BY
    owner_name