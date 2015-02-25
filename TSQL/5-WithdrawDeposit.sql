-- Problem 5.	Add two more stored procedures WithdrawMoney and DepositMoney.
-- Add two more stored procedures WithdrawMoney (AccountId, money) and DepositMoney
-- (AccountId, money) that operate in transactions

USE Bank
GO

CREATE PROC usp_WithdrawMoney(@accountID INT, @balance MONEY)
AS
	UPDATE Accounts
	SET Balance = Balance - @balance
	WHERE Accounts.Id = @accountID
GO

EXEC usp_WithdrawMoney 3, 200

GO

CREATE PROC usp_DepositMoney(@accountID INT, @balance MONEY)
AS
	UPDATE Accounts
	SET Balance = Balance + @balance
	WHERE Accounts.Id = @accountID
GO

EXEC usp_DepositMoney 2, 150

GO