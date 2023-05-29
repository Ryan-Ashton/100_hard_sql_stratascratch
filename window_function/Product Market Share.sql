/* Write a query to find the Market Share at the Product Brand level for each Territory, for Time Period Q4-2021. Market Share is the number of Products of a certain Product Brand brand sold in a territory, divided by the total number of Products sold in this Territory.
Output the ID of the Territory, name of the Product Brand and the corresponding Market Share in percentages. Only include these Product Brands that had at least one sale in a given territory. */

WITH base AS(
SELECT
    fct_customer_sales.*,
    map_customer_territory.territory_id,
    dim_product.prod_brand,
    dim_product.market_name,
    COUNT(order_id) OVER (PARTITION BY map_customer_territory.territory_id, dim_product.prod_brand) AS counting,
    COUNT(order_id) OVER (PARTITION BY map_customer_territory.territory_id) AS market_size
FROM
    fct_customer_sales
LEFT JOIN
    dim_product
ON
    fct_customer_sales.prod_sku_id = dim_product.prod_sku_id
LEFT JOIN
    map_customer_territory
ON
    fct_customer_sales.cust_id = map_customer_territory.cust_id
WHERE
    YEAR(order_date) = 2021
AND
    QUARTER(order_date) = 4)
    
SELECT
    territory_id,
    prod_brand,
    MAX(counting) / MAX(market_size) * 100 AS market_share
FROM
    base
GROUP BY
    territory_id,
    prod_brand
