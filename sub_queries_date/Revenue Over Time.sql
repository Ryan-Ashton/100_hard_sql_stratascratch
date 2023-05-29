/*Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased. Do not include returns which are represented by negative purchase values. Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.
A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. The first two months will not be a true 3-month rolling average since we are not given data from last year. Assume each month has at least one purchase.*/

SELECT
    month,
    AVG(sum_purchase_amt) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_revenue
FROM
    (SELECT DATE_FORMAT(created_at, '%Y-%m') AS month,
        SUM(purchase_amt) AS sum_purchase_amt 
    FROM amazon_purchases
    WHERE purchase_amt >=0
    GROUP by month) sub_q