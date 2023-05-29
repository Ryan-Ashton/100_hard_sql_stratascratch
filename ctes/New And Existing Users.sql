/* Calculate the share of new and existing users for each month in the table. Output the month, share of new users, and share of existing users as a ratio.
New users are defined as users who started using services in the current month (there is no usage history in previous months). Existing users are users who used services in current month, but they also used services in any previous month.
Assume that the dates are all from the year 2020.
HINT: Users are contained in user_id column */

WITH base AS (
SELECT
    MONTH(time_id) AS month_,
    user_id, 
    COUNT(user_id) AS counting
FROM
    fact_events
GROUP BY
    month_,
    user_id
ORDER BY
    month_),

calc_total AS (
SELECT
    month_,
    COUNT(DISTINCT user_id) AS total
FROM
    base
GROUP BY
    month_),
    
new_calc AS (
    
SELECT
    user_id,
    MIN(month_) AS min_month
FROM
    base
GROUP BY
    user_id),

new AS (
SELECT
    min_month,
    COUNT(user_id) AS new
FROM
    new_calc
GROUP BY
    min_month),
    
final_calc AS (
SELECT
    min_month AS month,
    new,
    total
FROM
    new
LEFT JOIN
    calc_total
ON
    new.min_month = calc_total.month_)
    
SELECT
    month,
    new / total AS share_new_users,
    1 - (new / total) AS share_existing_users
FROM
    final_calc