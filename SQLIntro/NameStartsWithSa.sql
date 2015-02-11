-- Problem 11.	Write a SQL query to find the names of all employees whose first name starts with "SA"

SELECT FirstName + ' ' + LastName AS [Employee Name]
FROM Employees
WHERE FirstName LIKE 'sa%'