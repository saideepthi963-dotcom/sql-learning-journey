
-- ============================================================
-- 1. INTRODUCTION TO AGGREGATE FUNCTIONS
-- ============================================================

-- Aggregate functions perform calculations
-- across multiple rows.

-- Common Aggregate Functions:
-- COUNT() -> Counts rows or non-NULL values
-- SUM()   -> Calculates total
-- AVG()   -> Calculates average
-- MIN()   -> Returns minimum value
-- MAX()   -> Returns maximum value

-- Without GROUP BY, aggregate queries generally
-- return one summarized row.


-- ============================================================
-- 2. COUNT()
-- ============================================================

-- Count all employees.

SELECT
    COUNT(*) AS total_employees
FROM employees;


-- Count non-NULL employee IDs.

SELECT
    COUNT(employee_id) AS employee_count
FROM employees;


-- Count employees with assigned departments.

SELECT
    COUNT(department) AS assigned_departments
FROM employees;


-- ============================================================
-- 3. COUNT(*) VS COUNT(COLUMN)
-- ============================================================

-- COUNT(*) counts all rows.
-- COUNT(column) ignores NULL values.

WITH sample_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 75000),
            (102, NULL),
            (103, 80000),
            (104, NULL)
    ) AS t(employee_id, salary)
)
SELECT
    COUNT(*) AS total_rows,
    COUNT(salary) AS non_null_salaries,
    COUNT(*) - COUNT(salary) AS missing_salaries
FROM sample_data;


-- ============================================================
-- 4. COUNT(DISTINCT)
-- ============================================================

-- Count unique non-NULL departments.

SELECT
    COUNT(DISTINCT department) AS unique_departments
FROM employees;


-- Count unique salary values.

SELECT
    COUNT(DISTINCT salary) AS unique_salaries
FROM employees;


-- ============================================================
-- 5. SUM()
-- ============================================================

-- Calculate total employee salary.

SELECT
    SUM(salary) AS total_salary
FROM employees;


-- Calculate total salary for IT employees.

SELECT
    SUM(salary) AS it_total_salary
FROM employees
WHERE department = 'IT';


-- Calculate total salary for HR employees.

SELECT
    SUM(salary) AS hr_total_salary
FROM employees
WHERE department = 'HR';


-- ============================================================
-- 6. AVG()
-- ============================================================

-- Calculate average employee salary.

SELECT
    AVG(salary) AS average_salary
FROM employees;


-- Round average salary to two decimal places.

SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;


-- Calculate average IT salary.

SELECT
    ROUND(AVG(salary), 2) AS it_average_salary
FROM employees
WHERE department = 'IT';


-- ============================================================
-- 7. MIN()
-- ============================================================

-- Find the lowest employee salary.

SELECT
    MIN(salary) AS lowest_salary
FROM employees;


-- Find the lowest salary in HR.

SELECT
    MIN(salary) AS lowest_hr_salary
FROM employees
WHERE department = 'HR';


-- Find the alphabetically first employee name.

SELECT
    MIN(employee_name) AS first_employee_name
FROM employees;


-- ============================================================
-- 8. MAX()
-- ============================================================

-- Find the highest employee salary.

SELECT
    MAX(salary) AS highest_salary
FROM employees;


-- Find the highest salary in IT.

SELECT
    MAX(salary) AS highest_it_salary
FROM employees
WHERE department = 'IT';


-- Find the alphabetically last employee name.

SELECT
    MAX(employee_name) AS last_employee_name
FROM employees;


-- ============================================================
-- 9. MULTIPLE AGGREGATE FUNCTIONS
-- ============================================================

-- Calculate employee statistics in one query.

SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;


-- ============================================================
-- 10. AGGREGATE FUNCTIONS WITH WHERE
-- ============================================================

-- Count employees earning above 70000.

SELECT
    COUNT(*) AS high_salary_employees
FROM employees
WHERE salary > 70000;


-- Calculate total salary of employees earning
-- at least 75000.

SELECT
    SUM(salary) AS total_salary
FROM employees
WHERE salary >= 75000;


-- Calculate average salary for HR employees.

SELECT
    ROUND(AVG(salary), 2) AS average_hr_salary
FROM employees
WHERE department = 'HR';


-- ============================================================
-- 11. AGGREGATE FUNCTIONS WITH DISTINCT
-- ============================================================

-- Sum unique salary values.

SELECT
    SUM(DISTINCT salary) AS total_distinct_salaries
FROM employees;


-- Average unique salary values.

SELECT
    ROUND(AVG(DISTINCT salary), 2)
        AS average_distinct_salary
FROM employees;


-- Important:
-- SUM(DISTINCT salary) removes duplicate salary VALUES.
-- It does not calculate payroll for unique employees.

-- Use SUM(salary) for total payroll.


-- ============================================================
-- 12. AGGREGATE FUNCTIONS WITH NULL VALUES
-- ============================================================

-- SUM, AVG, MIN, and MAX ignore NULL inputs.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 75000),
            (102, NULL),
            (103, 80000),
            (104, 90000),
            (105, NULL)
    ) AS t(employee_id, salary)
)
SELECT
    COUNT(*) AS total_rows,
    COUNT(salary) AS available_salaries,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employee_data;


-- ============================================================
-- 13. AGGREGATES ON AN EMPTY RESULT
-- ============================================================

-- COUNT returns zero when no rows match.
-- SUM, AVG, MIN, and MAX return NULL.

SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees
WHERE department = 'Marketing';


-- ============================================================
-- 14. COALESCE WITH AGGREGATE FUNCTIONS
-- ============================================================

-- Replace a NULL aggregate result with zero
-- when appropriate for the business requirement.

SELECT
    COALESCE(SUM(salary), 0) AS total_salary
FROM employees
WHERE department = 'Marketing';


-- COUNT already returns zero for an empty result.

SELECT
    COUNT(*) AS employee_count
FROM employees
WHERE department = 'Marketing';


-- ============================================================
-- 15. CONDITIONAL AGGREGATION
-- ============================================================

-- Count IT employees using CASE.

SELECT
    SUM(
        CASE
            WHEN department = 'IT' THEN 1
            ELSE 0
        END
    ) AS it_employee_count
FROM employees;


-- Count employees in multiple departments.

SELECT
    COUNT(*) AS total_employees,

    COUNT(*) FILTER (
        WHERE department = 'IT'
    ) AS it_employees,

    COUNT(*) FILTER (
        WHERE department = 'HR'
    ) AS hr_employees,

    COUNT(*) FILTER (
        WHERE department = 'Finance'
    ) AS finance_employees
FROM employees;


-- FILTER is supported by PostgreSQL.
-- It applies a condition to an individual aggregate.


-- ============================================================
-- 16. CONDITIONAL SUM()
-- ============================================================

-- Calculate salary totals for individual departments.

SELECT
    SUM(salary) FILTER (
        WHERE department = 'IT'
    ) AS it_total_salary,

    SUM(salary) FILTER (
        WHERE department = 'HR'
    ) AS hr_total_salary,

    SUM(salary) FILTER (
        WHERE department = 'Finance'
    ) AS finance_total_salary

FROM employees;


-- ============================================================
-- 17. CONDITIONAL AVG()
-- ============================================================

-- Calculate average salaries by department.

SELECT
    ROUND(
        AVG(salary) FILTER (
            WHERE department = 'IT'
        ),
        2
    ) AS it_average_salary,

    ROUND(
        AVG(salary) FILTER (
            WHERE department = 'HR'
        ),
        2
    ) AS hr_average_salary

FROM employees;


-- ============================================================
-- 18. AGGREGATES WITH GROUP BY
-- ============================================================

-- GROUP BY creates separate groups.
-- Each group receives its own aggregate result.

-- Count employees per department.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY department;


-- Calculate total salary per department.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY department;


-- Calculate average salary per department.

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
ORDER BY department;


-- We'll study GROUP BY and HAVING in detail
-- in the next lesson.


-- ============================================================
-- 19. AGGREGATE FUNCTIONS WITH HAVING
-- ============================================================

-- HAVING filters groups based on aggregate conditions.

-- Find departments with more than one employee.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1
ORDER BY department;


-- Find departments with average salary above 70000.

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 70000;


-- ============================================================
-- 20. AGGREGATE FUNCTIONS WITH ORDER BY
-- ============================================================

-- Sort departments by highest total salary.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC;


-- Sort departments by employee count.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC, department;


-- ============================================================
-- 21. AGGREGATES WITH CALCULATIONS
-- ============================================================

-- Calculate total annual payroll.

SELECT
    SUM(salary) AS annual_payroll
FROM employees;


-- Calculate total monthly payroll.

SELECT
    ROUND(SUM(salary) / 12.0, 2)
        AS monthly_payroll
FROM employees;


-- Calculate salary range.

SELECT
    MAX(salary) - MIN(salary) AS salary_range
FROM employees;


-- Calculate a 10% payroll increase.

SELECT
    SUM(salary) AS current_payroll,
    SUM(salary) * 1.10 AS increased_payroll
FROM employees;


-- ============================================================
-- 22. FIND EMPLOYEES ABOVE AVERAGE SALARY
-- ============================================================

-- An aggregate in a scalar subquery can be used
-- to filter individual employees.

SELECT
    employee_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;


-- ============================================================
-- 23. STRING_AGG()
-- ============================================================

-- STRING_AGG combines text values from multiple rows.

-- List all employee names.

SELECT
    STRING_AGG(
        employee_name,
        ', ' ORDER BY employee_name
    ) AS employee_names
FROM employees;


-- List employee names by department.

SELECT
    department,
    STRING_AGG(
        employee_name,
        ', ' ORDER BY employee_name
    ) AS employee_names
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 24. BOOL_AND() AND BOOL_OR()
-- ============================================================

-- PostgreSQL supports Boolean aggregate functions.

-- BOOL_AND returns TRUE when all non-NULL
-- input conditions are TRUE.

SELECT
    BOOL_AND(salary >= 60000)
        AS all_salaries_at_least_60000
FROM employees;


-- BOOL_OR returns TRUE when at least one
-- non-NULL input condition is TRUE.

SELECT
    BOOL_OR(salary > 85000)
        AS any_salary_above_85000
FROM employees;


-- ============================================================
-- 25. REAL-WORLD DATA ENGINEERING EXAMPLES
-- ============================================================


-- Example 1: Source table row count.

SELECT
    COUNT(*) AS source_row_count
FROM employees;


-- Example 2: Check unique employee IDs.

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT employee_id) AS unique_ids
FROM employees;


-- Example 3: Count missing values.

SELECT
    COUNT(*) - COUNT(department)
        AS missing_department_count,

    COUNT(*) - COUNT(salary)
        AS missing_salary_count
FROM employees;


-- Example 4: Calculate missing-value percentage.

SELECT
    COUNT(*) AS total_rows,

    ROUND(
        100.0 * (
            COUNT(*) - COUNT(department)
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS missing_department_percentage

FROM employees;


-- Example 5: Financial reconciliation.

SELECT
    COUNT(*) AS total_records,
    SUM(salary) AS total_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;


-- Example 6: Employee statistics by department.

SELECT
    department,
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 26. IMPORTANT BEST PRACTICES
-- ============================================================

-- 1. COUNT(*) counts all rows.

-- 2. COUNT(column) ignores NULL values.

-- 3. SUM, AVG, MIN, and MAX ignore NULL inputs.

-- 4. Aggregates without GROUP BY summarize
--    the entire filtered dataset.

-- 5. GROUP BY calculates results per group.

-- 6. WHERE filters rows before aggregation.

-- 7. HAVING filters grouped results.

-- 8. COUNT(DISTINCT column) counts unique
--    non-NULL values.

-- 9. Avoid SUM(DISTINCT salary) for payroll
--    because equal salaries can belong
--    to different employees.

-- 10. Use NULLIF to protect division operations.

-- 11. Use COALESCE when NULL aggregate results
--     require an appropriate default.

-- 12. Use aggregate functions for data quality,
--     reporting, and reconciliation.


-- ============================================================
-- 27. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Count total employees.

SELECT
    COUNT(*) AS total_employees
FROM employees;


-- Q2. Calculate total employee salary.

SELECT
    SUM(salary) AS total_salary
FROM employees;


-- Q3. Calculate average salary.

SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;


-- Q4. Find highest salary.

SELECT
    MAX(salary) AS highest_salary
FROM employees;


-- Q5. Find lowest salary.

SELECT
    MIN(salary) AS lowest_salary
FROM employees;


-- Q6. Count IT employees.

SELECT
    COUNT(*) AS it_employee_count
FROM employees
WHERE department = 'IT';


-- Q7. Calculate total HR salary.

SELECT
    SUM(salary) AS hr_total_salary
FROM employees
WHERE department = 'HR';


-- Q8. Count unique departments.

SELECT
    COUNT(DISTINCT department)
        AS unique_departments
FROM employees;


-- Q9. Find average IT salary.

SELECT
    ROUND(AVG(salary), 2)
        AS average_it_salary
FROM employees
WHERE department = 'IT';


-- Q10. Calculate salary range.

SELECT
    MAX(salary) - MIN(salary)
        AS salary_range
FROM employees;


-- Q11. Count employees earning more than 70000.

SELECT
    COUNT(*) AS employee_count
FROM employees
WHERE salary > 70000;


-- Q12. Calculate total monthly payroll.

SELECT
    ROUND(SUM(salary) / 12.0, 2)
        AS monthly_payroll
FROM employees;


-- Q13. Count employees in each department.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY department;


-- Q14. Find departments with more than one employee.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;


-- Q15. Find employees earning above
-- the company average salary.

SELECT
    employee_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;


-- Q16. Calculate total salary by department.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC;


-- Q17. Find average salaries by department.

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;


-- Q18. Count missing department values.

SELECT
    COUNT(*) - COUNT(department)
        AS missing_departments
FROM employees;


-- Q19. Check whether all employees earn at least 60000.

SELECT
    BOOL_AND(salary >= 60000) AS salary_check
FROM employees;


-- Q20. Calculate complete employee statistics.

SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;

