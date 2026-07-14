-- ==========================================================
-- Employee Management System
-- Analytical SQL Queries
-- Section 6: Leave Analysis
-- ==========================================================

USE Employee_Management;

-- ==========================================================
-- Query 1: Display all leave records
-- ==========================================================

SELECT *
FROM LeaveRecords;

-- ==========================================================
-- Query 2: Total leave records
-- ==========================================================

SELECT COUNT(*) AS TotalLeaveRecords
FROM LeaveRecords;

-- ==========================================================
-- Query 3: Leave requests by leave type
-- ==========================================================

SELECT
    LeaveType,
    COUNT(*) AS TotalRequests
FROM LeaveRecords
GROUP BY LeaveType
ORDER BY TotalRequests DESC;

-- ==========================================================
-- Query 4: Leave status distribution
-- ==========================================================

SELECT
    Status,
    COUNT(*) AS TotalRequests
FROM LeaveRecords
GROUP BY Status
ORDER BY TotalRequests DESC;

-- ==========================================================
-- Query 5: Employees who have taken the most leave days
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    SUM(l.TotalDays) AS TotalLeaveDays
FROM Employees e
JOIN LeaveRecords l
ON e.EmployeeID = l.EmployeeID
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName
ORDER BY TotalLeaveDays DESC
LIMIT 10;

-- ==========================================================
-- Query 6: Department-wise total leave days
-- ==========================================================

SELECT
    d.DepartmentName,
    SUM(l.TotalDays) AS TotalLeaveDays
FROM LeaveRecords l
JOIN Employees e
ON l.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalLeaveDays DESC;

-- ==========================================================
-- Query 7: Average leave days per employee
-- ==========================================================

SELECT
    ROUND(AVG(TotalDays),2) AS AverageLeaveDays
FROM LeaveRecords;

-- ==========================================================
-- Query 8: Monthly leave trend
-- ==========================================================

SELECT
    YEAR(StartDate) AS Year,
    MONTHNAME(StartDate) AS Month,
    COUNT(*) AS TotalLeaves
FROM LeaveRecords
GROUP BY
    YEAR(StartDate),
    MONTH(StartDate),
    MONTHNAME(StartDate)
ORDER BY
    Year,
    MONTH(StartDate);

-- ==========================================================
-- Query 9: Employees with approved leave requests
-- ==========================================================

SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    COUNT(*) AS ApprovedLeaves
FROM Employees e
JOIN LeaveRecords l
ON e.EmployeeID = l.EmployeeID
WHERE l.Status = 'Approved'
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName
ORDER BY ApprovedLeaves DESC;

-- ==========================================================
-- Query 10: Approval rate by leave type
-- ==========================================================

SELECT
    LeaveType,
    ROUND(
        SUM(CASE WHEN Status = 'Approved' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS ApprovalRate
FROM LeaveRecords
GROUP BY LeaveType
ORDER BY ApprovalRate DESC;