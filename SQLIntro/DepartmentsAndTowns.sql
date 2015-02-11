-- Problem 22.	Write a SQL query to find all departments and all town names as a single list

SELECT Name AS Department
FROM Departments
UNION
SELECT Name AS Town
FROM Towns

