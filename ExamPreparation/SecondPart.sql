USE Ads
GO

-- 1.	Create a table Countries(Id, Name)
CREATE TABLE Countries(
	Id INT IDENTITY NOT NULL PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
)

GO

-- Add a new column CountryId in the Towns table to link each town to some country (non-mandatory link)

ALTER TABLE Towns ADD CountryId INT
GO

-- Create a foreign key between the Countries and Towns tables

ALTER TABLE Towns ADD CONSTRAINT FK_TOWNS_COUNTRIES
FOREIGN KEY (CountryId) REFERENCES Countries(Id)
GO

-- 2.	Execute the following SQL script

INSERT INTO Countries(Name) VALUES ('Bulgaria'), ('Germany'), ('France')
UPDATE Towns SET CountryId = (SELECT Id FROM Countries WHERE Name='Bulgaria')
INSERT INTO Towns VALUES
('Munich', (SELECT Id FROM Countries WHERE Name='Germany')),
('Frankfurt', (SELECT Id FROM Countries WHERE Name='Germany')),
('Berlin', (SELECT Id FROM Countries WHERE Name='Germany')),
('Hamburg', (SELECT Id FROM Countries WHERE Name='Germany')),
('Paris', (SELECT Id FROM Countries WHERE Name='France')),
('Lyon', (SELECT Id FROM Countries WHERE Name='France')),
('Nantes', (SELECT Id FROM Countries WHERE Name='France'))

-- 3.	Write and execute a SQL command that changes the town to "Paris" for all ads created at Friday

UPDATE Ads
SET TownId = (SELECT TownId FROM Towns WHERE Name = 'Paris')
WHERE datepart(WEEKDAY, Date) = 6

-- 4.	Write and execute a SQL command that changes the town to "Hamburg" for all ads created at Thursday

UPDATE Ads
SET TownId = (SELECT TownId FROM Towns WHERE Name = 'Hamburg')
WHERE DATEPART(WEEKDAY, Date) = 5

-- 5.	Delete all ads created by user in role "Partner"

DELETE 
FROM Ads
FROM Ads a
	JOIN AspNetUsers u ON a.OwnerId = u.Id
	JOIN AspNetUserRoles ur ON u.Id = ur.UserId
	JOIN AspNetRoles r ON ur.RoleId = r.Id
WHERE r.Name = 'Partner'

-- 6.	Add a new add holding the following information: Title="Free Book", Text="Free C# Book",
-- Date={current date and time}, Owner="nakov", Status="Waiting Approval"

INSERT INTO Ads 
VALUES ('Free Book', 'Free C# Book', NULL,
	(SELECT Id FROM AspNetUsers WHERE UserName = 'nakov'),
	NULL, NULL, GETDATE(), 
	(SELECT Id FROM AdStatuses WHERE Status = 'Waiting Approval'))

-- 7.	Find the count of ads for each town. Display the ads count, the town name and the country
-- name. Include also the ads without a town and country. Sort the results by town, then by country

SELECT t.Name AS Town, c.Name AS Country, COUNT(a.Id) AS AdsCount
FROM Ads a
	FULL OUTER JOIN Towns t ON a.TownId = t.Id
	FULL OUTER JOIN Countries c ON t.CountryId = c.Id
GROUP BY t.Name, c.Name
ORDER BY t.Name, c.Name