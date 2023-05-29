/* Consider all LinkedIn users who, at some point, worked at Microsoft. For how many of them was Google their next employer right after Microsoft (no employers in between)? */

SELECT
    COUNT(*) AS n_employees
FROM
    linkedin_users t1
INNER JOIN
    linkedin_users t2
ON
    t1.end_date = t2.start_date
AND
    t1.user_id = t2.user_id
WHERE
    t1.employer = 'Microsoft'