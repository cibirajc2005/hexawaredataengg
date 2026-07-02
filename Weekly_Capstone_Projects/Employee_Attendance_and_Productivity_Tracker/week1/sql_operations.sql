CREATE DATABASE IF NOT EXISTS attendance_tracker;
USE attendance_tracker;

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    designation VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    date_joined DATE
);

CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    clock_in DATETIME,
    clock_out DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    task_date DATE NOT NULL,
    task_name VARCHAR(100),
    tasks_completed INT DEFAULT 0,
    priority VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO employees (first_name, last_name, department, designation, email, date_joined)
VALUES
('Arun', 'Kumar', 'Engineering', 'Software Engineer', 'arun.kumar@company.com', '2023-01-15'),
('Divya', 'Raj', 'HR', 'HR Executive', 'divya.raj@company.com', '2022-06-10'),
('Karthik', 'Suresh', 'Sales', 'Sales Associate', 'karthik.suresh@company.com', '2023-03-20');

INSERT INTO attendance (employee_id, attendance_date, clock_in, clock_out, status)
VALUES
(1, '2026-06-01', '2026-06-01 09:05:00', '2026-06-01 18:10:00', 'Present'),
(2, '2026-06-01', '2026-06-01 09:20:00', '2026-06-01 17:50:00', 'Present'),
(3, '2026-06-01', NULL, NULL, 'Absent');

INSERT INTO tasks (employee_id, task_date, task_name, tasks_completed, priority)
VALUES
(1, '2026-06-01', 'API Development', 5, 'High'),
(2, '2026-06-01', 'Recruitment Drive', 3, 'Medium'),
(3, '2026-06-01', 'Client Follow-up', 0, 'Low');

SELECT * FROM employees;

SELECT * FROM attendance WHERE attendance_date = '2026-06-01';

UPDATE attendance
SET clock_out = '2026-06-01 18:30:00'
WHERE employee_id = 1 AND attendance_date = '2026-06-01';

DELETE FROM tasks
WHERE task_id = 3 AND tasks_completed = 0;

DELIMITER //

CREATE PROCEDURE GetTotalWorkingHours(IN emp_id INT)
BEGIN
    SELECT
        employee_id,
        SUM(TIMESTAMPDIFF(MINUTE, clock_in, clock_out)) / 60 AS total_working_hours
    FROM attendance
    WHERE employee_id = emp_id
      AND clock_in IS NOT NULL
      AND clock_out IS NOT NULL
    GROUP BY employee_id;
END //

DELIMITER ;

CALL GetTotalWorkingHours(1);

CREATE INDEX idx_employee_id ON attendance(employee_id);
CREATE INDEX idx_department ON employees(department);
CREATE INDEX idx_task_employee_id ON tasks(employee_id);
