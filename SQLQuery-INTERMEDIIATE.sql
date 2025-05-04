--/* 
--INTERMEDIATE:
--	Joins
--	Unions
--	Case Statements
--	Updating/Deleting Data
--	Partition By
--	Data Types 
--	Aliasing
--	Creating Views
--	Having vs Group By Statement
--	GETDATE()
--	Primary Key vs Foreign Key
--*/

--*************************
--/* Inner Joins, Full/Left/Right, Outer Joins */
--*************************

--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics

--SELECT *
--FROM SQLTutorial.dbo.EmployeeSalary

--SELECT *
--FROM SQLTutorial.dbo.WareHouseDemographics

--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics
--Inner Join SQLTutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics
--Full Outer Join SQLTutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics
--LEFT Outer Join SQLTutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics
--RIGHT Outer Join SQLTutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--	ORDER BY Salary DESC

--Select EmployeeDemographics.EmployeeID, FirstName, LastName, Gender, JobTitle, Salary
--FROM SQLTutorial.dbo.EmployeeDemographics
--Inner Join SQLTutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE FirstName <> 'Michael'
--ORDER BY Salary Desc

--SELECT ED.EmployeeID, FirstName , LastName, ES.JobTitle, ES.Salary
--FROM SQLTutorial.dbo.EmployeeDemographics ED
--INNER Join SQLTutorial.dbo.EmployeeSalary ES
--	ON ED.EmployeeID = ES.EmployeeID
--WHERE FirstName <> 'Michael'
--ORDER BY Salary DESC


--*************************
--/* TOPIC: UNION, Union All */
--*************************

--USE SQLTutorial
--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics
--Full OUTER JOIN SQLTutorial.dbo.WareHouseEmployeeDemographics
--	ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID

--/* Works- brings in distinct records only - the columns are the same -  */
--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics
--UNION
--SELECT *
--FROM SQLTutorial.dbo.WareHouseEmployeeDemographics

--/* the Union All includes duplics and Null records */
--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics
--UNION ALL 
--SELECT *
--FROM SQLTutorial.dbo.WareHouseEmployeeDemographics

--/* Does Work as the columns are different */
--SELECT EmployeeID, FirstName, Age
--FROM SQLTutorial.dbo.EmployeeDemographics
--UNION
--SELECT EmployeeID, JobTitle, Salary
--FROM SQLTutorial.dbo.EmployeeSalary
--ORDER BY EmployeeID

--*************************
/* Topic: Case statement */
--*************************

/* When the a condition is met, the Case statement is completed */

	SELECT FirstName, LastName, Age
	FROM SQLTutorial.dbo.EmployeeDemographics
	WHERE Age IS NOT NULL
	ORDER BY Age

	--INSERT INTO dbo.EmployeeDemographics VALUES
	--(1011, 'Ryan','Howard',26,'Male')

--SELECT FirstName, LastName, Age,
--	CASE
--		When Age >= 38 Then 'Very Old' /* This condition is met by first condition */
--		WHEN Age > 30 THEN 'Old'
--		WHEN Age BETWEEN 27 AND 30 THEN  'Young'
--		ELSE 'Baby'
--	END AS YO
--FROM SQLTutorial.DBO.EmployeeDemographics
--WHERE Age IS NOT NULL
--ORDER BY Age

--SELECT FirstName, LastName, JobTitle, Salary,
--	CASE
--		WHEN JobTitle = 'Salesman' Then (Salary * 1.10)
--		WHEN JobTitle = 'Accountant' THEN (Salary * 1.05)
--		WHEN JobTitle = 'HR' THEN (Salary * 1.000001)
--		ELSE (Salary * 1.03)
--	END AS SalaryAfterRaise
--FROM SQLTutorial.dbo.EmployeeDemographics
--JOIN SQLTutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--*************************
/* 	HAVING vs Where 
	Both were created to filter rows of data, but they filter 2 separate things
	Where is going to filters rows based off columns of data
	Having is going to filter rows based off aggregated columns when grouped */
--*************************

--SELECT Gender, AVG(Age)
--FROM EmployeeDemographics
--GROUP BY Gender
;

/*-- let's try to filter on the avg age using where - this doesn't work because of the order of operations. 
On the backend WHERE comes before the GROUP BY, So you can't filter on data that hasn't been grouped yet
this is why 'Having' was created  */

--SELECT gender, AVG(age)
--FROM EmployeeDemographics
--WHERE AVG(age) > 30
--GROUP BY gender
--;

/**************************
 HAVING CLAUSE 
**************************/

/* In SQL Server, you cannot refer to column aliases defined in the SELECT clause directly in the HAVING, WHERE, or ORDER BY clauses.
This is because SQL Server processes the HAVING, WHERE, and ORDER BY clauses before the SELECT clause. */

--/* Doesn't Work with column Alias */
--SELECT gender, AVG(Age) as AVG_age
--FROM EmployeeDemographics
--GROUP BY Gender
--HAVING AVG_age > 30
--;

--/*  Work with column function AVG(age) */
--SELECT gender, AVG(Age) as AVG_age
--FROM EmployeeDemographics
--GROUP BY gender
--HAVING AVG(age) > 30
--;

/**************************
   TOPIC: Having Clause 
**************************/

--SELECT JobTitle, COUNT(JobTitle)
--FROM SQLTutorial.dbo.EmployeeDemographics
--JOIN SQLTutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--Where COUNT(JobTitle) --Error
--GROUP BY JobTitle

--SELECT JobTitle, COUNT(JobTitle)
--FROM SQLTutorial.dbo.EmployeeDemographics
--JOIN SQLTutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING COUNT(JobTitle) > 1 --CORRECT

--SELECT Jobtitle, AVG(Salary)
--FROM SQLTutorial.dbo.EmployeeDemographics
--JOIN SQLTutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING AVG(Salary) >45000
--ORDER BY AVG(Salary)

/**************************
Topic: Updating/Deleting Data
**************************/

--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics
--where LastName = 'FLAX'


--UPDATE SQLTutorial.DBO.EmployeeDemographics
--SET EmployeeID = 1012
--WHERE FirstName = 'Holly' AND Lastname = 'Flax'

--UPDATE SQLTutorial.DBO.EmployeeDemographics
--SET Age = 31, Gender = 'Female'
--WHERE EmployeeID = 1012

--SELECT * -- DATA CHECK before Delete
--FROM SQLTutorial.dbo.EmployeeDemographics
--WHERE EmployeeID = 1005

--DELETE 
--FROM SQLTutorial.dbo.EmployeeDemographics
--WHERE EmployeeID = 1005

/***********************
    TOPIC: Aliasing
************************/

/* Aliase for Column Name */
--SELECT FirstName AS Fname
--FROM SQLTutorial.dbo.EmployeeDemographics

--SELECT FirstName + ' ' + LastName AS FullName
--FROM SQLTutorial.dbo.EmployeeDemographics

--SELECT AVG(Age) as AvgAge
--FROM SQLTutorial.dbo.EmployeeDemographics

/* Aliase for Table Name */
--SELECT Demo.EmployeeID, 
--FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
--JOIN SQLTutorial.dbo.EmployeeSalary AS SAL
--	ON Demo.EmployeeID = SAL.EmployeeID

SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Sal.JobTitle, Ware.Age
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
LEFT JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN SQLTutorial.dbo.WareHouseEmployeeDemographics AS Ware
	ON Demo.EmployeeID = Ware.EmployeeID
	
/***********************
  Topic: Partition By
***********************/
--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics

--SELECT *
--FROM SQLTutorial.dbo.EmployeeSalary

SELECT Dem.FirstName, Dem.LastName, Dem.Gender, Sal.Salary,
Count(Gender) OVER (partition by Gender) as TotalGender
FROM SQLTutorial.dbo.EmployeeDemographics Dem
Join SQLTutorial.dbo.EmployeeSalary Sal
	On Dem.EmployeeID = Sal.EmployeeID

--/* Partition By Compare to Group BY */

--SELECT Dem.FirstName,  Dem.LastName, Dem.Gender, Sal.Salary, COUNT(Gender)
--FROM SQLTutorial.dbo.EmployeeDemographics Dem
--Join SQLTutorial.dbo.EmployeeSalary Sal
--	On Dem.EmployeeID = Sal.EmployeeID
--GROUP BY Dem.FirstName,  Dem.LastName, Dem.Gender, Sal.Salary

--SELECT Dem.Gender, COUNT(Gender)
--FROM SQLTutorial.dbo.EmployeeDemographics Dem
--Join SQLTutorial.dbo.EmployeeSalary Sal
--	On Dem.EmployeeID = Sal.EmployeeID
--GROUP BY Dem.Gender

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

/***************************************
TOPIC: TEMP TABLES begin with a # sign
***************************************/

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

DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT(JobTitle), Avg(Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics as emp
JOIN SQLTutorial.dbo.EmployeeSalary as sal
	ON emp.EmployeeID = sal.EmployeeID
Group By JobTitle

SELECT *
FROM #Temp_Employee2

/****************
TOPICtOPIC: GETDATE()  - INSERTS SYSTEM TIME IS FIELD IS LEFT NULL
*****************/

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT *
FROM SQLTutorial.dbo.EmployeeSalary

/* ADD COLUMN FOR DATE & TIME 
*******************************/
ALTER TABLE dbo.EmployeeSalary
ADD DateHire DATETIME DEFAULT GETDATE();

/* UPDATE DATEHIRE COLUMN FOR EXISTING ROWS WITH CURRENT SYSTEM DATE */
UPDATE dbo.EmployeeSalary
SET DateHire = GETDATE()
;

/************************************
CHANGE DATA TYPE TO DATE ONLY
*************************************/
-- Drop the existing default constraint (if it exists)
IF EXISTS (SELECT * FROM sys.default_constraints WHERE parent_object_id = OBJECT_ID('dbo.EmployeeSalary') AND type_desc = 'DEFAULT_CONSTRAINT' AND name = 'DF_DateHire')
BEGIN
    ALTER TABLE dbo.EmployeeSalary
    DROP CONSTRAINT DF_DateHire
END;

-- Drop the default constraint associated with the DateHire column
ALTER TABLE dbo.EmployeeSalary
DROP CONSTRAINT DF__EmployeeS__DateH__5CD6CB2B;

-- Add the default constraint with the updated format
ALTER TABLE dbo.EmployeeSalary
ALTER COLUMN DateHire VARCHAR(10);

-- Update existing ROWS to set DateHire to the current date without time.
--The 23 parameter in the CONVERT function specifies the style code for this format.
UPDATE dbo.EmployeeSalary
SET DateHire = CONVERT(DATE, GETDATE(),23);


/******************************
   Primary Key vs Foreign Key
******************************?

--Clone existing table into a NEW TABLE
SELECT *
INTO NEWEmployeeDemo
FROM dbo.EmployeeDemographics

SELECT *
INTO NEWEmployeeSal
FROM dbo.EmployeeSalary

SELECT * 
FROM SQLTutorial.dbo.NEWEmployeeDemo

SELECT * 
FROM SQLTutorial.dbo.NEWEmployeeSal

--ALTER TABLE SQLTutorial.dbo.NEWEmployeeDemo -ERROR NULLABLE COLUMN
--ADD CONSTRAINT NEWemployeeDemo_EmployeeID PRIMARY KEY (employeeID);

/* Check for Null values */
SELECT *
FROM dbo.NEWEmployeeDemo 
WHERE EmployeeID is NULL

-- Alter the table to make employID NOT NULL
ALTER TABLE SQLTutorial.dbo.NEWEmployeedemo
ALTER COLUMN employeeID INT NOT NULL;

-- Add the primary key constraint
ALTER TABLE SQLTutorial.dbo.NEWEmployeeDemo
ADD CONSTRAINT PK_NEWEmployeeDemo_EmployeeID PRIMARY KEY (EmployeeID);

ALTER TABLE sqltutorial.dbo.EmployeeSalary
ADD CONSTRAINT FK_NEWEmployeeSalary_employeeID FOREIGN KEY (employeeID) 
REFERENCES SQLTutorial.dbo.NEWEmployeeDemo(employeeID);


