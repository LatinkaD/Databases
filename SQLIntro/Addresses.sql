-- Problem 18.	Write a SQL query to find all employees along with their address

SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], a.AddressText AS Address
FROM Employees e INNER JOIN Addresses a
ON e.AddressID = a.AddressID