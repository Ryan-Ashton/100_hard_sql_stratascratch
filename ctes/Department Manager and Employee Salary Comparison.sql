/* Oracle is comparing the monthly wages of their employees in each department to those of their managers and co-workers.
You have been tasked with creating a table that compares an employee's salary to that of their manager and to the average salary of their department.
It is expected that the department manager's salary and the average salary of employee's from that department are in their own separate column.
Order the employee's salary from highest to lowest based on their department.
Your output should contain the department, employee id, salary of that employee, salary of that employee's manager and the average salary from employee's within that department rounded to the nearest whole number.
Note: Oracle have requested that you not include the department manager's salary in the average salary for that department in order to avoid skewing the results. Managers of each department do not report to anyone higher up; they are their own manager. */

WITH emp AS (
SELECT
    department,
    id AS employee_id,
    salary AS employee_salary,
    ROUND(AVG(salary) OVER (PARTITION BY department),0) AS avg_employee_salary
FROM
    employee_o
WHERE 
    employee_title != 'Manager'),
    
manager AS (
SELECT
    department,
    salary AS manager_salary
FROM
    employee_o
WHERE 
    employee_title = 'Manager')
    

SELECT
    emp.department,
    emp.employee_id,
    emp.employee_salary,
    manager.manager_salary,
    emp.avg_employee_salary
FROM
    emp
LEFT JOIN
    manager
ON
    emp.department = manager.department
