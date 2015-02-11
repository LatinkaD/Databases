-- Problem 16.	Write a SQL query to find all employees that have salary more than 50000. 
-- Order them in decreasing order by salary

SELECT FirstName + ' ' + LastName AS [Employee Name], Salary
FROM Employees
WHERE Salary > 50000