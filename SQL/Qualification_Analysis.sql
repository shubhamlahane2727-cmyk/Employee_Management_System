-- ==========================================================
-- Employee Management System
-- Analytical SQL Queries
-- Section 4: Qualification Analysis
-- ==========================================================

USE Employee_Management;

-- ==========================================================
-- Query 1: Display all qualification records
-- ==========================================================

SELECT *
FROM Qualifications;

-- ==========================================================
-- Query 2: Total number of qualification records
-- ==========================================================

SELECT COUNT(*) AS TotalQualifications
FROM Qualifications;

-- ==========================================================
-- Query 3: Employees with each degree
-- ==========================================================

SELECT
    Degree,
    COUNT(EmployeeID) AS TotalEmployees
FROM Qualifications
GROUP BY Degree
ORDER BY TotalEmployees DESC;

-- ==========================================================
-- Query 4: Employees with each specialization
-- ==========================================================

SELECT
    Specialization,
    COUNT(EmployeeID) AS TotalEmployees
FROM Qualifications
GROUP BY Specialization
ORDER BY TotalEmployees DESC;

-- ==========================================================
-- Query 5: Top 5 universities by employee count
-- ==========================================================

SELECT
    University,
    COUNT(EmployeeID) AS TotalEmployees
FROM Qualifications
GROUP BY University
ORDER BY TotalEmployees DESC
LIMIT 5;

-- ==========================================================
-- Query 6: Average CGPA by degree
-- ==========================================================

SELECT
    Degree,
    ROUND(AVG(CGPA),2) AS AverageCGPA
FROM Qualifications
GROUP BY Degree
ORDER BY AverageCGPA DESC;

-- ==========================================================
-- Query 7: Employees with certifications
-- ==========================================================

SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    q.Certification
FROM Employees e
JOIN Qualifications q
ON e.EmployeeID = q.EmployeeID
WHERE q.Certification IS NOT NULL
AND q.Certification <> '';

-- ==========================================================
-- Query 8: Number of employees by certification
-- ==========================================================

SELECT
    Certification,
    COUNT(EmployeeID) AS TotalEmployees
FROM Qualifications
WHERE Certification IS NOT NULL
AND Certification <> ''
GROUP BY Certification
ORDER BY TotalEmployees DESC;

-- ==========================================================
-- Query 9: Highest CGPA holders
-- ==========================================================

SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    q.Degree,
    q.CGPA
FROM Employees e
JOIN Qualifications q
ON e.EmployeeID = q.EmployeeID
ORDER BY q.CGPA DESC
LIMIT 10;

-- ==========================================================
-- Query 10: Graduation year-wise employee count
-- ==========================================================

SELECT
    GraduationYear,
    COUNT(EmployeeID) AS TotalEmployees
FROM Qualifications
GROUP BY GraduationYear
ORDER BY GraduationYear;