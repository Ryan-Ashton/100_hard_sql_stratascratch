/*Find the quarterback who threw the longest throw in 2016. Output the quarterback name along with their corresponding longest throw.
The 'lg' column contains the longest completion by the quarterback. */

select
    qb,
    LEFT(lg,2) AS lg_num
from
    qbstats_2015_2016
ORDER BY
    lg DESC
LIMIT 1