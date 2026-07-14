-- ==========================================================
-- Employee Management System
-- Analytical SQL Queries
-- Section 2: Employee Analysis
-- ==========================================================

USE Employee_Management;

-- ==========================================================
-- Query 1: Display all employee records
-- ==========================================================

SELECT *
FROM Employees;

-- ==========================================================
-- Query 2: Total number of employees
-- ==========================================================

SELECT COUNT(*) AS TotalEmployees
FROM Employees;

-- ==========================================================
-- Query 3: Number of male, female, and other employees
-- ==========================================================

SELECT
    Gender,
    COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Gender;

-- ==========================================================
-- Query 4: Average age of employees
-- ==========================================================

SELECT
    ROUND(AVG(TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE())),2) AS AverageAge
FROM Employees;

-- ==========================================================
-- Query 5: Youngest and oldest employee
-- ==========================================================

SELECT
    CONCAT(FirstName,' ',LastName) AS EmployeeName,
    TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) AS Age
FROM Employees
WHERE DateOfBirth =
(
    SELECT MIN(DateOfBirth)
    FROM Employees
)

UNION

SELECT
    CONCAT(FirstName,' ',LastName),
    TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE())
FROM Employees
WHERE DateOfBirth =
(
    SELECT MAX(DateOfBirth)
    FROM Employees
);

-- ==========================================================
-- Query 6: Employees hired in the current year
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS EmployeeName,
    HireDate
FROM Employees
WHERE YEAR(HireDate) = YEAR(CURDATE());

-- ==========================================================
-- Query 7: Employees with more than 5 years of experience
-- ==========================================================

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS EmployeeName,
    TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) AS Experience
FROM Employees
WHERE TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) > 5
ORDER BY Experience DESC;

-- ==========================================================
-- Query 8: Top 10 highest-paid employees
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    MAX(p.NetSalary) AS HighestSalary
FROM Employees e
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName
ORDER BY HighestSalary DESC
LIMIT 10;

-- ==========================================================
-- Query 9: Employees who have not taken any leave
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName
FROM Employees e
LEFT JOIN LeaveRecords l
ON e.EmployeeID = l.EmployeeID
WHERE l.EmployeeID IS NULL;

-- ==========================================================
-- Query 10: Employee count by hiring year
-- ==========================================================

SELECT
    YEAR(HireDate) AS HiringYear,
    COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY YEAR(HireDate)
ORDER BY HiringYear;