/*Meta/Facebook is quite keen on pushing their new programming language Hack to all their offices. They ran a survey to quantify the popularity of the language and send it to their employees. To promote Hack they have decided to pair developers which love Hack with the ones who hate it so the fans can convert the opposition. Their pair criteria is to match the biggest fan with biggest opposition, second biggest fan with second biggest opposition, and so on. Write a query which returns this pairing. Output employee ids of paired employees. Sort users with the same popularity value by id in ascending order.
Duplicates in pairings can be left in the solution. For example, (2, 3) and (3, 2) should both be in the solution. */

WITH base_cte AS 
(SELECT
    *,
    ROW_NUMBER() OVER (ORDER BY popularity ASC, employee_id ASC) AS asc_pop,
    ROW_NUMBER() OVER (ORDER BY popularity DESC, employee_id ASC) AS desc_pop
FROM
    facebook_hack_survey
)
   

SELECT
    t1.employee_id,
    t2.employee_id
FROM
    base_cte t1
LEFT JOIN
    base_cte t2
ON
    t1.asc_pop = t2.desc_pop