-- 1.	Create a view "AllAds" in the database that holds information about ads: id,
-- title, author (username), date, town name, category name and status, sorted by id

CREATE VIEW AllAds
AS
SELECT a.Id, a.Title, u.UserName AS Author, a.[Date], t.Name AS Town, c.Name AS Category, s.[Status]
FROM Ads a
	LEFT JOIN AspNetUsers u ON a.OwnerId = u.Id
	LEFT JOIN Towns t ON a.TownId = t.Id
	LEFT JOIN Categories c ON a.CategoryId = c.Id
	LEFT JOIN AdStatuses s ON a.StatusId = s.Id

GO

-- 2.	Using the view above, create a stored function "fn_ListUsersAds" that returns
-- a table, holding all users in descending order as first column, along with all dates
-- of their ads (in ascending order) in format "yyyyMMdd", separated by "; " as second column

CREATE FUNCTION fn_ListUsersAds()
RETURNS @tbl_ListUserAds TABLE(
	UserName NVARCHAR(100) NOT NULL,
	AdDates NVARCHAR(100) NOT NULL
)
AS
BEGIN
	DECLARE UsersCursor CURSOR FOR
	SELECT UserName
	FROM AspNetUsers
	ORDER BY UserName DESC;
	OPEN UsersCursor;
	DECLARE @userName NVARCHAR(50);
	FETCH NEXT FROM UsersCursor INTO @userName;

	WHILE @@fetch_status = 0
	BEGIN
		DECLARE @data NVARCHAR(100) = NULL;
		SELECT @data = 
			CASE WHEN @data IS NULL THEN CONVERT(NVARCHAR(100), [Date], 112)
			ELSE @data + '; ' + CONVERT(NVARCHAR(100), [Date], 112)
			END
		FROM AllAds
		WHERE Author = @userName
		ORDER BY [Date]

		INSERT INTO @tbl_ListUserAds
		VALUES(@username, @data)

		FETCH NEXT FROM UsersCursor INTO @username;
	END;
	CLOSE UsersCursor;
	DEALLOCATE UsersCursor;
	RETURN;
END
GO

SELECT * FROM fn_ListUsersAds()


