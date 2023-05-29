/* You’re given a table of rental property searches by users. The table consists of search results and outputs host information for searchers. Find the minimum, average, maximum rental prices for each host’s popularity rating. The host’s popularity rating is defined as below:
0 reviews: New
1 to 5 reviews: Rising
6 to 15 reviews: Trending Up
16 to 40 reviews: Popular
more than 40 reviews: Hot


Tip: The id column in the table refers to the search ID. You'll need to create your own host_id by concating price, room_type, host_since, zipcode, and number_of_reviews.


Output host popularity rating and their minimum, average and maximum rental prices. */

WITH base AS (
SELECT
    *,
    CONCAT(price, room_type, host_since, zipcode, number_of_reviews) AS id_
FROM
    airbnb_host_searches),
    
calc AS (
    
SELECT
    id_,            
        CASE WHEN number_of_reviews = 0 THEN 'New'
         WHEN number_of_reviews >= 1 AND number_of_reviews <=5 THEN 'Rising'
         WHEN number_of_reviews >= 6 AND number_of_reviews <=15 THEN 'Trending Up'
         WHEN number_of_reviews >= 16 AND number_of_reviews <=40 THEN 'Popular'
         ELSE
            'Hot' END AS host_pop_rating,
    price,
    number_of_reviews AS  n_reviews
FROM
    base
GROUP BY
    id_
ORDER BY
    n_reviews DESC)

SELECT
    host_pop_rating,
    MIN(price) AS min_price,
    AVG(price) AS avg_price,
    MAX(price) AS max_price
FROM
    calc
GROUP BY
    host_pop_rating