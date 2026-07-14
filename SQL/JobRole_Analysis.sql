-- ==========================================================
-- Employee Management System
-- Analytical SQL Queries
-- Section 3: Job Role Analysis
-- ==========================================================

USE Employee_Management;

-- ==========================================================
-- Query 1: Display all job roles
-- ==========================================================

SELECT *
FROM JobRoles;

-- ==========================================================
-- Query 2: Total number of job roles
-- ==========================================================

SELECT COUNT(*) AS TotalJobRoles
FROM JobRoles;

-- ==========================================================
-- Query 3: Number of employees in each job role
-- ==========================================================

SELECT
    j.JobTitle,
    COUNT(e.EmployeeID) AS TotalEmployees
FROM JobRoles j
LEFT JOIN Employees e
ON j.JobID = e.JobID
GROUP BY j.JobTitle
ORDER BY TotalEmployees DESC;

-- ==========================================================
-- Query 4: Average salary for each job role
-- ==========================================================

SELECT
    j.JobTitle,
    ROUND(AVG(p.BasicSalary),2) AS AverageSalary
FROM JobRoles j
JOIN Employees e
ON j.JobID = e.JobID
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
GROUP BY j.JobTitle
ORDER BY AverageSalary DESC;

-- ==========================================================
-- Query 5: Highest paid job role
-- ==========================================================

SELECT
    JobTitle,
    MaxSalary
FROM JobRoles
ORDER BY MaxSalary DESC
LIMIT 1;

-- ==========================================================
-- Query 6: Lowest paid job role
-- ==========================================================

SELECT
    JobTitle,
    MinSalary
FROM JobRoles
ORDER BY MinSalary ASC
LIMIT 1;

-- ==========================================================
-- Query 7: Employees working in each department and job role
-- ==========================================================

SELECT
    d.DepartmentName,
    j.JobTitle,
    COUNT(e.EmployeeID) AS TotalEmployees
FROM Departments d
JOIN JobRoles j
ON d.DepartmentID = j.DepartmentID
LEFT JOIN Employees e
ON j.JobID = e.JobID
GROUP BY
    d.DepartmentName,
    j.JobTitle
ORDER BY
    d.DepartmentName,
    TotalEmployees DESC;

-- ==========================================================
-- Query 8: Top 5 highest-paying job roles
-- ==========================================================

SELECT
    JobTitle,
    MaxSalary
FROM JobRoles
ORDER BY MaxSalary DESC
LIMIT 5;

-- ==========================================================
-- Query 9: Salary range for every job role
-- ==========================================================

SELECT
    JobTitle,
    CONCAT('₹', FORMAT(MinSalary,0),
           ' - ₹',
           FORMAT(MaxSalary,0)) AS SalaryRange
FROM JobRoles
ORDER BY MinSalary;

-- ==========================================================
-- Query 10: Rank job roles based on maximum salary
-- ==========================================================

SELECT
    JobTitle,
    MaxSalary,
    RANK() OVER(ORDER BY MaxSalary DESC) AS SalaryRank
FROM JobRoles;