-- Problem 7. Define a function in the database SoftUni that returns all Employee's names 
-- (first or middle or last name) and all town's names that are comprised of given set of letters

USE SoftUni
GO

CREATE FUNCTION ufn_CheckWords(@name NVARCHAR(50), @str NVARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @nameLen INT = LEN(@name)
	DECLARE @index INT = 1
	DECLARE @currentChar char(1)
		WHILE (@index < @nameLen)
		BEGIN
			SET @currentChar = SUBSTRING(@name, @index, 1)
			IF (CHARINDEX(@currentChar, @str) > 0)
			BEGIN
				SET @index = @index + 1
			END
			ELSE
			BEGIN
				RETURN 0
			END
		END
		RETURN 1
END
GO

USE SoftUni
GO

CREATE FUNCTION ufn_EmployeesNames(@string NVARCHAR(50))
RETURNS @tbl_EmployeesNames TABLE(
	ID INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50)
)

AS
BEGIN
	INSERT INTO @tbl_EmployeesNames
	SELECT FirstName
	FROM Employees
	WHERE dbo.ufn_CheckWords(FirstName, @string) = 1

	INSERT INTO @tbl_EmployeesNames
	SELECT LastName
	FROM Employees
	WHERE dbo.ufn_CheckWords(LastName, @string) = 1

	INSERT INTO @tbl_EmployeesNames
	SELECT Name
	FROM Towns
	WHERE dbo.ufn_CheckWords(Name, @string) = 1

	RETURN
END
GO

SELECT * FROM ufn_EmployeesNames('oistmiahf')
GO


