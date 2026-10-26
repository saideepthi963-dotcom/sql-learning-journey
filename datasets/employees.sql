-- ========================================
-- Dataset: Employees
-- Description: Sample employee data
-- ========================================

-- Create employees table

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary INT
);

-- Insert sample employee records

INSERT INTO employees
(employee_id, employee_name, department, salary)
VALUES
(101, 'Alice', 'IT', 75000),
(102, 'Bob', 'HR', 60000),
(103, 'Charlie', 'Finance', 80000),
(104, 'David', 'IT', 90000),
(105, 'Emma', 'HR', 65000);