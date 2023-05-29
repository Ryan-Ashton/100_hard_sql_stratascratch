/*Find the number of employees who received the bonus and who didn't. Bonus values in employee table are corrupted so you should use  values from the bonus table. Be aware of the fact that employee can receive more than bonus.
Output value inside has_bonus column (1 if they had bonus, 0 if not) along with the corresponding number of employees for each. */

WITH grouped_cte AS (select
    t1.id,
    SUM(t2.bonus_amount) AS bonus
from
    employee t1
LEFT JOIN
    bonus t2
ON
    t1.id = t2.worker_ref_id
GROUP BY
    t1.id),
calc AS(
SELECT
    CASE WHEN bonus IS NULL THEN 0 ELSE 1 END AS has_bonus
FROM grouped_cte)

SELECT
    has_bonus,
    COUNT(has_bonus) AS n_employees
FROM
    calc
GROUP BY
    has_bonus