/*
Find the average session distance travelled by Google Fit users based on GPS location data. Calculate the distance for two scenarios:
Taking into consideration the curvature of the earth
Taking into consideration the curvature of the earth as a flat surface
Assume one session distance is the distance between the biggest and the smallest step. If the session has only one step id, discard it from the calculation. Assume that session can't span over multiple days.
Output the average session distances calculated in the two scenarios and the difference between them.
Formula to calculate the distance with the curvature of the earth:
*/

WITH sessions_cte AS 
(SELECT
    user_id, 
    day, 
    session_id,
    MAX(step_id) AS max_step,
    MIN(step_id) AS min_step
FROM
    google_fit_location
GROUP BY
    user_id,
    day,
    session_id
HAVING
    COUNT(DISTINCT step_id) > 1),
    
tmp_cte AS

(SELECT 
        s.user_id,
        max_.latitude AS max_lat,
        max_.longitude AS max_long,
        min_.latitude AS min_lat,
        min_.longitude AS min_long
        
    FROM 
        sessions_cte s
            LEFT JOIN 
                google_fit_location max_
            ON
                s.user_id = max_.user_id
            AND
                s.day = max_.day
            AND
                s.session_id = max_.session_id
            AND
                s.max_step = max_.step_id
            LEFT JOIN
                google_fit_location min_
            ON
                s.user_id = min_.user_id
            AND
                s.day = min_.day
            AND
                s.session_id = min_.session_id
            AND
                s.min_step = min_.step_id
)

SELECT 
    AVG(ACOS(SIN(min_lat*PI()/180) * SIN(max_lat*PI()/180) + COS(min_lat*PI()/180) * COS(max_lat*PI()/180) * COS(max_long*(PI()/180) - min_long*(PI()/180)))* 6371) AS avg_distance_curvature,
    
    AVG(SQRT(POWER(max_lat-min_lat, 2) + POWER(max_long-min_long, 2)) * 111) AS avg_distance_flat,
    
    AVG(ACOS(SIN(min_lat*PI()/180) * SIN(max_lat*PI()/180) + COS(min_lat*PI()/180) * COS(max_lat*PI()/180) * COS(max_long*(PI()/180) - min_long*(PI()/180)))* 6371) - AVG(SQRT(POWER(max_lat-min_lat, 2) + POWER(max_long-min_long, 2)) * 111) AS distance_difference
FROM
    tmp_cte
    