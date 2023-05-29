/* Estimate the growth of Airbnb each year using the number of hosts registered as the growth metric. The rate of growth is calculated by taking ((number of hosts registered in the current year - number of hosts registered in the previous year) / the number of hosts registered in the previous year) * 100.
Output the year, number of hosts in the current year, number of hosts in the previous year, and the rate of growth. Round the rate of growth to the nearest percent and order the result in the ascending order based on the year.
Assume that the dataset consists only of unique hosts, meaning there are no duplicate hosts listed. */

WITH base AS (
SELECT
    YEAR(host_since) AS year_,
    COUNT(id) AS current_year_host
FROM
    airbnb_search_details
GROUP BY
    year_
ORDER BY
    year_),

calc AS (
SELECT
    *,
    LAG(current_year_host, 1) OVER () AS prev_year_host
FROM
    base)
    
SELECT
    *,
    ROUND((current_year_host - prev_year_host) / prev_year_host * 100,0) AS estimated_growth
FROM
    calc