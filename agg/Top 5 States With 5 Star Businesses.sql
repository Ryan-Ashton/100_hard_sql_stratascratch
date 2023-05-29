/*Find the top 5 states with the most 5 star businesses. Output the state name along with the number of 5-star businesses and order records by the number of 5-star businesses in descending order. In case there are ties in the number of businesses, return all the unique states. If two states have the same result, sort them in alphabetical order. */

SELECT
    state,
    COUNT(state) AS n_businesses
FROM
    yelp_business
WHERE
    stars = 5
GROUP BY
    state
ORDER BY
    n_businesses DESC
LIMIT 6