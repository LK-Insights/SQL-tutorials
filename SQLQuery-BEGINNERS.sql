/*
Beginners:
	Create database, tables w/columns and insert information 
	Select Statement: *, Top, Distinct, Count, As, Max, Min, Avg 
	Where, Groupby, and Orderby statements
*/


--CREATE DATABASE SQLTutorial;
--CREATE TABLE EmployeeDemographics 
--(EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50)
--);

--CREATE TABLE EmployeeSalary 
--(EmployeeID int,
--JobTitle varchar(50),
--Salary int,
--);

--CREATE TABLE WareHouseEmployeeDemographics (
--EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50)
--);

	--INSERT INTO SQLTutorial.dbo.EmployeeDemographics VALUES
	--(1001,	'Jim',	'Halpert',	30,	'Male'),
	--(1002,	'Pam',	'Beasley',	30,	'Female'),
	--(1003,	'Dwight', 'Schrute', 29, 'Male'),
	--(1004,	'Angela', 'Martin',	31,	'Female'),
	--(1005,	'Toby',	'Flenderson', 32, 'Male'),
	--(1006,	'Michael', 'Scott',	35,	'Male'),
	--(1007,	'Meredith', 'Palmer', 32, 'Female'),
	--(1008,	'Stanley', 'Hudson', 38, 'Male'),
	--(1009,	'Kevin',	'Malone', 31, 'Male')

--INSERT INTO EmployeeSalary VALUES
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)

--INSERT INTO WareHouseEmployeeDemographics VALUES
--(1013, 'Darryl', 'Philbin', Null, 'Male'),
--(1050, 'Roy', 'Anderson', 31, 'Male'),
--(1051, 'Hidetoshli', 'Hasagawa', 40, 'Male'),
--(1052, 'Val', 'Johnson', 31, 'Female')

--SELECT TOP (1000) [EmployeeID],
--      [FirstName],
--      [LastName],
--      [Age],
--      [Gender]

	--SELECT *
	--FROM EmployeeDemographics

/* NOTE: Select & FROM Statement 
*, Top, Distinct, Count, As, Max, Min, Avg 
*/

	SELECT TOP 5 *
	FROM EmployeeDemographics

	--SELECT DISTINCT(Gender)
	--FROM EmployeeDemographics

	--SELECT COUNT(LastName) AS COUNT_LastName
	--FROM EmployeeDemographics

	--SELECT DISTINCT(EmployeeID) As UniqueID
	--FROM EmployeeDemographics

	--SELECT COUNT(LastName) As LastNameCount
	--FROM EmployeeDemographics

	--SELECT MAX(Salary) -- Select MIN(Salary) or AVG(Salary)
	--FROM EmployeeSalary

/* NOTE: FROM [SQLTutorial].[dbo].[EmployeeDemographics]
'dbo stands for "dbo=database owner. It's a schema that's created by default when you create a new database in SQL Server.
In SQL Server, objects like tables, views, stored procedures, etc., belong to a schema.
When working on one database .dbo. allows you to access a scheme from a different database.
*/

	--SELECT MAX(Salary) -- Select MIN(Salary) or AVG(Salary)
	--FROM SQLTutorial.dbo.EmployeeSalary

/***************
     WHERE 
****************/

	--SELECT *
	--FROM EmployeeDemographics
	--WHERE FirstName = 'Jim' --equal Jim
	--WHERE FirstName <> 'Jim' -- do not equal Jim
	--WHERE Age >30 --include people OVER the age of 30
	--WHERE Age >=30 -- include people 30 and over
	--WHERE Age <32 -- Less than 32
	--WHERE Age <=32 -- 32 and under
	--WHERE Age<= 32 AND Gender = 'Male' -- 2 criterias
	--WHERE Age<= 32 OR Gender = 'Male' -- 2 criterias
	--WHERE LastName LIKE 'S%' -- Any lastname that starts with 'S' (% wildcard)
	--WHERE LastName LIKE '%S%' -- Any lastname with 'S' in lastname (% wildcard)
	--WHERE LastName LIKE 'S%o%' -- 2 Like criterias Begins with 'S' and contains an 'o'
	--WHERE FirstName is NULL
	--WHERE FirstName is NOT NULL
	--WHERE FirstName ='Jim' AND FirstName = 'Toby', AND FirstName = 'Holly')
	--WHERE Firstname IN ('Jim', 'Toby', 'Holly')

/* Group By, Order By */

--SELECT *
--FROM EmployeeDemographics

--SELECT Gender
--FROM EmployeeDemographics

--SELECT DISTINCT(Gender)
--FROM EmployeeDemographics

--SELECT Gender, AGE, COUNT(Gender)
--FROM EmployeeDemographics
--GROUP BY Gender, AGE

--SELECT Gender, Age, COUNT(Gender) 
--FROM EmployeeDemographics
--WHERE Age > 31
--GROUP BY Gender, Age 

/* ORDER BY COLUMN NUMBER EX. 4=Age, 5=Gender */

--SELECT Gender, Age, COUNT(Gender) As CountGender
--FROM EmployeeDemographics
--WHERE Age > 31
--GROUP BY Gender, Age 
--ORDER BY Gender DESC

--SELECT *
--FROM EmployeeDemographics
--ORDER BY AGE, Gender DESC

--SELECT *
--FROM EmployeeDemographics
--ORDER BY Age DESC, Gender DESC
--ORDER BY 4 DESC, 5 DESC 



