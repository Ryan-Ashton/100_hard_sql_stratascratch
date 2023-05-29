/*Calculate the running total (i.e., cumulative sum) energy consumption of the Meta/Facebook data centers in all 3 continents by the date. Output the date, running total energy consumption, and running total percentage rounded to the nearest whole number. */

WITH base_cte AS (
SELECT
    *
FROM
    fb_eu_energy
UNION ALL
    SELECT
        *
    FROM
        fb_na_energy
UNION ALL
    SELECT
        *
    FROM
        fb_asia_energy),
calc_cte AS(   
SELECT
    date,
    SUM(consumption) OVER (ORDER BY date) AS cumulative_total_energy,
    ROUND(SUM(consumption) OVER (ORDER BY date) / SUM(consumption) OVER () * 100,0) AS percentage_of_total_energy
FROM
    base_cte
ORDER BY
    date)
    
SELECT
    date,
    MAX(cumulative_total_energy) AS cumulative_total_energy,
    MAX(percentage_of_total_energy) AS percentage_of_total_energy
FROM
    calc_cte
GROUP BY
    date