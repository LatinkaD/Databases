-- Problem 19.	Write a SQL query to find all employees and their address

SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], a.AddressText AS Address
FROM Employees e, Addresses a
WHERE e.AddressID = a.AddressID