-- Problem 3.	Create a function with parameters
-- Your task is to create a function that accepts as parameters – sum, yearly interest rate 
-- and number of months. It should calculate and return the new sum. Write a SELECT to test
-- whether the function works as expected

USE Bank
GO

CREATE FUNCTION ufn_CalculateRate(@sum MONEY, @yearlyRate FLOAT, @months INT)
RETURNS MONEY
AS
BEGIN
	RETURN (@sum * (@yearlyRate / 100) * (@months / 12))
END	

GO

SELECT dbo.ufn_CalculateRate(1000, 10, 10) AS [Money]

