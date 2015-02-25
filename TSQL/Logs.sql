-- Create another table – Logs (LogID, AccountID, OldSum, NewSum). Add a trigger to the 
-- Accounts table that enters a new entry into the Logs table every time the sum on an account changes

CREATE TABLE Logs(
	LogID INT IDENTITY PRIMARY KEY NOT NULL,
	AccountID INT FOREIGN KEY REFERENCES Accounts(ID) NOT NULL,
	OldSum MONEY NOT NULL,
	NewSum MONEY NOT NULL
)

GO

CREATE TRIGGER tr_AccountUpdate ON Accounts FOR UPDATE
AS
	INSERT INTO Logs(AccountID, OldSum, NewSum)
	SELECT d.Id, d.Balance, i.Balance
	FROM DELETED d JOIN INSERTED i
		ON d.Id = i.Id
GO