


-- ============================================================
-- 1. INTRODUCTION TO DISTINCT
-- ============================================================

-- DISTINCT removes duplicate rows from query results.
-- It returns unique values or unique combinations of values.
-- DISTINCT does not delete data from the actual table.

-- Basic syntax:
-- SELECT DISTINCT column_name
-- FROM table_name;


-- ============================================================
-- 2. SELECT WITHOUT DISTINCT
-- ============================================================

-- Display all employee departments
-- Duplicate department names will appear.

SELECT department
FROM employees;


-- ============================================================
-- 3. SELECT WITH DISTINCT
-- ============================================================

-- Display unique departments
-- Each department appears only once.

SELECT DISTINCT department
FROM employees;


-- ============================================================
-- 4. DISTINCT WITH MULTIPLE COLUMNS
-- ============================================================

-- Find unique combinations of department and salary.
-- DISTINCT applies to the entire selected row,
-- not to each column separately.

SELECT DISTINCT department, salary
FROM employees;


-- ============================================================
-- 5. DISTINCT WITH WHERE
-- ============================================================

-- Find unique departments where salary is above 65000.

SELECT DISTINCT department
FROM employees
WHERE salary > 65000;


-- Find unique departments where salary is at least 75000.

SELECT DISTINCT department
FROM employees
WHERE salary >= 75000;


-- ============================================================
-- 6. DISTINCT WITH ORDER BY
-- ============================================================

-- Display unique departments alphabetically.

SELECT DISTINCT department
FROM employees
ORDER BY department ASC;


-- Display unique departments in reverse alphabetical order.

SELECT DISTINCT department
FROM employees
ORDER BY department DESC;


-- ============================================================
-- 7. DISTINCT WITH COUNT
-- ============================================================

-- Count the number of unique departments.

SELECT COUNT(DISTINCT department) AS total_departments
FROM employees;


-- Count the number of unique salary values.

SELECT COUNT(DISTINCT salary) AS unique_salaries
FROM employees;


-- ============================================================
-- 8. DISTINCT WITH NULL VALUES
-- ============================================================

-- DISTINCT treats multiple NULL values as one distinct
-- result when returning unique column values.

SELECT DISTINCT department
FROM employees;

-- Note:
-- Our sample dataset does not contain NULL departments.
-- If there were multiple NULL departments,
-- DISTINCT would return only one NULL.


-- ============================================================
-- 9. DISTINCT VS GROUP BY
-- ============================================================

-- DISTINCT can return unique department names.

SELECT DISTINCT department
FROM employees;


-- GROUP BY can also return unique department names.

SELECT department
FROM employees
GROUP BY department;


-- GROUP BY is commonly used with aggregate functions.
-- Example: Count employees in each department.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- ============================================================
-- 10. POSTGRESQL DISTINCT ON
-- ============================================================

-- DISTINCT ON is a PostgreSQL-specific feature.
-- It returns one row per unique department.
-- ORDER BY determines which row is selected.

-- Find the highest-paid employee in each department.

SELECT DISTINCT ON (department)
    department,
    employee_name,
    salary
FROM employees
ORDER BY department, salary DESC, employee_id;


-- ============================================================
-- 11. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Display all unique departments.

SELECT DISTINCT department
FROM employees;


-- Q2. Display unique departments alphabetically.

SELECT DISTINCT department
FROM employees
ORDER BY department ASC;


-- Q3. Count the total number of unique departments.

SELECT COUNT(DISTINCT department) AS total_departments
FROM employees;


-- Q4. Find unique departments where salary exceeds 70000.

SELECT DISTINCT department
FROM employees
WHERE salary > 70000;


-- Q5. Find unique salary values.

SELECT DISTINCT salary
FROM employees;


-- Q6. Display unique department and salary combinations.

SELECT DISTINCT department, salary
FROM employees;


-- Q7. Count unique salaries.

SELECT COUNT(DISTINCT salary) AS unique_salary_count
FROM employees;


-- Q8. Find unique departments containing employees
-- earning between 60000 and 80000.

SELECT DISTINCT department
FROM employees
WHERE salary BETWEEN 60000 AND 80000;


-- Q9. Display unique departments in descending order.

SELECT DISTINCT department
FROM employees
ORDER BY department DESC;


-- Q10. Find the highest-paid employee in each department.
-- PostgreSQL-specific DISTINCT ON.

SELECT DISTINCT ON (department)
    department,
    employee_name,
    salary
FROM employees
ORDER BY department, salary DESC, employee_id;
