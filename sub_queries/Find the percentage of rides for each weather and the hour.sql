/*
Find the percentage of rides each weather-hour combination constitutes among all weather-hour combinations.
Output the weather, hour along with the corresponding percentage.
*/

SELECT
    weather,
    hour,
    MAX(probability) AS probability
FROM(
    SELECT
        *,
        ROUND(COUNT(*) OVER (PARTITION BY weather, hour) / COUNT(*) OVER (),3) AS probability
    FROM 
        lyft_rides) sub_q
GROUP BY
    weather,
    hour
    


