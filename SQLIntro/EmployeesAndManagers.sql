-- Problem 20.	Write a SQL query to find all employees along with their manager

SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], 
	m.FirstName + ' ' + m.LastName AS [Manager Name]
FROM Employees e JOIN Employees m
ON e.ManagerID = m.EmployeeID

