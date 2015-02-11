-- Problem 15.	Write a SQL query to find all employees that do not have manager

SELECT FirstName + ' ' + LastName AS [Employee Name]
FROM Employees
WHERE ManagerID IS NULL