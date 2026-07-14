-- ==========================================================
-- Employee Management System
-- Analytical SQL Queries
-- Section 7: Payroll Analysis
-- ==========================================================

USE Employee_Management;

-- ==========================================================
-- Query 1: Display all payroll records
-- ==========================================================

SELECT *
FROM Payroll;

-- ==========================================================
-- Query 2: Total Monthly Payroll Expenditure
-- ==========================================================

SELECT
    YEAR(PayMonth) AS Year,
    MONTHNAME(PayMonth) AS Month,
    SUM(NetSalary) AS TotalPayroll
FROM Payroll
GROUP BY
    YEAR(PayMonth),
    MONTH(PayMonth),
    MONTHNAME(PayMonth)
ORDER BY
    YEAR(PayMonth),
    MONTH(PayMonth);

-- ==========================================================
-- Query 3: Average Net Salary
-- ==========================================================

SELECT
    ROUND(AVG(NetSalary),2) AS AverageNetSalary
FROM Payroll;

-- ==========================================================
-- Query 4: Top 10 Highest Paid Employees
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    p.NetSalary
FROM Employees e
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
ORDER BY p.NetSalary DESC
LIMIT 10;

-- ==========================================================
-- Query 5: Department-wise Payroll Expenditure
-- ==========================================================

SELECT
    d.DepartmentName,
    SUM(p.NetSalary) AS TotalPayroll
FROM Payroll p
JOIN Employees e
ON p.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalPayroll DESC;

-- ==========================================================
-- Query 6: Department-wise Average Net Salary
-- ==========================================================

SELECT
    d.DepartmentName,
    ROUND(AVG(p.NetSalary),2) AS AverageSalary
FROM Payroll p
JOIN Employees e
ON p.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AverageSalary DESC;

-- ==========================================================
-- Query 7: Bonus Distribution by Department
-- ==========================================================

SELECT
    d.DepartmentName,
    SUM(p.Bonus) AS TotalBonus
FROM Payroll p
JOIN Employees e
ON p.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalBonus DESC;

-- ==========================================================
-- Query 8: Employees with the Highest Deductions
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    p.Deductions
FROM Employees e
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
ORDER BY p.Deductions DESC
LIMIT 10;

-- ==========================================================
-- Query 9: Net Salary Ranking
-- ==========================================================

SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    p.NetSalary,
    DENSE_RANK() OVER(ORDER BY p.NetSalary DESC) AS SalaryRank
FROM Employees e
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID;

-- ==========================================================
-- Query 10: Average Bonus by Job Role
-- ==========================================================

SELECT
    j.JobTitle,
    ROUND(AVG(p.Bonus),2) AS AverageBonus
FROM Payroll p
JOIN Employees e
ON p.EmployeeID = e.EmployeeID
JOIN JobRoles j
ON e.JobID = j.JobID
GROUP BY j.JobTitle
ORDER BY AverageBonus DESC;