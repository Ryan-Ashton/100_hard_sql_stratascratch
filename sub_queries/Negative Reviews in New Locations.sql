/* Find stores that were opened in the second half of 2021 with more than 20% of their reviews being negative. A review is considered negative when the score given by a customer is below 5. Output the names of the stores together with the ratio of negative reviews to positive ones. */

SELECT
    name,
    SUM(neg) / (MAX(total) - SUM(neg)) AS negative_ratio
FROM(

SELECT
    store_id,
    name,
    score,
    opening_date,
    CASE WHEN score < 5 THEN 1 ELSE 0 END AS neg,
    COUNT(store_id) OVER (PARTITION BY store_id) AS total
FROM
    instacart_reviews t1
LEFT JOIN
    instacart_stores t2
ON
    t1.store_id = t2.id
WHERE
    opening_date BETWEEN '2021-07-01' AND '2021-12-31') sub_q
    
GROUP BY
    name
HAVING
    SUM(neg) / MAX(total) > .2