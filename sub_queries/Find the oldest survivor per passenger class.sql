/* Find the oldest survivor of each passenger class.
Output the name and the age of the survivor along with the corresponding passenger class.
Order records by passenger class in ascending order. */

SELECT
    pclass,
    name,
    age
FROM(

SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY pclass ORDER BY age DESC) AS ranking
FROM 
    titanic
WHERE
    survived = 1) sub_q
    
WHERE 
    ranking = 1