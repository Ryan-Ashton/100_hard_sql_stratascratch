/*Find the number of words in each business name. Avoid counting special symbols as words (e.g. &). Output the business name and its count of words. */

WITH cte AS
(select
    business_name,
    REGEXP_REPLACE(REGEXP_REPLACE(business_name, '[^a-zA-Z0-9 ]', ''), ' +', ' ') AS cleaned_business_name
from
    sf_restaurant_health_violations)
    
SELECT
    DISTINCT business_name AS business_name,
    LENGTH(cleaned_business_name) - LENGTH(REPLACE(cleaned_business_name, ' ', '')) + 1 AS word_count
FROM
    cte

 
    
