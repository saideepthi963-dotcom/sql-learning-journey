-- ==========================================
-- SQL FUNDAMENTALS
-- Topic 01: SELECT and FROM
-- ==========================================

-- 1. Retrieve all columns
SELECT *
FROM employees;

-- 2. Retrieve specific columns
SELECT employee_id, employee_name
FROM employees;

-- 3. Retrieve employee names and salaries
SELECT employee_name, salary
FROM employees;

-- 4. Retrieve department information
SELECT department
FROM employees;