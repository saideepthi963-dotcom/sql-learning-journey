-- ============================================================
-- 1. INTRODUCTION TO LIMIT AND OFFSET
-- ============================================================

-- LIMIT controls the maximum number of rows returned.
-- OFFSET skips a specified number of rows.
-- ORDER BY ensures predictable ordering of results.

-- Basic Syntax:
-- SELECT column_name
-- FROM table_name
-- ORDER BY column_name
-- LIMIT number OFFSET number;


-- ============================================================
-- 2. LIMIT
-- ============================================================

-- Retrieve the first 3 employees ordered by employee ID
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 3;


-- Retrieve only 2 employees
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 2;


-- Retrieve the first employee alphabetically
SELECT *
FROM employees
ORDER BY employee_name ASC
LIMIT 1;


-- ============================================================
-- 3. LIMIT WITH ORDER BY
-- ============================================================

-- Find the highest-paid employee
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 1;


-- Find the 3 highest-paid employees
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 3;


-- Find the 2 lowest-paid employees
SELECT *
FROM employees
ORDER BY salary ASC, employee_id
LIMIT 2;


-- ============================================================
-- 4. OFFSET
-- ============================================================

-- Skip the first 2 employees
-- Return all remaining employees
SELECT *
FROM employees
ORDER BY employee_id
OFFSET 2;


-- Skip the first employee and return the next 2
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 2 OFFSET 1;


-- Skip the first 3 employees and return the next 2
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 2 OFFSET 3;


-- ============================================================
-- 5. LIMIT AND OFFSET WITH ORDER BY
-- ============================================================

-- Retrieve the second-highest-paid employee
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 1 OFFSET 1;


-- Retrieve the third-highest-paid employee
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 1 OFFSET 2;


-- Retrieve employees ranked 2nd through 4th by salary
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 3 OFFSET 1;


-- Note:
-- These examples return rows at specific positions.
-- If salaries are tied, the second row may not have
-- the second-highest DISTINCT salary.


-- ============================================================
-- 6. LIMIT WITH WHERE
-- ============================================================

-- Find the highest-paid IT employee
SELECT *
FROM employees
WHERE department = 'IT'
ORDER BY salary DESC, employee_id
LIMIT 1;


-- Find the 2 highest-paid HR employees
SELECT *
FROM employees
WHERE department = 'HR'
ORDER BY salary DESC, employee_id
LIMIT 2;


-- Find the first 2 employees earning above 65000,
-- sorted by salary descending
SELECT *
FROM employees
WHERE salary > 65000
ORDER BY salary DESC, employee_id
LIMIT 2;


-- ============================================================
-- 7. LIMIT WITH DISTINCT
-- ============================================================

-- Retrieve the first 2 unique departments alphabetically
SELECT DISTINCT department
FROM employees
ORDER BY department ASC
LIMIT 2;


-- Retrieve the 2 highest distinct salary values
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 2;


-- ============================================================
-- 8. PAGINATION USING LIMIT AND OFFSET
-- ============================================================

-- Pagination divides large results into smaller pages.

-- Formula:
-- OFFSET = (Page Number - 1) * Page Size

-- Example:
-- Page Size = 2 employees


-- Page 1: Rows 1 and 2
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 2 OFFSET 0;


-- Page 2: Rows 3 and 4
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 2 OFFSET 2;


-- Page 3: Row 5
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 2 OFFSET 4;


-- ============================================================
-- 9. LIMIT ZERO
-- ============================================================

-- LIMIT 0 returns no rows.
-- Useful for checking the structure of query results.

SELECT *
FROM employees
LIMIT 0;


-- ============================================================
-- 10. FETCH FIRST
-- ============================================================

-- PostgreSQL also supports FETCH FIRST.
-- It is a SQL-standard alternative to LIMIT.

-- Retrieve the 3 highest-paid employees
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
FETCH FIRST 3 ROWS ONLY;


-- Retrieve the highest-paid employee
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
FETCH FIRST 1 ROW ONLY;


-- ============================================================
-- 11. IMPORTANT BEST PRACTICES
-- ============================================================

-- 1. Use ORDER BY with LIMIT for predictable results.

-- 2. Use a unique tie-breaker, such as employee_id,
--    when several rows have the same salary.

-- 3. OFFSET 0 does not skip any rows.

-- 4. OFFSET 2 skips the first two rows.

-- 5. LIMIT does not modify or delete database records.

-- 6. Large OFFSET values can slow down queries.
--    Keyset pagination is often better for large datasets.


-- ============================================================
-- 12. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Retrieve the first 3 employees by employee ID.
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 3;


-- Q2. Find the highest-paid employee.
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 1;


-- Q3. Find the 2 lowest-paid employees.
SELECT *
FROM employees
ORDER BY salary ASC, employee_id
LIMIT 2;


-- Q4. Find the second-highest-paid employee.
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 1 OFFSET 1;


-- Q5. Skip the first 2 employees and return the next 2.
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 2 OFFSET 2;


-- Q6. Find the highest-paid employee in IT.
SELECT *
FROM employees
WHERE department = 'IT'
ORDER BY salary DESC, employee_id
LIMIT 1;


-- Q7. Retrieve the 3 highest salaries.
SELECT salary
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 3;


-- Q8. Retrieve the second page with a page size of 2.
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 2 OFFSET 2;


-- Q9. Retrieve the first 2 unique departments.
SELECT DISTINCT department
FROM employees
ORDER BY department
LIMIT 2;


-- Q10. Find the third-highest-paid employee.
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 1 OFFSET 2;

