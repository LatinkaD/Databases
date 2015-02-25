-- Problem 1.	Create a database with two tables:
-- Persons (id (PK), first name, last name, SSN) and Accounts (id (PK), person id (FK), balance). 

USE Bank
GO

CREATE TABLE Persons(
	PersonID INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	SSN NVARCHAR(50) NOT NULL
)

GO

CREATE TABLE Accounts(
	Id INT IDENTITY PRIMARY KEY,
	PersonID INT FOREIGN KEY REFERENCES Persons(PersonID) NOT NULL,
	Balance MONEY NOT NULL
)

GO

-- Insert few records for testing

INSERT INTO Persons
VALUES ('Latinka', 'Demirova', '9305053333')

INSERT INTO Persons
VALUES ('Malina', 'Demirova', '8911143333')

INSERT INTO Persons
VALUES ('Georgi', 'Krystev', '9205043333')

INSERT INTO Accounts
VALUES (1, 1000)

INSERT INTO Accounts
VALUES (2, 2000)

INSERT INTO Accounts
VALUES (3, 3000)

-- Write a stored procedure that selects the full names of all persons

USE Bank
GO

CREATE PROC usp_SelectPersonFullName
AS 
	SELECT FirstName + ' ' + LastName AS [Full Name]
	FROM Persons
GO

EXEC usp_SelectPersonFullName
