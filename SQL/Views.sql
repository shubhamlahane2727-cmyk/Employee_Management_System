-- ==========================================================
-- Employee Management System
-- View 1: Employee Details
-- ==========================================================

USE Employee_Management;

CREATE VIEW Employee_Details_View AS

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    e.Gender,
    e.Email,
    e.PhoneNumber,
    e.HireDate,
    d.DepartmentName,
    j.JobTitle
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID
LEFT JOIN JobRoles j
ON e.JobID = j.JobID;


SELECT * FROM Employee_Details_View;


-- ==========================================================
-- Employee Management System
-- View 2: Department Summary
-- ==========================================================

USE Employee_Management;

CREATE VIEW Department_Summary_View AS

SELECT
    d.DepartmentID,
    d.DepartmentName,
    COUNT(e.EmployeeID) AS TotalEmployees,
    ROUND(AVG(p.NetSalary),2) AS AverageSalary
FROM Departments d
LEFT JOIN Employees e
ON d.DepartmentID = e.DepartmentID
LEFT JOIN Payroll p
ON e.EmployeeID = p.EmployeeID
GROUP BY
    d.DepartmentID,
    d.DepartmentName;
    
    
    SELECT * FROM Department_Summary_View;
    
    
-- ==========================================================
-- Employee Management System
-- View 3: Payroll Summary
-- ==========================================================

USE Employee_Management;

CREATE VIEW Payroll_Summary_View AS

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    p.BasicSalary,
    p.Bonus,
    p.Deductions,
    p.NetSalary
FROM Payroll p
JOIN Employees e
ON p.EmployeeID = e.EmployeeID;


SELECT * FROM Payroll_Summary_View;


-- ==========================================================
-- Employee Management System
-- View 4: Attendance Summary
-- ==========================================================

USE Employee_Management;

CREATE VIEW Attendance_Summary_View AS

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    COUNT(a.AttendanceID) AS TotalRecords,
    SUM(CASE WHEN a.Status='Present' THEN 1 ELSE 0 END) AS PresentDays,
    SUM(CASE WHEN a.Status='Absent' THEN 1 ELSE 0 END) AS AbsentDays,
    SUM(CASE WHEN a.Status='Leave' THEN 1 ELSE 0 END) AS LeaveDays,
    SUM(CASE WHEN a.Status='Work From Home' THEN 1 ELSE 0 END) AS WFHDays
FROM Employees e
LEFT JOIN Attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName;
    
    
SELECT * FROM Attendance_Summary_View;


-- ==========================================================
-- Employee Management System
-- View 5: Performance Summary
-- ==========================================================

USE Employee_Management;

CREATE VIEW Performance_Summary_View AS

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    d.DepartmentName,
    p.Rating,
    p.ReviewerName
FROM Performance p
JOIN Employees e
ON p.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID;


SELECT * FROM Performance_Summary_View;