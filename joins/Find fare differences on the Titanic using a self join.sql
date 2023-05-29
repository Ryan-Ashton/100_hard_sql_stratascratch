/* Find the average absolute fare difference between a specific passenger and all passengers that belong to the same pclass,  both are non-survivors and age difference between two of them is 5 or less years. Do that for each passenger (that satisfy above mentioned coniditions). Output the result along with the passenger name. */

SELECT
    t1.name AS name1,
    ROUND(AVG(ABS(t1.fare - t2.fare)),4) AS avg_fare
FROM
    titanic t1
INNER JOIN
    titanic t2
ON
    t1.pclass = t2.pclass
WHERE
    ABS(t1.age-t2.age) <= 5
AND
    t1.survived = 0
AND
    t2.survived = 0
AND
    t1.passengerid != t2.passengerid
GROUP BY
    name1
ORDER BY
    avg_fare