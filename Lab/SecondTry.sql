-- Problem 1.	All Question Titles
-- Display all question titles in descending order

USE Forum
GO

SELECT Title
FROM Questions
ORDER BY Title ASC

-- Problem 2.	Answers in Date Range
-- Find all answers created between 15-June-2012 (00:00:00) and 21-Mart-2013 (23:59:59) sorted by date

SELECT Content, CreatedOn
FROM Answers
WHERE CreatedOn BETWEEN '15-Jun-2012' AND '21-Mar-2013'
ORDER BY CreatedOn

-- Problem 3.	Users with "1/0" Phones
-- Display all user username and last names along with a column named "Has Phone" holding "1" or "0"
-- for all users sorted by their last name

SELECT Username,
	LastName,
	CASE WHEN PhoneNumber IS NULL THEN '0'
		ELSE '1' 
		END AS 'Has Phone'
FROM Users
ORDER BY LastName

-- Problem 4.	Questions with their Author
-- Find all questions along with their user sorted by Id. Display the question title and author username

SELECT q.Title AS [Question Title],
	u.Username AS Author
FROM Questions q JOIN Users u
	ON q.UserId = u.Id
ORDER BY q.Id

-- Problem 5.	Answers with their Question with their Category and User 
-- Find all answers along with their questions, along with question category, along with question
-- author sorted by Category Name. Display the answer content, created on, question title, category
-- name and author username

SELECT a.Content AS [Answer Content],
	a.CreatedOn,
	u.Username AS [Answer Author],
	q.Title AS [Category Name]
FROM Answers a JOIN Questions q
	ON a.QuestionId = q.Id
	JOIN Users u
	ON a.UserId = u.Id
	JOIN Categories c
	ON q.CategoryId = c.Id
ORDER BY c.Name

-- Problem 6.	Category with Questions
-- Find all categories along with their questions sorted by category name. Display the category
-- name, question title and created on columns

SELECT c.Name,
	q.Title,
	q.CreatedOn
FROM Questions q RIGHT JOIN Categories c
	ON q.CategoryId = c.Id
ORDER BY c.Name

-- Problem 7.	*Users without PhoneNumber and Questions
-- Find all users that have no phone and no questions sorted by RegistrationDate. Show all user data

SELECT u.Id, u.Username, u.FirstName, u.PhoneNumber, u.RegistrationDate, u.Email
FROM Users u LEFT JOIN Questions q
	ON q.UserId = u.Id
WHERE u.PhoneNumber IS NULL
	AND q.Id IS NULL
ORDER BY u.RegistrationDate

-- Problem 8.	Earliest and Latest Answer Date
-- Find the dates of the earliest answer for 2012 year and the latest answer for 2014 year

SELECT MIN(CreatedOn) AS MinDate,
	MAX(CreatedOn) AS MaxDate
FROM Answers
WHERE CreatedOn BETWEEN '01-Jan-2012' AND '31-Dec-2014'

-- Problem 9.	Find the latest ten answers
-- Find the latest 10 answers sorted by date of creation in descending order. Display for each ad
-- its content, date and author

SELECT TOP 10 a.Content,
	a.CreatedOn,
	u.Username AS Author
FROM Answers a JOIN Users u
	ON a.UserId = u.Id
ORDER BY a.CreatedOn


-- Problem 10.	Not Published Ads from the First and Last Month
-- Find the answers which is not hidden from the first and last month where there are any published
-- answer, from the last year where there are any published answers. Display for each ad its answer
-- content, question title and category name. Sort the results by category name

SELECT a.Content AS [Answer Content],
	q.Content AS Question,
	c.Name AS Category
FROM Answers a JOIN Questions q
	ON a.QuestionId = q.Id
	JOIN Categories c
	ON q.CategoryId = c.Id
WHERE IsHidden = '1'
	AND (MONTH(a.CreatedOn) = (
		SELECT MONTH(MIN(CreatedOn))
		FROM Answers
	) OR MONTH(a.CreatedOn) = (
		SELECT MONTH(MAX(CreatedOn))
		FROM Answers
	))
	AND YEAR(a.CreatedOn) = (
		SELECT YEAR(MAX(CreatedOn))
		FROM Answers
	)
ORDER BY c.Name

-- Problem 11.	Answers count for Category
-- Display the count of answers in each category. Sort the results by answers count in descending order

SELECT c.Name AS Category,
	COUNT(a.Id) AS [Answers Count]
FROM Categories c LEFT OUTER JOIN Questions q
	ON c.Id = q.CategoryId
	LEFT OUTER JOIN Answers a
	ON a.QuestionId = q.Id
GROUP BY c.Name
ORDER BY [Answers Count] DESC

-- Problem 12.	Answers Count by Category and Username
-- Display the count of answers for category and each username. Sort the results by Answers count.
-- Display only non-zero counts. Display only users with phone number

SELECT c.Name AS Category,
	u.Username,
	u.PhoneNumber,
	COUNT(a.Id) AS [Answers Count]
FROM Categories c JOIN Questions q
	ON q.CategoryId = c.Id
	JOIN Answers a
	ON a.QuestionId = q.Id
	JOIN Users u
	ON u.Id = a.UserId
WHERE u.PhoneNumber IS NOT NULL
GROUP BY c.Name, u.Username, u.PhoneNumber
ORDER BY [Answers Count] DESC

-- 1.	Create a table Towns(Id, Name). Use auto-increment for the primary key. Add a
-- new column TownId in the Users table to link each user to some town (non-mandatory link).
-- Create a foreign key between the Users and Towns tables

CREATE TABLE Towns(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50)
)

GO

ALTER TABLE Users ADD TownId INT
GO

ALTER TABLE Users ADD CONSTRAINT FK_Users_Towns
FOREIGN KEY (TownId) REFERENCES Towns(Id)
GO

-- 2.	Execute the following SQL script (it should pass without any errors):

INSERT INTO Towns(Name) VALUES ('Sofia'), ('Berlin'), ('Lyon')
UPDATE Users SET TownId = (SELECT Id FROM Towns WHERE Name='Sofia')
INSERT INTO Towns VALUES
('Munich'), ('Frankfurt'), ('Varna'), ('Hamburg'), ('Paris'), ('Lom'), ('Nantes')

-- 3.	Write and execute a SQL command that changes the town to "Paris" for all users with registration date at Friday

UPDATE Users
SET TownId = (
	SELECT Id
	FROM Towns
	WHERE Name = 'Paris'
)
WHERE DATENAME(WEEKDAY, RegistrationDate) = 'Friday'

-- 4.	Write and execute a SQL command that changes the question to “Java += operator” of Answers,
-- answered at Monday or Saturday in February

UPDATE Answers
SET QuestionId = (
	SELECT Id
	FROM Questions
	WHERE Title = 'Java += operator'
)
WHERE (DATENAME(WEEKDAY, CreatedOn) = 'Monday' OR DATENAME(WEEKDAY, CreatedOn) = 'Saturday')
	AND MONTH(CreatedOn) = 2

-- 5.	Delete all answers with negative sum of votes

ALTER TABLE Votes 
DROP CONSTRAINT FK_Votes_Answers

ALTER TABLE Votes ADD CONSTRAINT FK_Votes_Answers
FOREIGN KEY (AnswerId) REFERENCES Answers(Id) ON DELETE CASCADE

DELETE 
FROM Answers
FROM Answers a JOIN Votes v
	ON v.AnswerId = a.Id
WHERE a.Id IN (
	SELECT AnswerId
	FROM Votes
	GROUP BY AnswerId
	HAVING SUM(Value) < 0
)

-- 6.	Add a new question holding the following information: Title="Fetch NULL values in PDO query",
-- Content="When I run the snippet, NULL values are converted to empty strings. How can fetch NULL values?",
-- CreatedOn={current date and time}, Owner="darkcat", Category="Databases"

INSERT INTO Questions
VALUES ('Fetch NULL values in PDO query', 'When I run the snippet, NULL values are converted to empty strings. How can fetch NULL values?',
	(SELECT Id FROM Categories WHERE Name = 'Databases'),
	(SELECT Id FROM Users WHERE Username = 'darkcat'),
	GETDATE())

-- 7.	Find the count of the answers for the users from town. Display the town name, username and answers
-- count. Sort the results by answers count in descending order, then by username

SELECT t.Name AS Town,
	u.Username,
	COUNT(a.Id) AS AnswersCount
FROM Answers a FULL OUTER JOIN Users u
	ON a.UserId = u.Id
	FULL OUTER JOIN Towns t
	ON u.TownId = t.Id
GROUP BY t.Name, u.Username
ORDER BY AnswersCount DESC, u.Username

-- 