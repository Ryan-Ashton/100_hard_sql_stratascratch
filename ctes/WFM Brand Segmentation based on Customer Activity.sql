/* WFM would like to segment the customers in each of their store brands into Low, Medium, and High segmentation. The segments are to be based on a customer's average basket size which is defined as (total sales / count of transactions), per customer.
The segment thresholds are as follows:
If average basket size is more than $30, then Segment is “High”.
If average basket size is between $20 and $30, then Segment is “Medium”.
If average basket size is less than $20, then Segment is “Low”.
Summarize the number of unique customers, the total number of transactions, total sales, and average basket size, grouped by store brand and segment for 2017.
Your output should include the brand, segment, number of customers, total transactions, total sales, and average basket size. */

WITH base AS (
SELECT
    t1.customer_id,
    t1.transaction_date,
    t1.transaction_id,
    t1.product_id,
    t1.sales,
    t2.store_id,
    t2.store_brand,
    t2.location
FROM
    wfm_transactions t1
LEFT JOIN 
    wfm_stores t2
ON
    t1.store_id = t2.store_id
WHERE
    YEAR(transaction_date) = 2017),
    
calc AS (
SELECT
    store_brand AS brand,
    customer_id,
    COUNT(DISTINCT transaction_id) n_transactions,
    SUM(sales) total_sales,
    CASE
        WHEN (SUM(sales)*1.0)/count(transaction_id) <20 THEN 'Low'
        WHEN (SUM(sales)*1.0)/count(transaction_id) BETWEEN 20 AND 30 THEN "Medium"
        ELSE "High"
        END as segment
FROM 
    base
GROUP BY
    store_brand,customer_id
    )
    
SELECT
    brand,
    segment,
    COUNT(customer_id) AS number_customers,
    SUM(n_transactions) AS total_transactions,
    SUM(total_sales) AS total_sales,
    SUM(total_sales)/SUM(n_transactions) AS avg_basket
FROM
    calc
GROUP BY
    brand,
    segment