-- ==========================================================
-- Employee Management System
-- Function 1: Calculate Employee Age
-- ==========================================================

USE Employee_Management;

DROP FUNCTION IF EXISTS CalculateAge;

DELIMITER $$

CREATE FUNCTION CalculateAge(DOB DATE)
RETURNS INT
DETERMINISTIC

BEGIN

    DECLARE Age INT;

    SET Age = TIMESTAMPDIFF(YEAR, DOB, CURDATE());

    RETURN Age;

END $$

DELIMITER ;


SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS EmployeeName,
    CalculateAge(DateOfBirth) AS Age
FROM Employees;


-- ==========================================================
-- Employee Management System
-- Function 2: Calculate Annual Salary
-- ==========================================================

USE Employee_Management;

DROP FUNCTION IF EXISTS CalculateAnnualSalary;

DELIMITER $$

CREATE FUNCTION CalculateAnnualSalary(NetSalary DECIMAL(10,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC

BEGIN

    RETURN NetSalary * 12;

END $$

DELIMITER ;


SELECT
    EmployeeID,
    NetSalary,
    CalculateAnnualSalary(NetSalary) AS AnnualSalary
FROM Payroll;


-- ==========================================================
-- Employee Management System
-- Function 3: Employee Experience
-- ==========================================================

USE Employee_Management;

DROP FUNCTION IF EXISTS EmployeeExperience;

DELIMITER $$

CREATE FUNCTION EmployeeExperience(Hire_Date DATE)
RETURNS INT
DETERMINISTIC

BEGIN

    RETURN TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE());

END $$

DELIMITER ;


SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS EmployeeName,
    EmployeeExperience(HireDate) AS ExperienceYears
FROM Employees;