/* 
ADVANCED:
	CTEs
	Temp Tables
	String Functions (TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower)
	Stored Procedures
	Subqueries
	Importing Data from different File Types/Sources
	Exporting Data to different File Types
	SYS tables
*/

/************************************************************
TOPIC: CTE - IS ONLY CREATE IN MEMORY, ACTS LIKE SUB QUEURIES 
*************************************************************/

--WITH CTE_Employee AS 
--(SELECT Emp.FirstName, Emp.LastName, Emp.Gender, Sal.Salary,
--Count(Gender) OVER (PARTITION by Gender) as TotalGender,
--AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
--FROM SQLTutorial.dbo.EmployeeDemographics Emp
--Join SQLTutorial.dbo.EmployeeSalary Sal
--	On Emp.EmployeeID = Sal.EmployeeID 
--WHERE Salary > '45000'
--)
--Select TotalGender, FirstName, AvgSalary 
--FROM CTE_Employee

/****************
TOPIC: TEMP TABLES
*****************/

--CREATE Table #temp_Employee (
--EmployeeID int,
--JobTitle varchar(100),
--Salary int
--)

--Select *
--FROM #temp_Employee

--INSERT INTO #temp_Employee VALUES
--('1001', 'HR', '45000')

--INSERT INTO #temp_Employee
--SELECT *
--FROM SQLTutorial.dbo.EmployeeSalary

--DROP TABLE IF EXISTS #Temp_Employee2 
--CREATE TABLE #Temp_Employee2 (
--JobTitle varchar(50),
--EmployeesPerJob int,
--AvgAge int,
--AvgSalary int
--)

--INSERT INTO #Temp_Employee2
--SELECT JobTitle, COUNT(JobTitle), Avg(Age), AVG(Salary)
--FROM SQLTutorial.dbo.EmployeeDemographics as emp
--JOIN SQLTutorial.dbo.EmployeeSalary as sal
--	ON emp.EmployeeID = sal.EmployeeID
--Group By JobTitle

--Select *
--FROM #Temp_Employee2

/****************************************************************************
TOPIC: STRING FUNCTIONS - TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER, LOVER
*****************************************************************************/

--CREATE TABLE EmployeeErrors (
--EmployeeID varchar(50),
--FirstName varchar(50),
--LastName varchar(50)
--)

--INSERT INTO EmployeeErrors VALUES 
--('1001','Jimbo', 'Halbert'),
--(' 1002','Pamela', 'Beasely'),
--('1005', 'TOby', 'Flenderson - Fired')

--select *
--from EmployeeErrors

----Using Trim, LTrim, RTrim

--SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM
--FROM EmployeeErrors

--SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM
--FROM EmployeeErrors

--SELECT EmployeeID, RTRIM(EmployeeID) AS IDTRIM
--FROM EmployeeErrors


----Using Replace

--SELECT LastName, REPLACE(LastName, ' - Fire', '') as LastNameFixed
--FROM EmployeeErrors

----Using Substring (column, firsting character, show the following 3 chars) = Tob or (column, first at 3, show 3) Tody = y

--SELECT SUBSTRING(FirstName,1,3)
--FROM EmployeeErrors


----substring for identifing Fuzzy column information in relationship tables
--SELECT err.FirstName, Substring(err.FirstName,1,3), err.Lastname, dem.FirstName, Substring(dem.FirstName,1,3), dem.LastName
--FROM EmployeeErrors err
--JOIN EmployeeDemographics dem
--	ON Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)


----Using UPPER and lower text

--SELECT FirstName, LOWER(FirstName)
--FROM EmployeeErrors

--SELECT FirstName, UPPER(FirstName)
--FROM EmployeeErrors

/***********************************
           Stored Procedures
***********************************/

--CREATE PROCEDURE Test
--AS
--SELECT *
--FROM EmployeeDemographics

--EXEC TEST

--DROP PROCEDURE TEMP_EMPLOYEE

--CREATE PROCEDURE Temp_Employee
--AS
--CREATE TABLE #temp_employee (
--	JobTitle varchar(100),
--	EmployeesPerJob int,
--	AvgAge int,
--	AvgSalary int
--)
--INSERT INTO #temp_employee
--	SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
--	FROM SQLTutorial..EmployeeDemographics Emp
--	Join SQLTutorial..EmployeeSalary Sal
--		ON Emp.EmployeeID = Sal.EmployeeID
--	GROUP BY JobTitle
--;

--EXEC Temp_Employee

--SELECT *
--FROM #temp_employee 


--EXEC Temp_Employee @JobTitle = 'Salesman'

 
/******************************************************
Subqueries (in the Select, From, and where statement)
******************************************************/

--Select *
--FROM EmployeeSalary

/** Subquery in Select **/
Select AVG(Salary) FROM EmployeeSalary

Select EmployeeID, Salary, (Select AVG(Salary) FROM EmployeeSalary) AS AllAVGSalary
FROM EmployeeSalary

--How to do it with Partition By
Select EmployeeID, Salary, AVG(Salary) over () AS AllAVGSalary
FROM EmployeeSalary

--Why Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) AS AllAVGSalary
FROM EmployeeSalary
Group by EmployeeID, Salary
Order by 1,2

--Subquery in From
Select a.EmployeeID, AllAvgSalary
FROM (Select EmployeeID, Salary, AVG(Salary) over () AS AllAVGSalary
		FROM EmployeeSalary) a

--Subquery in Where
Select EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
		Select EmployeeID
		FROM EmployeeDemographics
		WHERE Age >30);


/*******************
   Stored Procedures
*********************/

--Delimiter $$
CREATE PROCEDURE large_salaries2
as begin
SELECT *
	FROM EmployeeSalary
	WHERE Salary >= 50000;
	SELECT *
	FROM EmployeeSalary
	WHERE Salary >= 10000;
end $$
--Delimiter;

EXEC large_salaries2;



