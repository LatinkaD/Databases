-- Problem 1.	Write a SQL query to find the names and salaries of the employees that
-- take the minimal salary in the company

SELECT FirstName + ' ' + LastName AS [Employee Name], Salary
FROM Employees
WHERE Salary = 
	(SELECT MIN(Salary) FROM Employees)

-- Problem 2.	Write a SQL query to find the names and salaries of the employees that
-- have a salary that is up to 10% higher than the minimal salary for the company

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary <
	(SELECT (MIN(Salary) * 0.1 + MIN(Salary))FROM Employees)

-- Problem 3.	Write a SQL query to find the full name, salary and department of
-- the employees that take the minimal salary in their department

SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], e.Salary, d.Name AS Department
FROM Employees E JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE Salary = 
	(SELECT MIN(Salary) FROM Employees
	 WHERE DepartmentID = e.DepartmentID)
ORDER BY d.DepartmentID

-- Problem 4.	Write a SQL query to find the average salary in the department #1

SELECT AVG(Salary) AS [Average Salary]
FROM Employees
WHERE DepartmentID = 1

-- Problem 5.	Write a SQL query to find the average salary in the "Sales" department

SELECT AVG(Salary) AS [Average Salary]
FROM Employees e JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE d.Name LIKE 'Sales'

-- Problem 6.	Write a SQL query to find the number of employees in the "Sales" department

SELECT COUNT(*) AS [Sales Employees Count]
FROM Employees e JOIN Departments d
	ON e.DepartmentID = e.DepartmentID
WHERE d.Name LIKE 'Sales'

-- Problem 7.	Write a SQL query to find the number of all employees that have manager

SELECT COUNT(ManagerID)
FROM Employees

-- Problem 8.	Write a SQL query to find the number of all employees that have no manager

SELECT COUNT(*)
FROM Employees
WHERE ManagerID IS NULL

-- Problem 9.	Write a SQL query to find all departments and the average salary for each of them

SELECT d.Name AS Department, AVG(Salary) AS [Average Salary]
FROM Employees e JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentID, d.Name

-- Problem 10.	Write a SQL query to find the count of all employees in each department and for each town

SELECT t.Name AS Town, d.Name AS Department, COUNT(*) AS Employees
FROM Employees e
	JOIN Departments d ON d.DepartmentID = e.DepartmentID
	JOIN Addresses a ON a.AddressID = e.AddressID
	JOIN Towns t ON a.TownID = t.TownID 
GROUP BY d.DepartmentID, d.Name, t.Name

-- Problem 11.	Write a SQL query to find all managers that have exactly 5 employees

SELECT m.FirstName + ' ' + m.LastName AS [Manager Name], 
	COUNT(e.ManagerID) AS [Employees Count]
FROM Employees e JOIN Employees m
	ON e.ManagerID = m.EmployeeID
GROUP BY m.ManagerID, m.FirstName, m.LastName
HAVING COUNT(E.ManagerID) = 5

-- Problem 12.	Write a SQL query to find all employees along with their managers

SELECT e.FirstName + ' ' + e.LastName AS [Employee Name],
	ISNULL(m.FirstName + ' ' + m.LastName, 'NO MANAGER') AS [Manager Name]
FROM Employees e LEFT OUTER JOIN Employees m
	ON e.ManagerID = m.EmployeeID

-- Problem 13.	Write a SQL query to find the names of all employees whose last name is
-- exactly 5 characters long

SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5

-- Problem 14.	Write a SQL query to display the current date and time in the following 
-- format "day.month.year hour:minutes:seconds:milliseconds"

SELECT CONVERT(varchar, GETDATE(), 4) + ' ' +
	CONVERT(varchar, GETDATE(), 14) as DateTime

-- Problem 15.	Write a SQL statement to create a table Users

CREATE TABLE Users (
	UserId int IDENTITY,
	Username nvarchar(50) NOT NULL,
	[Password] nvarchar(50) NOT NULL,
	FullName nvarchar(50) NOT NULL,
	LastLogin datetime,
	CONSTRAINT PK_Users PRIMARY KEY(UserId),
	CONSTRAINT UNQ_Users UNIQUE(Username),
	CONSTRAINT CHK_Users CHECK (LEN(Password) > 5)
)

GO

-- Problem 16.	Write a SQL statement to create a view that displays
-- the users from the Users table that have been in the system today.

CREATE VIEW [Show users] AS 
SELECT * FROM Users
WHERE DAY(LastLogin) = DAY(GETDATE())

GO

-- Problem 17.	Write a SQL statement to create a table Groups

CREATE TABLE Groups (
	GroupID int IDENTITY,
	Name nvarchar(50) NOT NULL,
	CONSTRAINT PK_Groups PRIMARY KEY(GroupID),
	CONSTRAINT UNQ_Groups UNIQUE(Name)
)

GO

-- Problem 18.	Write a SQL statement to add a column GroupID to the table Users

ALTER TABLE Users
ADD GroupID INT FOREIGN KEY REFERENCES Groups(GroupID) 

 -- Problem 19.	Write SQL statements to insert several records in the Users and Groups tables

INSERT INTO Users
VALUES ('LatinkaD', '12345', 'Latinka', GETDATE(), 2);

INSERT INTO Users
VALUES ('MalinaD', '123456', 'Malina', GETDATE(), 3);

INSERT INTO Users
VALUES ('GeorgeK',  '1234567', 'Georgi', GETDATE(), 4);

INSERT INTO Groups
VALUES ('First');

INSERT INTO Groups
VALUES ('Second');

INSERT INTO Groups
VALUES ('Third');

INSERT INTO Groups
VALUES ('Fourth');

-- Problem 20.	Write SQL statements to update some of the records in the Users and Groups tables

UPDATE Users
SET FullName = 'Latinka Demirova'
WHERE FullName = 'Latinka'

UPDATE Groups 
SET Name = 'Firstable'
WHERE Name = 'First'

-- Problem 21.	Write SQL statements to delete some of the records from the Users and Groups tables

DELETE FROM Groups 
WHERE Name = 'Fourth'

-- Problem 22.	Write SQL statements to insert in the Users table the names of all employees from the Employees table

INSERT INTO Users
SELECT FirstName + ' ' + LastName AS [Full Name],
	LOWER(LEFT(FirstName, 1) + LastName) AS Username,
	LOWER(LEFT(FirstName, 1) + LastName) AS [Password],
	NULL AS LastLogin,
	2 AS GroupID
FROM Employees

-- Problem 23.	Write a SQL statement that changes the password to NULL for all users that have 
-- not been in the system since 10.03.2010

UPDATE Users
SET [Password] = NULL
WHERE LastLogin <= CAST('2010-10-03' AS DATETIME)

-- Problem 24.	Write a SQL statement that deletes all users without passwords (NULL password)

DELETE 
FROM Users
WHERE [Password] IS NULL

-- Problem 25.	Write a SQL query to display the average employee salary by department and job title

SELECT d.Name AS Department, e.JobTitle, AVG(Salary) AS [Average Salary]
FROM Employees e JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, e.JobTitle
ORDER BY JobTitle

-- Problem 26.	Write a SQL query to display the minimal employee salary by department and job title
-- along with the name of some of the employees that take it

SELECT d.Name AS Department, e.JobTitle, e.FirstName, MIN(Salary) AS [Min Salary]
FROM Employees e JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, e.JobTitle, e.FirstName
ORDER BY Department

-- Problem 27.	Write a SQL query to display the town where maximal number of employees work

SELECT TOP(1) t.Name AS Name, COUNT(e.EmployeeID) AS [Number Of Employees]
FROM Employees e 
JOIN Addresses a
	ON e.AddressID = a.AddressID
JOIN Towns t
	ON a.TownID = t.TownID
GROUP BY t.Name
ORDER BY [Number Of Employees] DESC

-- Problem 28.	Write a SQL query to display the number of managers from each town

SELECT t.Name AS Name, COUNT(m.ManagerID) AS [Number Of Managers]
FROM Employees m
JOIN Addresses a
	ON m.AddressID = a.AddressID
JOIN Towns t
	ON a.TownID = t.TownID
GROUP BY t.Name

-- Problem 29.	Write a SQL to create table WorkHours to store work reports for each employee
-- Each employee should have id, date, task, hours and comments. Don't forget to define identity,
-- primary key and appropriate foreign key.

CREATE TABLE WorkHours(
	Id int IDENTITY,
	[Date] datetime,
	Task nvarchar(100) NOT NULL,
	EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
	[Hours] int NOT NULL,
	Comments text,
	CONSTRAINT PK_WorkHours PRIMARY KEY(Id)
)

GO

-- Problem 30.	Issue few SQL statements to insert, update and delete of some data in the table

INSERT INTO WorkHours
VALUES (GETDATE(), 'MY TASK', 2, 5, 'COMMENT')

INSERT INTO WorkHours
VALUES (GETDATE(), 'MY SECOND TASK', 2, 5, 'AGAIN COMMENT')

UPDATE WorkHours
SET EmployeeID = 3
WHERE Task = 'MY TASK'

DELETE FROM WorkHours 
WHERE Comments IS NULL

-- Problem 31.	Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers
-- For each change keep the old record data, the new record data and the command (insert / update / delete)

CREATE TABLE WorkHoursLogs(
	WorkHoursLogId INT IDENTITY PRIMARY KEY,
	Command	nvarchar(6) NOT NULL,
	OldDate datetime null,
	OldTask nvarchar(100) null,
	OldEmployeeId int null,
	OldHours int null,
	OldComments text null,
	NewDate datetime null,
	NewTask nvarchar(100),
	NewEmployeeId int null,
	NewHours int null,
	NewComments text null
)

GO

CREATE TRIGGER TR_WorkHoursInsert ON WorkHours 
FOR INSERT
AS 
	INSERT INTO WorkHoursLogs
	SELECT 'INSERT', NULL, NULL, NULL, NULL, NULL, NULL, *
	FROM INSERTED
GO

CREATE TRIGGER TR_WorkHoursUpdate ON WorkHours 
FOR UPDATE
AS 
	SET NOCOUNT ON;
	INSERT INTO WorkHoursLogs
	SELECT 'UPDATE', d.Id, d.[Date], d.EmployeeID, d.Comments, d.Task, d.[Hours],
		i.Id, i.[Date], i.EmployeeID, i.Comments, i.Task, i.[Hours]
	FROM INSERTED i, DELETED d
GO

CREATE TRIGGER TR_WorkHoursDelete ON WorkHours 
FOR DELETE
AS 
	INSERT INTO WorkHoursLogs
	SELECT 'DELETE', *, NULL, NULL, NULL, NULL, NULL, NULL
	FROM DELETED
GO

-- Problem 32.	Start a database transaction, delete all employees from the 'Sales' 
-- department along with all dependent records from the pother tables. At the end rollback the transaction

BEGIN TRAN;

DELETE Employees 
FROM Employees e JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales';

ROLLBACK TRAN;

-- Problem 33.	Start a database transaction and drop the table EmployeesProjects

BEGIN TRAN;

DROP TABLE EmployeesProjects;

ROLLBACK TRAN;




	
