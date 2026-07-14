-- ==========================================================
-- Employee Management System
-- Trigger 1: Payroll_Before_Insert
-- ==========================================================

USE Employee_Management;

DROP TRIGGER IF EXISTS trg_Payroll_Before_Insert;

DELIMITER $$

CREATE TRIGGER trg_Payroll_Before_Insert
BEFORE INSERT ON Payroll
FOR EACH ROW
BEGIN

    IF NEW.BasicSalary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Basic Salary cannot be negative';
    END IF;

    SET NEW.NetSalary =
        NEW.BasicSalary + NEW.Bonus - NEW.Deductions;

END $$

DELIMITER ;


INSERT INTO Payroll
(EmployeeID, PayMonth, BasicSalary, Bonus, Deductions)
VALUES
(1,'2025-02-01',50000,5000,3000);


SELECT *
FROM Payroll
ORDER BY PayrollID DESC
LIMIT 1;


INSERT INTO Payroll
(EmployeeID, PayMonth, BasicSalary, Bonus, Deductions)
VALUES
(1,'2025-02-01',-50000,5000,3000);


-- ==========================================================
-- Employee Management System
-- Trigger 2: Validate Leave Dates
-- ==========================================================

USE Employee_Management;

DROP TRIGGER IF EXISTS trg_ValidateLeaveDates;

DELIMITER $$

CREATE TRIGGER trg_ValidateLeaveDates
BEFORE INSERT ON LeaveRecords
FOR EACH ROW
BEGIN

    IF NEW.EndDate < NEW.StartDate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='End Date cannot be earlier than Start Date';
    END IF;

END $$

DELIMITER ;


INSERT INTO LeaveRecords
(EmployeeID, LeaveType, StartDate, EndDate, TotalDays, Status)
VALUES
(1,'Annual Leave','2025-05-20','2025-05-15',5,'Approved');

