-- ==========================================================
-- Employee Management System
-- Analytical SQL Queries
-- Section 1: Department Analysis
-- ==========================================================

USE Employee_Management;

-- ==========================================================
-- Query 1: Display all departments
-- ==========================================================

SELECT *
FROM Departments;

-- ==========================================================
-- Query 2: Total number of departments
-- ==========================================================

SELECT COUNT(*) AS TotalDepartments
FROM Departments;

-- ==========================================================
-- Query 3: List all department names alphabetically
-- ==========================================================

SELECT DepartmentName
FROM Departments
ORDER BY DepartmentName ASC;

-- ==========================================================
-- Query 4: Number of employees in each department
-- ==========================================================

SELECT
    d.DepartmentName,
    COUNT(e.EmployeeID) AS TotalEmployees
FROM Departments d
LEFT JOIN Employees e
ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalEmployees DESC;

-- ==========================================================
-- Query 5: Department having the highest number of employees
-- ==========================================================

SELECT
    d.DepartmentName,
    COUNT(e.EmployeeID) AS TotalEmployees
FROM Departments d
JOIN Employees e
ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalEmployees DESC
LIMIT 1;

-- ==========================================================
-- Query 6: Department having the lowest number of employees
-- ==========================================================

SELECT
    d.DepartmentName,
    COUNT(e.EmployeeID) AS TotalEmployees
FROM Departments d
LEFT JOIN Employees e
ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalEmployees ASC
LIMIT 1;

-- ==========================================================
-- Query 7: Average salary by department
-- ==========================================================

SELECT
    d.DepartmentName,
    ROUND(AVG(p.BasicSalary),2) AS AverageSalary
FROM Departments d
JOIN Employees e
ON d.DepartmentID = e.DepartmentID
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
GROUP BY d.DepartmentName
ORDER BY AverageSalary DESC;

-- ==========================================================
-- Query 8: Total payroll expenditure by department
-- ==========================================================

SELECT
    d.DepartmentName,
    SUM(p.NetSalary) AS TotalPayroll
FROM Departments d
JOIN Employees e
ON d.DepartmentID = e.DepartmentID
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
GROUP BY d.DepartmentName
ORDER BY TotalPayroll DESC;

-- ==========================================================
-- Query 9: Highest paid employee in each department
-- ==========================================================

SELECT
    d.DepartmentName,
    MAX(p.NetSalary) AS HighestSalary
FROM Departments d
JOIN Employees e
ON d.DepartmentID = e.DepartmentID
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
GROUP BY d.DepartmentName;

-- ==========================================================
-- Query 10: Average employee age by department
-- ==========================================================

SELECT
    d.DepartmentName,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, e.DateOfBirth, CURDATE())),1) AS AverageAge
FROM Departments d
JOIN Employees e
ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AverageAge DESC;