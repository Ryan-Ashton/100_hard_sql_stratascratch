/* Find the most profitable location. Write a query that calculates the average signup duration and average transaction amount for each location, and then compare these two measures together by taking the ratio of the average transaction amount and average duration for each location.
Your output should include the location, average duration, average transaction amount, and ratio. Sort your results from highest ratio to lowest. */

WITH duration AS (
SELECT
    location,
    AVG(DATEDIFF(signup_stop_date, signup_start_date)) AS mean_duration 
FROM
    signups t1
GROUP BY
    location),
    
revenue AS (
SELECT
    location,
    AVG(amt) AS mean_revenue
FROM
    signups t1
LEFT JOIN
    transactions t2
ON
    t1.signup_id = t2.signup_id
GROUP BY
    location
)

SELECT
    t1.location,
    t1.mean_duration,
    t2.mean_revenue,
    t2.mean_revenue / t1.mean_duration AS ratio
FROM
    duration t1
LEFT JOIN
    revenue t2
ON
    t1.location = t2.location