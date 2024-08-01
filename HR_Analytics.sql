-- first 5 rows
SELECT * FROM hr_analytics LIMIT 5;

-- Average Age of Employees

SELECT AVG(Age) as Average_Age
FROM hr_analytics;

-- Total Number of Employees per Department

SELECT department, COUNT(*) as Number_of_Employees
FROM hr_analytics
GROUP BY department;

-- Attrition Rate by Department
SELECT department, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Rate
FROM hr_analytics 
GROUP BY Department;

-- Top 5 Employees with the Highest Daily Rates
SELECT *
FROM hr_analytics
ORDER BY DailyRate DESC
LIMIT 5;

-- Average Monthly Income by Job Role

SELECT JobRole, AVG(MonthlyIncome) as Average_Monthly_Income
FROM hr_analytics
GROUP BY JobRole;

-- Employees with More than 10 Years at Company

SELECT *
FROM hr_analytics
WHERE YearsAtCompany > 10;

-- Attrition Rate by Age Group

SELECT AgeGroup, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS ATTRIBUTE_Rate
FROM hr_analytics
GROUP BY AgeGroup;

-- Average Distance from Home by Department

SELECT Department, AVG(DistanceFromHome) as Average_Distance
FROM hr_analytics
GROUP BY Department;

-- Employees with High Job Satisfaction (4 or 5)

SELECT EmpID, JobSatisfaction
FROM hr_analytics
WHERE JobSatisfaction >=4;

-- Average Number of Training Times Last Year by Education Field

SELECT EducationField, AVG(TrainingTimesLastYear) as Average_Training_Times
FROM hr_analytics
GROUP BY EducationField;

-- Employees in Research & Development with High Work-Life Balance

SELECT *
FROM hr_analytics
WHERE Department = 'Research & Development' AND WorkLifeBalance >= 4;

--Correlation Between Monthly Income and Job Level

SELECT JobLevel, AVG(MonthlyIncome) as Average_Monthly_Income
FROM hr_analytics
GROUP BY JobLevel;

-- Number of Employees with Stock Options

SELECT COUNT(*) as Number_of_Employees_with_Stock_Options
FROM hr_analytics
WHERE StockOptionLevel > 0;

-- Average Years Since Last Promotion by Gender

SELECT Gender, AVG(YearsSinceLastPromotion) as Average_Years_Since_Last
FROM hr_analytics
GROUP BY Gender;

-- Attrition by Business Travel Frequency
SELECT BusinessTravel, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Average_Business_Travel
FROM hr_analytics
GROUP BY BusinessTravel;

-- Employees with Low Relationship Satisfaction (1 or 2)

SELECT EmpID, RelationshipSatisfaction
FROM hr_analytics
WHERE RelationshipSatisfaction <= 2;


-- Average Total Working Years by Education

SELECT Education, AVG(TotalWorkingYears) as Average_Total_Working_Years
FROM hr_analytics
GROUP BY Education
ORDER BY Education;

-- Employees Who Left Within the First Year
SELECT *
FROM hr_analytics
WHERE Attrition = 'Yes' AND YearsAtCompany <=1;

--Distribution of Job Roles Across Departments
SELECT Department, JobRole, COUNT(EmpID) AS Total_Employees
FROM hr_analytics
GROUP BY Department, JobRole
ORDER BY Department ASC;

-- Average Performance Rating by Job Role

SELECT JobRole, AVG(PerformanceRating) as Average_Performance_Rating
FROM hr_analytics
GROUP BY JobRole;

-- Top Departments with the Highest Attrition
SELECT Department, COUNT(EmpID) AS Total_Employees
FROM hr_analytics

WHERE Attrition = 'Yes'
GROUP BY Department

ORDER BY Total_Employees DESC
LIMIT 1;

-- Average Job Involvement by Age Group
SELECT AgeGroup, AVG(JobInvolvement) AS Avg_Job_Involvement 
FROM hr_analytics 
GROUP BY AgeGroup;


-- Number of Employees by Education Field and Gender
SELECT EducationField, Gender, COUNT(EmpID) AS Total_Employees 
FROM hr_analytics 
GROUP BY EducationField, Gender;


-- Attrition by Marital Status
SELECT MaritalStatus, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Rate
FROM hr_analytics
GROUP BY MaritalStatus;

-- Average Years in Current Role by Job Level
SELECT JobLevel, AVG(YearsInCurrentRole) AS Avg_Years_Current_Role 
FROM hr_analytics 
GROUP BY JobLevel;

-- Total Employees in Each Education Field

SELECT EducationField, COUNT(EmpID) AS Total_Employees 
FROM hr_analytics 
GROUP BY EducationField;

-- Average Monthly Income by Gender
SELECT Gender, AVG(MonthlyIncome) AS Avg_Monthly_Income 
FROM hr_analytics 
GROUP BY Gender;

-- Top 5 Job Roles with Highest Daily Rates
SELECT JobRole, AVG(DailyRate) AS Avg_Daily_Rate 
FROM hr_analytics 
GROUP BY JobRole 
ORDER BY Avg_Daily_Rate 
DESC LIMIT 5;

-- the employee with the highest salary in each department.

SELECT Department, MAX(MonthlyIncome) AS Max_Salary

FROM hr_analytics

GROUP BY Department;

-- the average monthly income and the number of employees for each department.

SELECT Department, AVG(MonthlyIncome) AS Avg_Monthly_Income, COUNT(EmpID) AS Max_Employ

FROM hr_analytics

GROUP BY Department;

-- the top 2 departments with the highest attrition rate.

SELECT Department, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Rate
FROM hr_analytics
GROUP BY department
ORDER BY Attrition_Rate DESC
LIMIT 2;

-- List employees who have been with the company for more than 10 years but have not received a promotion in the last 5 years.

SELECT *
FROM hr_analytics
WHERE yearsatcompany >10 AND yearssincelastpromotion > 5;

-- Calculate the cumulative monthly income for employees in each department.

SELECT Department, SUM(MonthlyIncome) AS Cumulative_Monthly_Income
FROM hr_analytics
GROUP BY Department;

-----------------------------------------------------

SELECT Department, EmpID, MonthlyIncome,
       SUM(MonthlyIncome) OVER (PARTITION BY
       Department ORDER BY EmpID) AS
       Cumulative_Monthly_Income
FROM hr_analytics

--  Find the average number of years employees stay with their current manager for each department

SELECT Department, AVG(YearsWithCurrManager) AS Avg_Years_With_Manager
FROM hr_analytics
GROUP BY Department

-- the top 3 job roles with the highest average performance rating.

WITH avg_performance AS (
    SELECT JobRole, AVG(PerformanceRating) AS Avg_Performance
    FROM hr_analytics
    GROUP BY JobRole
)

SELECT JobRole, Avg_Performance
FROM avg_performance
ORDER BY Avg_Performance DESC
LIMIT 3;

------------------------------------------------------

SELECT JobRole,AVG(PerformanceRating) AS avg_performance
FROM hr_analytics
GROUP BY JobRole
LIMIT 3;

-- the attrition rate for each combination of gender and age group

SELECT Gender, AgeGroup, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Rate

FROM hr_analytics

GROUP BY Gender, AgeGroup

--  employees whose salary is above the average salary of their department.

WITH avg_salary_dept AS (
    SELECT Department, AVG(MonthlyIncome) AS Avg_Salary
    FROM hr_analytics
    GROUP BY Department
)
SELECT h.EmpID, h.Department, h.MonthlyIncome
FROM hr_analytics h
JOIN avg_salary_dept a ON h.Department = a.Department
WHERE h.MonthlyIncome > a.Avg_Salary;

-- List employees who have the same job role as the employee with the highest salary in the company.

WITH highest_salary_dept AS (
    SELECT JobRole
    FROM hr_analytics
    ORDER BY monthlyincome DESC
    LIMIT 1
)

SELECT EmpID, JobRole, MonthlyIncome
FROM hr_analytics
WHERE JobRole in (SELECT JobRole FROM highest_salary_dept);

-- the top 3 departments with the highest average salary, considering only departments with more than 10 employees.

WITH dept_avg_salary AS (
    SELECT Department, AVG(MonthlyIncome) AS Avg_Salary, COUNT(EmpID) AS Employee_Count
    FROM hr_analytics
    GROUP BY Department
)
SELECT Department, Avg_Salary
FROM dept_avg_salary
WHERE Employee_Count > 10
ORDER BY Avg_Salary DESC
LIMIT 3;

-- employees who have a higher salary than the average salary of their job role.

WITH avg_salary_job AS (
    SELECT JobRole, AVG(MonthlyIncome) AS Avg_Salary
    FROM hr_analytics
    GROUP BY JobRole
)

SELECT h.EmpID, h.JobRole, h.MonthlyIncome
FROM hr_analytics h
JOIN avg_salary_job a ON h.JobRole = a.JobRole
WHERE h.MonthlyIncome > a.Avg_Salary;

-- the attrition rate for each department and identify the department with the highest attrition rate.

WITH dept_attrition AS (
    SELECT Department, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Rate
    FROM hr_analytics
    GROUP BY Department
)

SELECT Department, Attrition_Rate
FROM dept_attrition
ORDER BY Attrition_Rate
LIMIT 1;

-- the employees who have been with the company for the longest time and have not received a promotion in the last 5 years.

SELECT EmpID, YearsAtCompany, YearsSinceLastPromotion
FROM hr_analytics
WHERE YearsSinceLastPromotion > 5
ORDER BY YearsAtCompany DESC;


-- the average number of years employees stay with their current manager for each department.

SELECT Department,  AVG(YearsWithCurrManager) AS Avg_Years_With_Manager
FROM hr_analytics
GROUP BY Department;

--the top 3 business travel categories with the highest average job satisfaction scores.

WITH avg_satisfaction AS (
    SELECT BusinessTravel, AVG(JobSatisfaction) AS Avg_Satisfaction
    FROM hr_analytics
    GROUP BY BusinessTravel
)

SELECT BusinessTravel, Avg_Satisfaction
FROM avg_satisfaction
ORDER BY Avg_Satisfaction DESC
LIMIT 3;

-- employees who have never received a promotion and have a high performance rating (4 or 5)

SELECT EmpID, PerformanceRating, YearsSinceLastPromotion
FROM hr_analytics
WHERE YearsSinceLastPromotion = 0 AND PerformanceRating >=4;

-- the percentage of employees in each job role who have left the company.

SELECT JobRole, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 AS Avg_Attrition_Percentage
FROM hr_analytics
GROUP BY JobRole;

-- the top 5 employees with the highest number of years in their current role, along with their job roles.

SELECT EmpID, JobRole, YearsInCurrentRole

FROM hr_analytics

ORDER BY YearsInCurrentRole DESC

LIMIT 5;

-- the correlation between job satisfaction and work-life balance across different departments.

SELECT Department, CORR(JobSatisfaction, WorkLifeBalance) AS Correlation_JobSatisfaction
FROM hr_analytics
GROUP BY Department;