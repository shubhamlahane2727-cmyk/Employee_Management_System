-- ==========================================================
-- Employee Management System
-- Analytical SQL Queries
-- Section 5: Attendance Analysis
-- ==========================================================

USE Employee_Management;

-- ==========================================================
-- Query 1: Display all attendance records
-- ==========================================================

SELECT *
FROM Attendance;

-- ==========================================================
-- Query 2: Total attendance records
-- ==========================================================

SELECT COUNT(*) AS TotalAttendanceRecords
FROM Attendance;

-- ==========================================================
-- Query 3: Attendance status distribution
-- ==========================================================

SELECT
    Status,
    COUNT(*) AS TotalRecords
FROM Attendance
GROUP BY Status
ORDER BY TotalRecords DESC;

-- ==========================================================
-- Query 4: Employee with the highest attendance
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    COUNT(a.AttendanceID) AS PresentDays
FROM Employees e
JOIN Attendance a
ON e.EmployeeID = a.EmployeeID
WHERE a.Status = 'Present'
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName
ORDER BY PresentDays DESC
LIMIT 10;

-- ==========================================================
-- Query 5: Employees with the highest absence
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    COUNT(a.AttendanceID) AS AbsentDays
FROM Employees e
JOIN Attendance a
ON e.EmployeeID = a.EmployeeID
WHERE a.Status = 'Absent'
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName
ORDER BY AbsentDays DESC
LIMIT 10;

-- ==========================================================
-- Query 6: Work From Home count by department
-- ==========================================================

SELECT
    d.DepartmentName,
    COUNT(*) AS WFHDays
FROM Attendance a
JOIN Employees e
ON a.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE a.Status = 'Work From Home'
GROUP BY d.DepartmentName
ORDER BY WFHDays DESC;

-- ==========================================================
-- Query 7: Department-wise Attendance Percentage
-- ==========================================================

SELECT
    d.DepartmentName,
    ROUND(
        SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS AttendancePercentage
FROM Attendance a
JOIN Employees e
ON a.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AttendancePercentage DESC;

-- ==========================================================
-- Query 8: Average working hours by department
-- ==========================================================

SELECT
    d.DepartmentName,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                a.CheckIn,
                a.CheckOut
            ) / 60
        ),
        2
    ) AS AvgWorkingHours
FROM Attendance a
JOIN Employees e
ON a.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE a.CheckIn IS NOT NULL
AND a.CheckOut IS NOT NULL
GROUP BY d.DepartmentName
ORDER BY AvgWorkingHours DESC;

-- ==========================================================
-- Query 9: Monthly attendance records
-- ==========================================================

SELECT
    MONTHNAME(AttendanceDate) AS Month,
    COUNT(*) AS TotalAttendance
FROM Attendance
GROUP BY MONTH(AttendanceDate), MONTHNAME(AttendanceDate)
ORDER BY MONTH(AttendanceDate);

-- ==========================================================
-- Query 10: Attendance percentage by employee
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    ROUND(
        SUM(CASE WHEN a.Status='Present' THEN 1 ELSE 0 END)
        *100.0/
        COUNT(*),
        2
    ) AS AttendancePercentage
FROM Employees e
JOIN Attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName
ORDER BY AttendancePercentage DESC;