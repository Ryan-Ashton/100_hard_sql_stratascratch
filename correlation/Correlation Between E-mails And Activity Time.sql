/*There are two tables with user activities. The google_gmail_emails table contains information about emails being sent to users. Each row in that table represents a message with a unique identifier in the id field. The google_fit_location table contains user activity logs from the Google Fit app.
Find the correlation between the number of emails received and the total exercise per day. The total exercise per day is calculated by counting the number of user sessions per day. */

WITH emails AS (SELECT
    to_user,
    COUNT(t1.to_user) AS emails_received
FROM
    google_gmail_emails t1
    
GROUP BY
    to_user),
    
activity AS (

    SELECT 
        user_id,
        COUNT(user_id) AS exercise_sessions
    FROM
        google_fit_location
    GROUP BY
        user_id

)

SELECT 
    google_gmail_emails.to_user,
    emails_received,
    exercise_sessions,
    CORR(emails_received, exercise_sessions)
FROM
    google_gmail_emails
LEFT JOIN
    emails
ON
    google_gmail_emails.to_user = emails.to_user
LEFT JOIN
    activity
ON
    google_gmail_emails.to_user = activity.user_id

