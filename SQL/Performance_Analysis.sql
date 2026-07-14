-- ==========================================================
-- Employee Management System
-- Analytical SQL Queries
-- Section 8: Performance Analysis
-- ==========================================================

USE Employee_Management;

-- ==========================================================
-- Query 1: Display all performance records
-- ==========================================================

SELECT *
FROM Performance;

-- ==========================================================
-- Query 2: Average performance rating
-- ==========================================================

SELECT
    ROUND(AVG(Rating),2) AS AverageRating
FROM Performance;

-- ==========================================================
-- Query 3: Top 10 highest-rated employees
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    p.Rating
FROM Employees e
JOIN Performance p
ON e.EmployeeID = p.EmployeeID
ORDER BY p.Rating DESC
LIMIT 10;

-- ==========================================================
-- Query 4: Department-wise average performance rating
-- ==========================================================

SELECT
    d.DepartmentName,
    ROUND(AVG(p.Rating),2) AS AverageRating
FROM Performance p
JOIN Employees e
ON p.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AverageRating DESC;

-- ==========================================================
-- Query 5: Number of employees in each rating category
-- ==========================================================

SELECT
    Rating,
    COUNT(*) AS EmployeeCount
FROM Performance
GROUP BY Rating
ORDER BY Rating DESC;

-- ==========================================================
-- Query 6: Reviewer-wise performance reviews
-- ==========================================================

SELECT
    ReviewerName,
    COUNT(*) AS TotalReviews
FROM Performance
GROUP BY ReviewerName
ORDER BY TotalReviews DESC;

-- ==========================================================
-- Query 7: Highest-rated employee in each department
-- ==========================================================

WITH RankedEmployees AS
(
    SELECT
        d.DepartmentName,
        CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
        p.Rating,
        ROW_NUMBER() OVER
        (
            PARTITION BY d.DepartmentName
            ORDER BY p.Rating DESC
        ) AS RankNo
    FROM Performance p
    JOIN Employees e
        ON p.EmployeeID = e.EmployeeID
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
)

SELECT
    DepartmentName,
    EmployeeName,
    Rating
FROM RankedEmployees
WHERE RankNo = 1;

-- ==========================================================
-- Query 8: Employees with rating above company average
-- ==========================================================

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
    p.Rating
FROM Employees e
JOIN Performance p
ON e.EmployeeID = p.EmployeeID
WHERE p.Rating >
(
    SELECT AVG(Rating)
    FROM Performance
)
ORDER BY p.Rating DESC;

-- ==========================================================
-- Query 9: Department performance ranking
-- ==========================================================

SELECT
    d.DepartmentName,
    ROUND(AVG(p.Rating),2) AS AverageRating,
    DENSE_RANK() OVER
    (
        ORDER BY AVG(p.Rating) DESC
    ) AS DepartmentRank
FROM Performance p
JOIN Employees e
ON p.EmployeeID = e.EmployeeID
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- ==========================================================
-- Query 10: Rating distribution
-- ==========================================================

SELECT
    CASE
        WHEN Rating >= 4.5 THEN 'Excellent'
        WHEN Rating >= 4.0 THEN 'Very Good'
        WHEN Rating >= 3.0 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS RatingCategory,
    COUNT(*) AS TotalEmployees
FROM Performance
GROUP BY RatingCategory
ORDER BY TotalEmployees DESC;