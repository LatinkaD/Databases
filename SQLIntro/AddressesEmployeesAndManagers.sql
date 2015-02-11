-- Problem 21.	Write a SQL query to find all employees, along with their manager and their address

SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], 
	m.FirstName + ' ' + m.LastName AS [Manager Name], 
	a.AddressText AS Address
FROM Employees e, Employees m, Addresses a
WHERE e.ManagerID = m.EmployeeID
	AND e.AddressID = a.AddressID

