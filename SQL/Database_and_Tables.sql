-- Create Database
CREATE DATABASE Employee_Management;

-- Use Database
USE Employee_Management;

-- Table 1: Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100),
    ManagerName VARCHAR(100)
);

-- Table 2: JobRoles
CREATE TABLE JobRoles (
    JobID INT PRIMARY KEY AUTO_INCREMENT,
    JobTitle VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Description TEXT,
    MinSalary DECIMAL(10,2),
    MaxSalary DECIMAL(10,2),

    CONSTRAINT fk_job_department
    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- Table 3: Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    DateOfBirth DATE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE NOT NULL,
    HireDate DATE NOT NULL,
    DepartmentID INT,
    JobID INT,
    
    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
    
    FOREIGN KEY (JobID)
    REFERENCES JobRoles(JobID)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

-- Table 4: Qualifications
CREATE TABLE Qualifications (
    QualificationID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    Degree VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    University VARCHAR(150),
    GraduationYear YEAR,
    CGPA DECIMAL(3,2),
    Certification VARCHAR(150),

    FOREIGN KEY (EmployeeID)
    REFERENCES Employees(EmployeeID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Table 5: Attendance
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    AttendanceDate DATE NOT NULL,
    Status ENUM('Present', 'Absent', 'Leave', 'Work From Home') NOT NULL,
    CheckIn TIME,
    CheckOut TIME,

    FOREIGN KEY (EmployeeID)
    REFERENCES Employees(EmployeeID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Table 6: LeaveRecords
CREATE TABLE LeaveRecords (
    LeaveID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    LeaveType ENUM('Sick Leave','Casual Leave','Annual Leave','Maternity Leave','Paternity Leave','Unpaid Leave') NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalDays INT NOT NULL,
    Reason VARCHAR(255),
    Status ENUM('Pending','Approved','Rejected') DEFAULT 'Pending',

    FOREIGN KEY (EmployeeID)
    REFERENCES Employees(EmployeeID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Table 7: Payroll
CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    PayMonth DATE NOT NULL,
    BasicSalary DECIMAL(10,2) NOT NULL,
    Bonus DECIMAL(10,2) DEFAULT 0,
    Deductions DECIMAL(10,2) DEFAULT 0,
    NetSalary DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (EmployeeID)
    REFERENCES Employees(EmployeeID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Table 8: Performance
CREATE TABLE Performance (
    PerformanceID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    ReviewDate DATE NOT NULL,
    Rating DECIMAL(2,1) NOT NULL CHECK (Rating BETWEEN 1.0 AND 5.0),
    ReviewerName VARCHAR(100),
    Comments VARCHAR(255),

    FOREIGN KEY (EmployeeID)
    REFERENCES Employees(EmployeeID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- ==========================================================
-- Database Creation Completed Successfully
-- Total Tables: 8
-- Created By: Shubham Lahane
-- ==========================================================









