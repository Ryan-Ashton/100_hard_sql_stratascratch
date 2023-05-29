/* Find the average time (in seconds), per product, that needed to progress between steps. You can ignore products that were never used. Output the feature id and the average time. */

SELECT
    feature_id,
    AVG(time_dur) AS avg_
FROM(
SELECT 
    feature_id, user_id, avg(TIMESTAMPDIFF(SECOND, lag_time, timestamp)) as time_dur
FROM
    (SELECT
        *,
        lag(timestamp,1) over(partition by feature_id,user_id order by step_reached) as lag_time 
    FROM facebook_product_features_realizations) sub_q
GROUP BY 
    feature_id,
    user_id) sub
GROUP BY
    feature_id
HAVING 
    avg_ > 0
