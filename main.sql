-- Create a table to store school information
CREATE TABLE School (
    SchoolID INT PRIMARY KEY,
    SchoolName VARCHAR(100),
    Major VARCHAR(100),
    CreditFee DECIMAL(10, 2)
);

-- Insert some sample school data
INSERT INTO School (SchoolID, SchoolName, Major, CreditFee)
VALUES 
    (1, 'University of XYZ', 'Computer Science', 1000),
    (2, 'ABC College', 'Biology', 1200),
    (3, 'DEF University', 'Engineering', 1500);

-- Create a table to store student information
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Major VARCHAR(100),
    Credits INT,
    Tuition DECIMAL(10, 2),
    Bill DECIMAL(10, 2)
);

-- Generate random student data and calculate tuition
INSERT INTO Student (StudentID, FirstName, LastName, Major, Credits, Tuition, Bill)
SELECT 
    ROW_NUMBER() OVER (ORDER BY rand()) AS StudentID,
    CONCAT('Student', ROW_NUMBER() OVER (ORDER BY rand())) AS FirstName,
    CONCAT('Lastname', ROW_NUMBER() OVER (ORDER BY rand())) AS LastName,
    School.Major,
    FLOOR(RAND() * 14) + 8 AS Credits,
    (FLOOR(RAND() * 14) + 8) * School.CreditFee AS Tuition,
    ((FLOOR(RAND() * 14) + 8) * School.CreditFee) + 
        CASE 
            WHEN School.Major = 'Computer Science' THEN 500
            WHEN School.Major = 'Biology' THEN 600
            WHEN School.Major = 'Engineering' THEN 700
            ELSE 0
        END AS Bill
FROM
    School
ORDER BY
    StudentID;

-- Query the student data sheet
SELECT
    StudentID,
    FirstName,
    LastName,
    Major,
    Credits,
    Tuition,
    Bill
FROM
    Student;