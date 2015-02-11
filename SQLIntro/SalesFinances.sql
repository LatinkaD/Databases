-- Problem 24.	Write a SQL query to find the names of all employees from the departments
-- "Sales" and "Finance" whose hire year is between 1995 and 2005.

SELECT e.FirstName + ' ' + e.LastName AS [Full Name],
	e.HireDate, d.Name AS Department
FROM Employees e, Departments d
WHERE (e.HireDate BETWEEN 2001 AND 2005) AND
	(e.DepartmentID = d.DepartmentID) AND
	(d.Name = 'Sales' OR d.Name = 'Finance')
	
