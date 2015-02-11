-- Problem 23.	Write a SQL query to find all the employees and the manager for 
-- each of them along with the employees that do not have manager

SELECT e.FirstName + ' ' + e.LastName AS Employee,
	m.FirstName + ' ' + m.LastName AS Manager
FROM Employees e RIGHT OUTER JOIN Employees m
ON e.ManagerID = m.EmployeeID
