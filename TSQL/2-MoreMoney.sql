-- Problem 2.	Create a stored procedure
-- Your task is to create a stored procedure that accepts a number as a parameter and returns 
-- all persons who have more money in their accounts than the supplied number

USE Bank
GO

CREATE PROC usp_SelectPersonsWithMoreMoney(@balance MONEY)
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Full Name], a.Balance
	FROM Persons p JOIN Accounts a
		ON p.PersonID = a.PersonID
	WHERE a.Balance > @balance
GO

EXEC usp_SelectPersonsWithMoreMoney @balance = 1200