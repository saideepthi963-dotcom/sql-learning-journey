

-- ============================================================
-- 1. INTRODUCTION TO ALIASES
-- ============================================================

-- An alias is a temporary name for a column or table.
-- Aliases improve readability.
-- Aliases do not permanently rename database columns.
-- AS is optional for most column and table aliases.

-- Basic Syntax:
-- SELECT column_name AS alias_name
-- FROM table_name;


-- ============================================================
-- 2. COLUMN ALIASES USING AS
-- ============================================================

-- Rename employee_name to name
SELECT
    employee_name AS name
FROM employees;


-- Rename salary to employee_salary
SELECT
    employee_name AS name,
    salary AS employee_salary
FROM employees;


-- Rename multiple columns
SELECT
    employee_id AS id,
    employee_name AS name,
    department AS dept,
    salary AS annual_salary
FROM employees;


-- ============================================================
-- 3. COLUMN ALIASES WITHOUT AS
-- ============================================================

-- AS is optional when creating column aliases.

SELECT
    employee_name name,
    salary annual_salary
FROM employees;


-- Recommended:
-- Use AS for better readability.

SELECT
    employee_name AS name,
    salary AS annual_salary
FROM employees;


-- ============================================================
-- 4. ALIASES WITH SPACES
-- ============================================================

-- PostgreSQL uses double quotes for aliases containing spaces.

SELECT
    employee_name AS "Employee Name",
    salary AS "Annual Salary"
FROM employees;


-- Alias names are case-sensitive when quoted.

SELECT
    employee_id AS "Employee ID",
    employee_name AS "Full Name",
    department AS "Department Name"
FROM employees;


-- ============================================================
-- 5. ALIASES WITH EXPRESSIONS
-- ============================================================

-- Aliases can rename calculated columns.

-- Calculate monthly salary from annual salary
SELECT
    employee_name,
    salary,
    ROUND(salary / 12.0, 2) AS monthly_salary
FROM employees;


-- Calculate salary after a 10% increase
SELECT
    employee_name,
    salary,
    salary * 1.10 AS increased_salary
FROM employees;


-- Calculate annual salary after a 5000 bonus
SELECT
    employee_name,
    salary,
    salary + 5000 AS salary_with_bonus
FROM employees;


-- ============================================================
-- 6. ALIASES WITH STRING EXPRESSIONS
-- ============================================================

-- Combine employee name and department.
-- PostgreSQL uses || for string concatenation.

SELECT
    employee_name || ' - ' || department AS employee_details
FROM employees;


-- Add descriptive text to employee names
SELECT
    employee_name || ' works in ' || department AS employee_info
FROM employees;


-- ============================================================
-- 7. TABLE ALIASES
-- ============================================================

-- Table aliases assign temporary names to tables.

-- Rename employees table as e
SELECT
    e.employee_id,
    e.employee_name,
    e.salary
FROM employees AS e;


-- AS is optional for table aliases.
SELECT
    e.employee_name,
    e.department
FROM employees e;


-- Table aliases are especially useful in JOIN queries.
-- We will learn JOINs in a future lesson.


-- ============================================================
-- 8. ALIASES WITH WHERE
-- ============================================================

-- Find IT employees and display readable column names
SELECT
    employee_name AS name,
    department AS dept,
    salary AS annual_salary
FROM employees
WHERE department = 'IT';


-- Important:
-- In PostgreSQL, a SELECT alias generally cannot be
-- referenced in the WHERE clause of the same query.

-- Incorrect:
-- SELECT salary AS annual_salary
-- FROM employees
-- WHERE annual_salary > 70000;

-- Correct:
SELECT
    salary AS annual_salary
FROM employees
WHERE salary > 70000;


-- ============================================================
-- 9. ALIASES WITH ORDER BY
-- ============================================================

-- PostgreSQL allows SELECT aliases in ORDER BY.

SELECT
    employee_name AS name,
    salary AS annual_salary
FROM employees
ORDER BY annual_salary DESC;


-- Sort using the alias name
SELECT
    employee_name AS name,
    department AS dept
FROM employees
ORDER BY name ASC;


-- ============================================================
-- 10. ALIASES WITH AGGREGATE FUNCTIONS
-- ============================================================

-- COUNT returns the number of rows.
SELECT
    COUNT(*) AS total_employees
FROM employees;


-- AVG calculates the average salary.
SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;


-- MAX returns the highest salary.
SELECT
    MAX(salary) AS highest_salary
FROM employees;


-- MIN returns the lowest salary.
SELECT
    MIN(salary) AS lowest_salary
FROM employees;


-- ============================================================
-- 11. ALIASES WITH GROUP BY
-- ============================================================

-- Count employees in each department.
SELECT
    department AS dept,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC;


-- Find average salary by department.
SELECT
    department AS dept,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;


-- ============================================================
-- 12. ALIASES WITH DISTINCT
-- ============================================================

-- Display unique departments with a readable heading.
SELECT DISTINCT
    department AS department_name
FROM employees
ORDER BY department_name;


-- ============================================================
-- 13. ALIASES WITH LIMIT
-- ============================================================

-- Display the three highest-paid employees.
SELECT
    employee_name AS name,
    department AS dept,
    salary AS annual_salary
FROM employees
ORDER BY annual_salary DESC, name
LIMIT 3;


-- ============================================================
-- 14. IMPORTANT BEST PRACTICES
-- ============================================================

-- 1. Use meaningful alias names.

-- 2. Prefer AS when defining column aliases.

-- 3. Use snake_case for SQL aliases.

-- 4. Use short table aliases in complex queries.

-- 5. Avoid unnecessary aliases in simple queries.

-- 6. Remember that aliases do not change table structures.

-- 7. Use double quotes when alias names contain spaces.

-- 8. Column aliases can be used in ORDER BY.

-- 9. SELECT aliases generally cannot be used in WHERE
--    within the same query level.


-- ============================================================
-- 15. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Display employee_name as name.
SELECT
    employee_name AS name
FROM employees;


-- Q2. Rename salary as annual_salary.
SELECT
    employee_name,
    salary AS annual_salary
FROM employees;


-- Q3. Display employee ID, name, and department
-- using meaningful aliases.
SELECT
    employee_id AS id,
    employee_name AS name,
    department AS dept
FROM employees;


-- Q4. Calculate monthly salary and name it monthly_salary.
SELECT
    employee_name,
    ROUND(salary / 12.0, 2) AS monthly_salary
FROM employees;


-- Q5. Display salary after a 15% increase.
SELECT
    employee_name,
    salary AS current_salary,
    salary * 1.15 AS updated_salary
FROM employees;


-- Q6. Use e as an alias for employees.
SELECT
    e.employee_id,
    e.employee_name,
    e.department
FROM employees AS e;


-- Q7. Display employees earning above 70000.
-- Rename employee_name as name and salary as annual_salary.
SELECT
    employee_name AS name,
    salary AS annual_salary
FROM employees
WHERE salary > 70000;


-- Q8. Display the highest salary as highest_salary.
SELECT
    MAX(salary) AS highest_salary
FROM employees;


-- Q9. Count employees and rename the result total_employees.
SELECT
    COUNT(*) AS total_employees
FROM employees;


-- Q10. Display employee names and salaries,
-- sorted by the annual_salary alias.
SELECT
    employee_name AS name,
    salary AS annual_salary
FROM employees
ORDER BY annual_salary DESC;


-- Q11. Count employees in each department
-- using aliases for the output columns.
SELECT
    department AS dept,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC;


-- Q12. Display employees with a 10% salary increase,
-- sorted by the new salary from highest to lowest.
SELECT
    employee_name AS name,
    salary AS current_salary,
    salary * 1.10 AS new_salary
FROM employees
ORDER BY new_salary DESC;

