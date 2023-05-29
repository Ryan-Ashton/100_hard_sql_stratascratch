/*Given a table of purchases by date, calculate the month-over-month percentage change in revenue. The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.*/

SELECT
    DATE_FORMAT(created_at, '%Y-%m') AS new_date,
    ROUND((SUM(value) - LAG(SUM(value), 1) OVER ()) / (LAG(SUM(value)) OVER () ) * 100.0,2) AS revenue_diff_pct
FROM
    sf_transactions
    
GROUP BY
    new_date

ORDER BY
    new_date