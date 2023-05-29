/* Find products which are exclusive to only Amazon and therefore not sold at Top Shop and Macy's. Your output should include the product name, brand name, price, and rating.
Two products are considered equal if they have the same product name and same maximum retail price (mrp column). */

SELECT
    product_name,
    brand_name,
    price,
    rating
FROM
    innerwear_amazon_com
WHERE product_name NOT IN (

SELECT
    product_name
FROM
    innerwear_macys_com
UNION
SELECT
    product_name
FROM
    innerwear_topshop_com)