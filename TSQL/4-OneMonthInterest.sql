-- Problem 4.	Create a stored procedure that uses the function from the previous example.
-- Your task is to create a stored procedure that uses the function from the previous example
-- to give an interest to a person's account for one month. It should take the AccountId and 
-- the interest rate as parameters

USE Bank
GO

CREATE PROC usp_AccountInterest(@accountID INT, @yearlyRate FLOAT)
AS
	SELECT p.FirstName + ' ' + p.LastName AS Name, a.Balance, dbo.ufn_CalculateRate(a.Balance, @yearlyRate, 1)
	FROM Persons p JOIN Accounts a
		ON a.PersonID = p.PersonID
	WHERE a.Id = @accountID
GO

EXEC dbo.usp_AccountInterest 2, 3

