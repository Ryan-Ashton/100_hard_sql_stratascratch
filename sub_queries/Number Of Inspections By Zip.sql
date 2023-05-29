/* Find the number of inspections that happened in the municipality with postal code 94102 during January, May or November in each year.
Output the count of each month separately. */

SELECT
    year_,
    SUM(CASE WHEN month = 1 THEN 1 ELSE 0 END) AS january_counts,
    SUM(CASE WHEN month = 5 THEN 1 ELSE 0 END) AS may_counts,
    SUM(CASE WHEN month = 11 THEN 1 ELSE 0 END) AS november_counts

FROM (
select
    *,
    year(inspection_date) AS year_,
    month(inspection_date) AS month
from
    sf_restaurant_health_violations
WHERE
    business_postal_code=94102) sub_q
    
GROUP BY
    year_
ORDER BY
    year_