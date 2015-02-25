-- Problem 8.	Using database cursor write a T-SQL script that scans all employees and their
-- addresses and prints all pairs of employees that live in the same town

USE SoftUni
GO

DECLARE empCursor CURSOR READ_ONLY FOR SELECT
	e.FirstName + ' ' + e.LastName AS [Full Name],
	t.Name AS Town
FROM Employees e INNER JOIN Addresses a
	ON a.AddressID = e.AddressID
INNER JOIN Towns t
	ON t.TownID = a.TownID

OPEN empCursor
DECLARE @fullName NVARCHAR(50),
	@town NVARCHAR(50),
	@currentTown NVARCHAR(50),
	@currentFullName NVARCHAR(50)
FETCH NEXT FROM empCursor INTO @fullName, @town

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @currentTown = @town
	SET @currentFullName = @fullName
	FETCH NEXT FROM empCursor INTO @fullName, @town

	IF @currentTown = @town
	BEGIN
		PRINT @town + ': ' + @fullName
	END
END

CLOSE empCursor
DEALLOCATE empCursor
