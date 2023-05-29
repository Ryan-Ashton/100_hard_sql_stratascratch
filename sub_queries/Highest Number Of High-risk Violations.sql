/* Find details of the business with the highest number of high-risk violations. Output all columns from the dataset considering business_id which consist 'high risk' phrase in risk_category column. */

SELECT
    business_id,
    business_name,
    business_address,
    business_city,
    business_state,
    business_postal_code,
    business_latitude,
    business_longitude,
    business_location,
    business_phone_number,
    inspection_id,
    date(inspection_date),
    inspection_score,
    inspection_type,
    violation_id,
    violation_description,
    risk_category
FROM
    sf_restaurant_health_violations
WHERE business_id =

(SELECT
    business_id
FROM
    (

SELECT
    business_id,
    COUNT(business_id) AS counting
FROM
    sf_restaurant_health_violations
WHERE
    risk_category = 'High Risk'
GROUP BY
    business_id
ORDER BY
    counting DESC
LIMIT 1) sub_q)