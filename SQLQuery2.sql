CREATE TABLE Authors(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(100) CHECK([Name]>2),
Surname NVARCHAR(100) 
)

CREATE TABLE Books(
Id INT PRIMARY KEY IDENTITY,
AuthorId INT ,
[Name] NVARCHAR(100) CHECK([Name]>2),
PageCount INT FOREIGN KEY REFERENCES Authors(Id),
)


CREATE VIEW BookAuthors 
AS
SELECT Bk.Id,
Bk.Name,
Bk.PageCount,
CONCAT(Au.Name, ' ', Au.Surname) AS AuthorFullName
FROM Books Bk
JOIN Authors Au ON Bk.AuthorId = Au.Id


SELECT* FROM BookAuthors

CREATE TABLE DeletedBooks (
    Id INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(100) ,
    PageCount INT ,
	AuthorId INT FOREIGN KEY REFERENCES Authors(Id),
)

CREATE TRIGGER DeleteBook
ON Books
AFTER DELETE
AS
BEGIN
    INSERT INTO DeletedBooks (Id, AuthorId, Name, PageCount)
    SELECT Id, AuthorId, Name, PageCount 
	FROM deleted;
END


CREATE PROCEDURE Search @Name NVARCHAR(100)
AS
SELECT Books.Id,
       Books.Name,
	   Books.PageCount,
	   Authors.Name,
	   CONCAT(Authors.Name, ' ', Authors.Surname) AS AuthorFullName
from Books 
JOIN Authors ON Books.AuthorId = Authors.Id
WHERE Books.Name=@Name or Authors.Name = @Name

Exec Search Kitab

CREATE FUNCTION MinPageCount (@page INT = 10)
RETURNS INT
AS
BEGIN



END
