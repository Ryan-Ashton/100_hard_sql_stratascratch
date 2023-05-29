/* You're given a dataset of searches for properties on Airbnb. For simplicity, let's say that each search result (i.e., each row) represents a unique host. Find the city with the most amenities across all their host's properties. Output the name of the city. */

WITH counting AS (
SELECT
    city,
    amenities,
    SUM((LENGTH(amenities) - LENGTH(REPLACE(amenities, ",", "")) + 1)) as amenity_count
FROM
    airbnb_search_details
GROUP BY
    city,
    amenities
),

agg AS(
SELECT
    city,
    SUM(amenity_count) AS total,
    RANK() OVER (ORDER BY amenity_count) AS ranking
FROM
    counting
GROUP BY
    city)
    
SELECT
    city
FROM
    agg
WHERE
    ranking = 1