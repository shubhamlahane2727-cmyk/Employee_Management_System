-- ==========================================================
-- Employee Management System
-- Index 1: Employee Email
-- ==========================================================

USE Employee_Management;

CREATE INDEX Employee_Email_IDX
ON Employees(Email);


SHOW INDEX FROM Employees;


-- ==========================================================
-- Employee Management System
-- Index 2: DepartmentID
-- ==========================================================

USE Employee_Management;

CREATE INDEX Employee_Department_IDX
ON Employees(DepartmentID);


SHOW INDEX
FROM Employees
WHERE Key_name = 'Employee_Department_IDX';


-- ==========================================================
-- Employee Management System
-- Index 3: JobID
-- ==========================================================

USE Employee_Management;

CREATE INDEX Employee_Job_IDX
ON Employees(JobID);


SHOW INDEX
FROM Employees
WHERE Key_name = 'Employee_Job_IDX';

-- ==========================================================
-- Employee Management System
-- Index 4: Attendance Date
-- ==========================================================

USE Employee_Management;

CREATE INDEX Attendance_Date_IDX
ON Attendance(AttendanceDate);


SHOW INDEX FROM Attendance;



-- ==========================================================
-- Employee Management System
-- Index 5: Payroll Month
-- ==========================================================

USE Employee_Management;

CREATE INDEX Payroll_Month_IDX
ON Payroll(PayMonth);


SHOW INDEX FROM Payroll;