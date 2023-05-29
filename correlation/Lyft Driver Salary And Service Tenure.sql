-- Find the correlation between the annual salary and the length of the service period of a Lyft driver.

-- Corr Equation Step by Step:
-- r=n∑XY −
-- ∑X∑Y /
-- √(n∑X2 −
-- (∑X)2)*⋅
-- (n∑Y2−
-- (∑Y)2)

SELECT
    ((COUNT(*)*SUM(tenure * yearly_salary)) -
    (SUM(tenure) * SUM(yearly_salary))) /
    SQRT((COUNT(*) * SUM(POWER(tenure,2)) -
    POWER(SUM(tenure),2)) *
    (COUNT(*) * SUM(POWER(yearly_salary,2)) -
    POWER(SUM(yearly_salary),2))) AS corr
FROM
    (
    SELECT
        yearly_salary,
        DATEDIFF(COALESCE(end_date, now()), start_date) AS tenure
    FROM
        lyft_drivers) sub_q