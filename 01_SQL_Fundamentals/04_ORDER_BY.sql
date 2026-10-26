

-- ============================================================
-- 1. INTRODUCTION TO ORDER BY
-- ============================================================

-- ORDER BY is used to sort query results.
-- ASC  = Ascending order (smallest to largest, A to Z)
-- DESC = Descending order (largest to smallest, Z to A)
-- Default sorting direction is ASC.


-- ============================================================
-- 2. ORDER BY ASCENDING
-- ============================================================

-- Sort employees by salary from lowest to highest
SELECT *
FROM employees
ORDER BY salary ASC;

-- Sort employees by name alphabetically
SELECT *
FROM employees
ORDER BY employee_name ASC;

-- Sort employees by employee ID
SELECT *
FROM employees
ORDER BY employee_id ASC;


-- ============================================================
-- 3. ORDER BY DESCENDING
-- ============================================================

-- Sort employees by salary from highest to lowest
SELECT *
FROM employees
ORDER BY salary DESC;

-- Sort employees by name in reverse alphabetical order
SELECT *
FROM employees
ORDER BY employee_name DESC;

-- Sort employees by employee ID in descending order
SELECT *
FROM employees
ORDER BY employee_id DESC;


-- ============================================================
-- 4. ORDER BY WITHOUT ASC OR DESC
-- ============================================================

-- ASC is the default sorting direction
SELECT *
FROM employees
ORDER BY salary;

-- Equivalent to:
SELECT *
FROM employees
ORDER BY salary ASC;


-- ============================================================
-- 5. ORDER BY MULTIPLE COLUMNS
-- ============================================================

-- Sort by department alphabetically,
-- then by salary from highest to lowest
SELECT *
FROM employees
ORDER BY department ASC, salary DESC;

-- Sort by department and employee name
SELECT *
FROM employees
ORDER BY department ASC, employee_name ASC;

-- Sort by salary descending,
-- then employee name ascending
SELECT *
FROM employees
ORDER BY salary DESC, employee_name ASC;


-- ============================================================
-- 6. ORDER BY WITH WHERE
-- ============================================================

-- Find IT employees sorted by highest salary
SELECT *
FROM employees
WHERE department = 'IT'
ORDER BY salary DESC;

-- Find employees earning above 60000,
-- sorted by salary from lowest to highest
SELECT *
FROM employees
WHERE salary > 60000
ORDER BY salary ASC;

-- Find HR and Finance employees,
-- sorted alphabetically by name
SELECT *
FROM employees
WHERE department IN ('HR', 'Finance')
ORDER BY employee_name ASC;


-- ============================================================
-- 7. ORDER BY WITH SELECTED COLUMNS
-- ============================================================

-- Display employee names and salaries,
-- sorted by highest salary
SELECT employee_name, salary
FROM employees
ORDER BY salary DESC;

-- Display employee names and departments,
-- sorted alphabetically by department
SELECT employee_name, department
FROM employees
ORDER BY department ASC;


-- ============================================================
-- 8. ORDER BY USING COLUMN POSITION
-- ============================================================

-- ORDER BY 2 sorts using the second selected column
-- Here, the second column is salary
SELECT employee_name, salary
FROM employees
ORDER BY 2 DESC;

-- ORDER BY 1 sorts using the first selected column
-- Here, the first column is employee_name
SELECT employee_name, salary
FROM employees
ORDER BY 1 ASC;

-- Best practice:
-- Prefer column names instead of column positions
-- because column positions can become confusing.


-- ============================================================
-- 9. ORDER BY WITH NULL VALUES
-- ============================================================

-- PostgreSQL allows NULLS FIRST and NULLS LAST

-- Place NULL salaries at the end
SELECT *
FROM employees
ORDER BY salary ASC NULLS LAST;

-- Place NULL salaries at the beginning
SELECT *
FROM employees
ORDER BY salary DESC NULLS FIRST;

-- Note:
-- Our sample dataset does not contain NULL salaries.
-- These queries demonstrate PostgreSQL syntax.


-- ============================================================
-- 10. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================

-- Q1. Display employees sorted by salary in ascending order
SELECT *
FROM employees
ORDER BY salary ASC;


-- Q2. Display employees sorted by salary in descending order
SELECT *
FROM employees
ORDER BY salary DESC;


-- Q3. Display employee names in alphabetical order
SELECT employee_name
FROM employees
ORDER BY employee_name ASC;


-- Q4. Display employee names in reverse alphabetical order
SELECT employee_name
FROM employees
ORDER BY employee_name DESC;


-- Q5. Find IT employees sorted by salary from highest to lowest
SELECT *
FROM employees
WHERE department = 'IT'
ORDER BY salary DESC;


-- Q6. Sort employees by department ascending,
-- and salary descending within each department
SELECT *
FROM employees
ORDER BY department ASC, salary DESC;


-- Q7. Display employees earning more than 65000,
-- sorted by highest salary
SELECT *
FROM employees
WHERE salary > 65000
ORDER BY salary DESC;


-- Q8. Display HR employees sorted alphabetically
SELECT *
FROM employees
WHERE department = 'HR'
ORDER BY employee_name ASC;


-- Q9. Sort employees by employee ID in descending order
SELECT *
FROM employees
ORDER BY employee_id DESC;


-- Q10. Display employee name, department, and salary,
-- sorted by department and then highest salary
SELECT
    employee_name,
    department,
    salary
FROM employees
ORDER BY department ASC, salary DESC;

