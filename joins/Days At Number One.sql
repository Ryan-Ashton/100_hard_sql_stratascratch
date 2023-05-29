/*Find the number of days a US track has stayed in the 1st position for both the US and worldwide rankings. Output the track name and the number of days in the 1st position. Order your output alphabetically by track name.
If the region 'US' appears in dataset, it should be included in the worldwide ranking.*/

select
    t1.trackname,
    COUNT(t1.trackname) AS n_days_on_n1_position
from
    spotify_daily_rankings_2017_us t1
INNER JOIN 
    spotify_worldwide_daily_song_ranking t2
ON
    t1.trackname = t2.trackname
AND
    t1.date = t2.date
WHERE
    t1.position = 1
GROUP BY
    t1.trackname