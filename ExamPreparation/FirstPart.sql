-- Problem 1.	All Ad Titles
-- Display all ad titles in ascending order. Submit for evaluation the result grid with headers

SELECT Title
FROM Ads 
ORDER BY Title ASC

-- Problem 2.	Ads in Date Range
-- Find all ads created between 26-December-2014 (00:00:00) and 1-January-2015 (23:59:59) 
-- sorted by date. Submit for evaluation the result grid with headers

SELECT Title, [Date]
FROM Ads
WHERE [DATE] BETWEEN ('26-December-2014') AND ('2-January-2015')
ORDER BY [Date]

-- Problem 3. * Ads with "Yes/No" Images
-- Display all ad titles and dates along with a column named "Has Image" holding "yes" 
-- or "no" for all ads sorted by their Id. Submit for evaluation the result grid with headers

SELECT Title, [Date],
	CASE
	WHEN ImageDataURL IS NULL THEN 'yes'
	ELSE 'no'
	END AS [Has Image]
FROM Ads

-- Problem 4.	Ads without Town, Category or Image
-- Find all ads that have no town, no category or no image sorted by Id. Show all their data. 
-- Submit for evaluation the result grid with headers

SELECT *
FROM Ads
WHERE TownId IS NULL OR CategoryId IS NULL OR ImageDataURL IS NULL
ORDER BY Id -- TODO

-- Problem 5.	Ads with Their Town
-- Find all ads along with their towns sorted by Id. Display the ad title and town (even when there is no town).
-- Name the columns exactly like in the table below

SELECT a.Title, t.Name AS [Town]
FROM Ads a LEFT JOIN Towns t
	ON a.TownId = t.Id
ORDER BY a.Id

-- Problem 6.	Ads with Their Category, Town and Status
-- Find all ads along with their categories, towns and statuses sorted by Id.
-- Display the ad title, category name, town name and status. Include all ads without
-- town or category or status

SELECT a.Title, c.Name AS CategoryName, t.Name AS TownName, s.[Status] AS Status
FROM Ads a
	LEFT JOIN Categories c 
		ON a.CategoryId = c.Id
	LEFT JOIN Towns t
		ON a.TownId = t.Id
	LEFT JOIN AdStatuses s
		ON a.StatusId = s.Id
ORDER BY a.Id ASC

-- Problem 7.	Filtered Ads with Category, Town and Status
-- Find all Published ads from Sofia, Blagoevgrad or Stara Zagora, along with their
-- category, town and status sorted by title. Display the ad title, category name,
-- town name and status

SELECT a.Title, c.Name AS CategoryName, t.Name AS TownName, s.[Status] AS Status
FROM Ads a
	LEFT JOIN Categories c 
		ON a.CategoryId = c.Id
	LEFT JOIN Towns t
		ON a.TownId = t.Id
	LEFT JOIN AdStatuses s
		ON a.StatusId = s.Id
WHERE s.[Status] = 'Published'
	AND (t.Name = 'Sofia'
	OR t.Name = 'Blagoevgrad'
	OR t.Name = 'Stara Zagora')
ORDER BY a.Title

-- Problem 8.	Earliest and Latest Ads
-- Find the dates of the earliest and the latest published ads

SELECT MIN([Date]) AS MinDate, MAX([Date]) AS MaxDate
FROM Ads

-- Problem 9.	Latest 10 Ads
-- Find the latest 10 ads sorted by date in descending order. Display for each ad its title, date and status

SELECT TOP(10) a.Title, a.[Date], s.Status
FROM Ads a JOIN AdStatuses s
	ON a.StatusId = s.Id
ORDER BY [Date] DESC

-- Problem 10.	Not Published Ads from the First Month
-- Find all not published ads, created in the same month and year like the earliest ad.
-- Display for each ad its id, title, date and status. Sort the results by Id

SELECT a.Id, a.Title, a.[Date], s.[Status]
FROM Ads a JOIN AdStatuses s
	ON a.StatusId = s.Id
WHERE s.Status <> 'Published'
	AND MONTH(a.[Date]) = (SELECT MONTH(MIN([Date])) FROM Ads)
	AND YEAR(a.[Date]) = (SELECT YEAR(MIN([Date])) FROM Ads)
ORDER BY a.Id

-- Problem 11.	Ads by Status
-- Display the count of ads in each status. Sort the results by status

SELECT s.[Status], COUNT(*) AS [Count]
FROM Ads a JOIN AdStatuses s
	ON a.StatusId = s.Id
GROUP BY s.[Status]

-- Problem 12.	Ads by Town and Status
-- Display the count of ads for each town and each status. Sort the results by town, then
-- by status. Display only non-zero counts

SELECT t.Name AS [Town Name], s.[Status], COUNT(*) AS [Count]
FROM Ads a JOIN Towns t
	ON a.TownId = t.Id
	JOIN AdStatuses s
	ON a.StatusId = s.Id
GROUP BY t.Name, s.[Status]
ORDER BY t.Name, s.[Status]

-- Problem 13.	* Ads by Users
-- Find the count of ads for each user. Display the username, ads count and "yes" or "no"
-- depending on whether the user belongs to the role "Administrator". Sort the results by username

SELECT u.UserName, COUNT(a.Id) AS [AdsCount], 
	CASE MIN(r.Name) 
	WHEN 'Administrator' THEN 'yes'
	ELSE 'no'
	END AS [IsAdministrator]
FROM AspNetUsers u
    LEFT JOIN Ads a ON a.OwnerId = u.Id
    LEFT JOIN AspNetUserRoles ur ON ur.UserId = u.Id
    LEFT JOIN AspNetRoles r ON (ur.RoleId = r.Id AND r.Name='Administrator')
GROUP BY u.UserName
ORDER BY u.UserName

-- Problem 14.	Ads by Town
-- Find the count of ads for each town. Display the ads count and town name or "(no town)" for the ads
-- without a town. Display only the towns, which hold 2 or 3 ads. Sort the results by town name

SELECT COUNT(*) AS AdsCount, ISNULL(t.Name, '(no town)') AS Town
FROM Ads a LEFT JOIN Towns t
	ON a.TownId = t.Id
GROUP BY t.Name
HAVING COUNT(*) = 2 OR COUNT(*) = 3

-- Problem 15.	Pairs of Dates within 12 Hours
-- Consider the dates of the ads. Find among them all pairs of different dates, such that the second date
-- is no later than 12 hours after the first date. Sort the dates in increasing order by the first date,
-- then by the second date

SELECT a.[Date] AS FirstDate, b.[Date] AS SecondDate
FROM Ads a, Ads b
WHERE a.[Date] < b.[Date] 
	AND DATEDIFF(SECOND, b.[Date], a.[Date]) < 12 * 60 * 60
ORDER BY a.[Date], b.[Date]

-- 





