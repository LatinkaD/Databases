-- Problem 8.	Write a SQL query to find the email addresses of each employee

SELECT FirstName + '.' +  LastName + '@softuni.bg' AS [Full Email Adresses]
FROM Employees