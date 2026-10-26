-- Get employees from the IT department
SELECT *
FROM employees
WHERE department = 'IT';

-- Get employees earning more than 70000
SELECT *
FROM employees
WHERE salary > 70000;

-- Get employees earning exactly 60000
SELECT *
FROM employees
WHERE salary = 60000;