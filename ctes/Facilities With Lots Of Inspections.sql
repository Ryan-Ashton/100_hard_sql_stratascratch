/* Find the facility that got the highest number of inspections in 2017 compared to other years. Compare the number of inspections per year and output only facilities that had the number of inspections greater in 2017 than in any other year.
Each row in the dataset represents an inspection. Base your solution on the facility name and activity date fields. */

WITH calc AS (

SELECT
    facility_name,
    SUM(CASE WHEN YEAR(activity_date) = 2015 THEN 1 ELSE 0 END) AS 2015_,
    SUM(CASE WHEN YEAR(activity_date) = 2016 THEN 1 ELSE 0 END) AS 2016_,
    SUM(CASE WHEN YEAR(activity_date) = 2017 THEN 1 ELSE 0 END) AS 2017_,
    SUM(CASE WHEN YEAR(activity_date) = 2018 THEN 1 ELSE 0 END) AS 2018_
FROM
    los_angeles_restaurant_health_inspections
GROUP BY
    facility_name),
    
flag AS (
SELECT
    *,
    IF(2017_ > 2015_ AND 2017_ > 2016_ AND 2017_ > 2018_, 1, 0) AS flag
FROM
    calc)
    
SELECT
    facility_name
FROM
    flag
WHERE
    flag = 1