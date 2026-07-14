-- ==========================================================
-- Employee Management System
-- Stored Procedure 1: Get Employee Details
-- ==========================================================

USE Employee_Management;

DROP PROCEDURE IF EXISTS GetEmployeeDetails;

DELIMITER $$

CREATE PROCEDURE GetEmployeeDetails(IN EmpID INT)
BEGIN

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    e.Gender,
    e.Email,
    e.PhoneNumber,
    d.DepartmentName,
    j.JobTitle
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID
LEFT JOIN JobRoles j
ON e.JobID = j.JobID
WHERE e.EmployeeID = EmpID;

END $$

DELIMITER ;


CALL GetEmployeeDetails(1);


-- ==========================================================
-- Employee Management System
-- Stored Procedure 2: Department Employees
-- ==========================================================

USE Employee_Management;

DROP PROCEDURE IF EXISTS GetDepartmentEmployees;

DELIMITER $$

CREATE PROCEDURE GetDepartmentEmployees(IN DeptID INT)
BEGIN

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS EmployeeName,
    Email
FROM Employees
WHERE DepartmentID = DeptID;

END $$

DELIMITER ;


CALL GetDepartmentEmployees(3);


-- ==========================================================
-- Employee Management System
-- Stored Procedure 3: Employee Payroll
-- ==========================================================

USE Employee_Management;

DROP PROCEDURE IF EXISTS GetEmployeePayroll;

DELIMITER $$

CREATE PROCEDURE GetEmployeePayroll(IN EmpID INT)
BEGIN

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    p.BasicSalary,
    p.Bonus,
    p.Deductions,
    p.NetSalary
FROM Employees e
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
WHERE e.EmployeeID = EmpID;

END $$

DELIMITER ;


CALL GetEmployeePayroll(5);


-- ==========================================================
-- Employee Management System
-- Stored Procedure 4: Top Performers
-- ==========================================================

USE Employee_Management;

DROP PROCEDURE IF EXISTS GetTopPerformers;

DELIMITER $$

CREATE PROCEDURE GetTopPerformers()
BEGIN

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    p.Rating
FROM Employees e
JOIN Performance p
ON e.EmployeeID = p.EmployeeID
ORDER BY p.Rating DESC
LIMIT 10;

END $$

DELIMITER ;


CALL GetTopPerformers();


-- ==========================================================
-- Employee Management System
-- Stored Procedure 5: Department Salary Summary
-- ==========================================================

USE Employee_Management;

DROP PROCEDURE IF EXISTS GetDepartmentSalarySummary;

DELIMITER $$

CREATE PROCEDURE GetDepartmentSalarySummary()
BEGIN

SELECT
    d.DepartmentName,
    COUNT(e.EmployeeID) AS Employees,
    ROUND(AVG(p.NetSalary),2) AS AverageSalary,
    SUM(p.NetSalary) AS TotalSalary
FROM Departments d
JOIN Employees e
ON d.DepartmentID = e.DepartmentID
JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
GROUP BY
    d.DepartmentName
ORDER BY
    TotalSalary DESC;

END $$

DELIMITER ;


CALL GetDepartmentSalarySummary();