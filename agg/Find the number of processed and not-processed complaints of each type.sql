/* Find the number of processed and non-processed complaints of each type.
Replace NULL values with 0s.
Output the complaint type along with the number of processed and not-processed complaints. */

SELECT
    type,
    SUM(processed) AS n_complaints_processed,
    SUM(CASE WHEN processed = 0 THEN 1 ELSE 0 END) AS n_complaints_not_processed
FROM
    facebook_complaints
GROUP BY
    type