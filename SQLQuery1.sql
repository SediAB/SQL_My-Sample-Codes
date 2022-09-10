CREATE TABLE EmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

CREATE TABLE EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int)

INSERT INTO EmployeeDemographics VALUES
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male'),
(1010, 'Ryan' , 'Howard', 26, 'Male'),
(1011, 'Holly' , 'Flax' , 23, 'NULL'),
(1012, 'Darryl' , 'Philbin' , 30, 'Male')

Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000),
(1010, 'NULL', 47000),
(1011, 'Salesman', 43000)


/*
Select Statement
*, Top, Distinct, Count, As, Max, Min, Avg
*/

SELECT *
FROM EmployeeDemographics

SELECT FirstName, LastName
FROM EmployeeDemographics

SELECT TOP 5 *
FROM EmployeeDemographics

SELECT DISTINCT (EmployeeID)
FROM EmployeeDemographics

SELECT DISTINCT (Gender)
FROM EmployeeDemographics

SELECT COUNT(LastName) AS LastNameCount
FROM EmployeeDemographics

SELECT *
FROM EmployeeSalary

SELECT MAX(Salary)
FROM EmployeeSalary

SELECT MIN(Salary)
FROM EmployeeSalary

SELECT AVG(Salary)
FROM EmployeeSalary

SELECT *
FROM [SQL Practice].dbo.EmployeeSalary

/*
Where Statement
=, <>, <, >, And, Or, Like, Null, Not Null, In
*/

SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim'

SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim'

SELECT *
FROM EmployeeDemographics
WHERE Age >= 30

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 AND Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 OR Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S%'

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%o%'

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NOT NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael')

/*
Group By, Order By
*/

SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC, Gender DESC

SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY Gender DESC


/*
Inner Joins, Full/Left/Right/Outer Joins
*/

SELECT *
FROM [SQL Practice].dbo.EmployeeDemographics
Inner Join [SQL Practice].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM [SQL Practice].dbo.EmployeeDemographics
Full Outer Join [SQL Practice].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM [SQL Practice].dbo.EmployeeDemographics
Right Outer Join [SQL Practice].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM [SQL Practice].dbo.EmployeeDemographics
Right Outer Join [SQL Practice].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EMployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM [SQL Practice].dbo.EmployeeDemographics
Left Outer Join [SQL Practice].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EMployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
FROM [SQL Practice].dbo.EmployeeDemographics
Inner Join [SQL Practice].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

SELECT [EmployeeID],
[FirstName],
[LastName],
[Age],
[Gender],
COUNT(*) AS CNT
FROM [SQL Practice].dbo.EmployeeDemographics
GROUP BY EmployeeID,
FirstName,
LastName,
Age,
Gender
HAVING COUNT(*) > 1;

SELECT [EmployeeID],
[JobTitle],
[Salary],
COUNT(*) AS CNT
FROM [SQL Practice].dbo.EmployeeSalary
GROUP BY EmployeeID,
JobTitle,
Salary
HAVING COUNT(*) > 1;

WITH CTE ([EmployeeID],
[FirstName],
[LasetName],
[Age],
[Gender],
duplicatecount)
AS (SELECT [EmployeeID],
[FirstName],
[LastName],
[Age],
[Gender],
Row_Number() OVER (PARTITION BY [EmployeeID],
[FirstName],
[LastName],
[Age],
[Gender]
ORDER BY EmployeeID) AS DuplicateCount
FROM [SQL Practice].dbo.EmployeeDemographics)
DELETE FROM CTE
WHERE duplicateCount > 1;

WITH CTE ([EmployeeID],
[JobTitle],
[Salary],
duplicatecount)
AS (SELECT [EmployeeID],
[JobTitle],
[Salary],
Row_Number() OVER (PARTITION BY [EmployeeID],
[JobTitle],
[Salary]
ORDER BY EmployeeID) AS DuplicateCount
FROM [SQL Practice].dbo.EmployeeSalary)
DELETE FROM CTE
WHERE duplicateCount > 1;

SELECT JobTitle, AVG(Salary)
FROM [SQL Practice].dbo.EmployeeDemographics
Inner Join [SQL Practice].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

/*
Union, Union All
*/


CREATE TABLE WarehouseEmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

INSERT INTO WarehouseEmployeeDemographics VALUES
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')
 

SELECT *
FROM WarehouseEmployeeDemographics

SELECT *
FROM [SQL Practice].dbo.EmployeeDemographics
UNION ALL
SELECT *
FROM [SQL Practice].dbo.WarehouseEmployeeDemographics

SELECT *
FROM [SQL Practice].dbo.EmployeeDemographics
UNION
SELECT *
FROM [SQL Practice].dbo.WarehouseEmployeeDemographics
ORDER BY EmployeeID

/*
Case Statement
*/

SELECT FirstName, LastName, Age,
CASE
WHEN Age > 30 THEN 'Old'
WHEN Age BETWEEN 27 AND 30 THEN 'Young'
ELSE 'Baby'
END
FROM [SQL Practice].dbo.EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

SELECT FirstName, LastName, JobTitle, Salary,
CASE
WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM [SQL Practice].dbo. EmployeeDemographics
JOIN [SQL Practice].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/*
Having Clause
*/

SELECT JobTitle, AVG(Salary)
FROM [SQL Practice].dbo.EmployeeDemographics
JOIN [SQL Practice].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG (Salary)

/*
Updating/Deleting Data
*/

SELECT * 
FROM [SQL Practice].dbo.EmployeeSalary

UPDATE [SQL Practice].dbo.EmployeeSalary
SET JobTitle = 'HR'
WHERE EmployeeID = 1010

UPDATE [SQL Practice].dbo.EmployeeSalary
SET Salary = 55000
WHERE JobTitle = 'Regional Manager'

DELETE
FROM [SQL Practice].dbo.EmployeeDemographics
WHERE EmployeeID = 1005

/*
Aliasing
*/

SELECT FirstName + ' ' + LastName AS FullName
FROM [SQL Practice].dbo.EmployeeDemographics

SELECT Avg(Age) AS AvgAge
FROM [SQL Practice].dbo.EmployeeDemographics

SELECT Demo.EmployeeID, Sal.Salary
FROM [SQL Practice].[dbo].[EmployeeDemographics] AS Demo
JOIN [SQL Practice].[dbo].[EmployeeSalary] AS Sal
ON Demo.EmployeeID = Sal.EmployeeID

SELECT Demo.EmployeeID, Demo.FirstName, Sal.JobTitle
FROM [SQL Practice].dbo.EmployeeDemographics Demo
LEFT JOIN [SQL Practice].dbo.EmployeeSalary Sal
ON Demo.EmployeeID = Sal.EmployeeID

/*
Partition By
*/

SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM [SQL Practice].dbo.EmployeeDemographics dem
JOIN [SQL Practice].dbo.EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeID






