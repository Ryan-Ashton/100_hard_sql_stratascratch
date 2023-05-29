/* Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid. The best selling item is calculated using the formula (unitprice * quantity). Output the description of the item along with the amount paid.*/

SELECT
    month,
    description,
    total_paid
    
FROM
    (SELECT
        MONTH(invoicedate) AS month,
        description,
        SUM(quantity * unitprice) AS total_paid,
        RANK() OVER (PARTITION BY MONTH(invoicedate) ORDER BY SUM(quantity * unitprice) DESC) AS ranked
    FROM    
        online_retail
    GROUP BY
        month,
        description
    ) sub_q
    
WHERE ranked = 1
ORDER BY
    month ASC, total_paid DESC