/*Find the genre of the person with the most number of oscar winnings.
If there are more than one person with the same number of oscar wins, return the first one in alphabetic order based on their name. Use the names as keys when joining the tables. */

SELECT
    top_genre
FROM(
select
    top_genre,
    COUNT(top_genre)
from
    oscar_nominees t1
LEFT JOIN 
    nominee_information t2
ON 
    t1.nominee = t2.name
GROUP BY
    top_genre) sub_q

LIMIT 1