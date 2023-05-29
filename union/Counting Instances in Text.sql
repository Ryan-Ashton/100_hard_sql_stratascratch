/* Find the number of times the words 'bull' and 'bear' occur in the contents. We're counting the number of times the words occur so words like 'bullish' should not be included in our count.
Output the word 'bull' and 'bear' along with the corresponding number of occurrences. */

SELECT
    'bull' AS word,
    COUNT(contents) nentry
FROM
    google_file_store
WHERE
    contents LIKE '%bull%'
    
UNION

SELECT
    'bear' AS word,
    COUNT(contents) nentry
FROM
    google_file_store
WHERE
    contents LIKE '%bear%'