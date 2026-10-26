
-- ============================================================
-- 1. INTRODUCTION TO NULL
-- ============================================================

-- NULL represents a missing or unknown value.
-- NULL is not the same as:
-- 1. Zero (0)
-- 2. Empty string ('')
-- 3. Space (' ')
-- 4. FALSE

-- NULL values require special handling in SQL.


-- ============================================================
-- 2. CREATE SAMPLE DATA WITH NULL VALUES
-- ============================================================

-- Use this query to examine our sample dataset.
-- A CTE exists only for the statement in which it appears.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 'IT', 75000),
            (102, 'Bob', NULL, 60000),
            (103, 'Charlie', 'Finance', NULL),
            (104, 'David', 'IT', 90000),
            (105, 'Emma', NULL, NULL)
    ) AS t(employee_id, employee_name, department, salary)
)
SELECT *
FROM employee_data;


-- ============================================================
-- 3. IS NULL
-- ============================================================

-- IS NULL checks whether a value is missing.

-- Find employees without an assigned department.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 'IT', 75000),
            (102, 'Bob', NULL, 60000),
            (103, 'Charlie', 'Finance', NULL),
            (104, 'David', 'IT', 90000),
            (105, 'Emma', NULL, NULL)
    ) AS t(employee_id, employee_name, department, salary)
)
SELECT *
FROM employee_data
WHERE department IS NULL;


-- ============================================================
-- 4. IS NOT NULL
-- ============================================================

-- IS NOT NULL returns rows with existing values.

SELECT *
FROM employees
WHERE department IS NOT NULL;


-- ============================================================
-- 5. NULL WITH COMPARISON OPERATORS
-- ============================================================

-- NULL cannot be compared using = or <>.

-- Incorrect approach:
-- SELECT * FROM employees WHERE department = NULL;

-- Correct approach:
SELECT *
FROM employees
WHERE department IS NULL;


-- NULL comparisons generally produce UNKNOWN.

SELECT
    NULL = NULL AS equal_comparison,
    NULL <> NULL AS not_equal_comparison,
    NULL > 10 AS greater_comparison;


-- ============================================================
-- 6. THREE-VALUED LOGIC
-- ============================================================

-- SQL conditions can evaluate to:
-- TRUE
-- FALSE
-- UNKNOWN (represented by NULL)

SELECT
    TRUE AND NULL AS and_result,
    FALSE AND NULL AS false_and_result,
    TRUE OR NULL AS or_result,
    FALSE OR NULL AS false_or_result,
    NOT NULL AS not_result;


-- ============================================================
-- 7. COALESCE()
-- ============================================================

-- COALESCE returns the first non-NULL argument.
-- It is commonly used to provide default values.

SELECT
    COALESCE(NULL, 'Unknown') AS result;


SELECT
    COALESCE(NULL, NULL, 'SQL') AS result;


-- Replace missing department values with Unknown.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 'IT', 75000),
            (102, 'Bob', NULL, 60000),
            (103, 'Charlie', 'Finance', NULL),
            (104, 'David', 'IT', 90000),
            (105, 'Emma', NULL, NULL)
    ) AS t(employee_id, employee_name, department, salary)
)
SELECT
    employee_name,
    COALESCE(department, 'Unknown') AS department
FROM employee_data;


-- ============================================================
-- 8. COALESCE WITH NUMERIC VALUES
-- ============================================================

-- Replace missing salaries with zero for display.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 75000),
            (102, 'Bob', NULL),
            (103, 'Charlie', 80000)
    ) AS t(employee_id, employee_name, salary)
)
SELECT
    employee_name,
    COALESCE(salary, 0) AS displayed_salary
FROM employee_data;


-- Important:
-- Replacing missing values with zero changes their meaning.
-- Use this only when appropriate for the business requirement.


-- ============================================================
-- 9. COALESCE WITH MULTIPLE COLUMNS
-- ============================================================

-- Return the first available contact number.

WITH contacts AS (
    SELECT *
    FROM (
        VALUES
            (1, NULL, '555-1111'),
            (2, '555-2222', NULL),
            (3, NULL, NULL)
    ) AS t(customer_id, mobile_number, home_number)
)
SELECT
    customer_id,
    COALESCE(
        mobile_number,
        home_number,
        'Not Available'
    ) AS contact_number
FROM contacts;


-- ============================================================
-- 10. NULLIF()
-- ============================================================

-- NULLIF(a, b) returns NULL when a equals b.
-- Otherwise, it returns a.

SELECT NULLIF(10, 10) AS result;

SELECT NULLIF(10, 20) AS result;


-- Convert empty strings to NULL.

SELECT NULLIF('', '') AS cleaned_value;


-- ============================================================
-- 11. NULLIF TO PREVENT DIVISION BY ZERO
-- ============================================================

-- Avoid errors when dividing by zero.

SELECT
    100.0 / NULLIF(0, 0) AS safe_division;


-- Calculate revenue per order safely.

WITH sales AS (
    SELECT *
    FROM (
        VALUES
            (1, 1000, 10),
            (2, 500, 0),
            (3, 750, 5)
    ) AS t(store_id, revenue, total_orders)
)
SELECT
    store_id,
    revenue,
    total_orders,
    revenue::NUMERIC / NULLIF(total_orders, 0)
        AS revenue_per_order
FROM sales;


-- ============================================================
-- 12. CASE WITH NULL
-- ============================================================

-- Use CASE to classify missing values.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 'IT'),
            (102, 'Bob', NULL),
            (103, 'Charlie', 'Finance')
    ) AS t(employee_id, employee_name, department)
)
SELECT
    employee_name,
    CASE
        WHEN department IS NULL THEN 'Missing Department'
        ELSE department
    END AS department_status
FROM employee_data;


-- ============================================================
-- 13. NULL IN ARITHMETIC OPERATIONS
-- ============================================================

-- Most arithmetic operations with NULL return NULL.

SELECT
    100 + NULL AS addition_result,
    100 - NULL AS subtraction_result,
    100 * NULL AS multiplication_result,
    100 / NULL AS division_result;


-- Use COALESCE only when replacing NULL is appropriate.

SELECT
    100 + COALESCE(NULL::INT, 0) AS adjusted_result;


-- ============================================================
-- 14. NULL WITH STRING OPERATIONS
-- ============================================================

-- CONCAT treats NULL arguments as empty strings.

SELECT
    CONCAT('Hello ', NULL, 'World') AS result;


-- PostgreSQL || returns NULL when an operand is NULL.

SELECT
    'Hello ' || NULL::TEXT AS result;


-- Handle NULL using COALESCE.

SELECT
    'Hello ' || COALESCE(NULL::TEXT, 'Unknown')
        AS result;


-- ============================================================
-- 15. COUNT(*) VS COUNT(COLUMN)
-- ============================================================

-- COUNT(*) counts all rows.
-- COUNT(column) counts non-NULL values.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 75000),
            (102, 'Bob', NULL),
            (103, 'Charlie', 80000),
            (104, 'David', NULL)
    ) AS t(employee_id, employee_name, salary)
)
SELECT
    COUNT(*) AS total_employees,
    COUNT(salary) AS employees_with_salary,
    COUNT(*) - COUNT(salary) AS missing_salaries
FROM employee_data;


-- ============================================================
-- 16. NULL WITH SUM(), AVG(), MIN(), MAX()
-- ============================================================

-- These aggregates ignore NULL input values.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 75000),
            (102, NULL),
            (103, 80000),
            (104, 90000)
    ) AS t(employee_id, salary)
)
SELECT
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employee_data;


-- Note:
-- AVG ignores missing values rather than treating them as zero.


-- ============================================================
-- 17. COUNT DISTINCT WITH NULL
-- ============================================================

-- COUNT(DISTINCT column) ignores NULL values.

WITH departments AS (
    SELECT *
    FROM (
        VALUES
            ('IT'),
            ('HR'),
            ('IT'),
            (NULL),
            (NULL)
    ) AS t(department)
)
SELECT
    COUNT(DISTINCT department) AS unique_departments
FROM departments;


-- ============================================================
-- 18. IS DISTINCT FROM
-- ============================================================

-- IS DISTINCT FROM compares values while treating NULL
-- as a comparable value.

SELECT
    NULL IS DISTINCT FROM NULL AS result1,
    NULL IS DISTINCT FROM 10 AS result2,
    10 IS DISTINCT FROM 20 AS result3,
    10 IS DISTINCT FROM 10 AS result4;


-- ============================================================
-- 19. IS NOT DISTINCT FROM
-- ============================================================

-- NULL-safe equality comparison.

SELECT
    NULL IS NOT DISTINCT FROM NULL AS result1,
    NULL IS NOT DISTINCT FROM 10 AS result2,
    10 IS NOT DISTINCT FROM 10 AS result3;


-- ============================================================
-- 20. NULL WITH ORDER BY
-- ============================================================

-- PostgreSQL allows explicit NULL ordering.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            ('Alice', 75000),
            ('Bob', NULL),
            ('Charlie', 80000),
            ('David', NULL)
    ) AS t(employee_name, salary)
)
SELECT *
FROM employee_data
ORDER BY salary ASC NULLS LAST;


-- Place missing salary values first.

WITH employee_data AS (
    SELECT *
    FROM (
        VALUES
            ('Alice', 75000),
            ('Bob', NULL),
            ('Charlie', 80000),
            ('David', NULL)
    ) AS t(employee_name, salary)
)
SELECT *
FROM employee_data
ORDER BY salary DESC NULLS FIRST;


-- ============================================================
-- 21. NULL WITH IN AND NOT IN
-- ============================================================

-- Be careful when NOT IN includes NULL values.

SELECT
    10 NOT IN (20, NULL) AS result;


-- The result is UNKNOWN because of NULL.


-- Safer approach when filtering a table:
-- Use NOT EXISTS with an appropriate matching condition.

SELECT *
FROM employees AS e
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        VALUES ('IT'), ('HR')
    ) AS d(department)
    WHERE d.department = e.department
);


-- This example also returns employees with NULL departments
-- because no non-NULL department matches them.


-- ============================================================
-- 22. NULL VS EMPTY STRING
-- ============================================================

-- PostgreSQL treats NULL and '' differently.

SELECT
    NULLIF('', '') AS empty_to_null;


-- Identify blank or whitespace-only text.

SELECT
    CASE
        WHEN NULLIF(TRIM('   '), '') IS NULL
            THEN 'Missing Value'
        ELSE 'Available'
    END AS value_status;


-- ============================================================
-- 23. REAL-WORLD DATA ENGINEERING EXAMPLES
-- ============================================================


-- Example 1: Standardize blank department values.

WITH source_data AS (
    SELECT *
    FROM (
        VALUES
            (101, ' IT '),
            (102, ''),
            (103, NULL),
            (104, '   ')
    ) AS t(employee_id, department)
)
SELECT
    employee_id,
    COALESCE(
        NULLIF(TRIM(department), ''),
        'Unknown'
    ) AS cleaned_department
FROM source_data;


-- Example 2: Identify missing mandatory values.

WITH source_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice'),
            (102, NULL),
            (103, ''),
            (104, 'David')
    ) AS t(employee_id, employee_name)
)
SELECT *
FROM source_data
WHERE NULLIF(TRIM(employee_name), '') IS NULL;


-- Example 3: Measure missing-value percentage.

WITH source_data AS (
    SELECT *
    FROM (
        VALUES
            (101, 'IT'),
            (102, NULL),
            (103, 'Finance'),
            (104, NULL)
    ) AS t(employee_id, department)
)
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(department) AS missing_rows,
    ROUND(
        100.0 * (COUNT(*) - COUNT(department))
        / NULLIF(COUNT(*), 0),
        2
    ) AS missing_percentage
FROM source_data;


-- Example 4: Compare old and new values safely.

SELECT
    CASE
        WHEN NULL::TEXT IS DISTINCT FROM 'IT'
            THEN 'Changed'
        ELSE 'Unchanged'
    END AS change_status;


-- Example 5: Fill missing text values.

SELECT
    employee_name,
    COALESCE(department, 'Unknown') AS department
FROM employees;


-- ============================================================
-- 24. IMPORTANT BEST PRACTICES
-- ============================================================

-- 1. Use IS NULL and IS NOT NULL to check missing values.

-- 2. Do not compare NULL using = or <>.

-- 3. Use COALESCE to provide suitable default values.

-- 4. Use NULLIF to handle zero denominators.

-- 5. Remember that COUNT(column) ignores NULL.

-- 6. Most aggregates ignore NULL inputs.

-- 7. Use IS DISTINCT FROM for NULL-safe comparisons.

-- 8. Be careful with NOT IN when NULL values are present.

-- 9. Distinguish NULL from zero and empty strings.

-- 10. Never replace missing business values without
--     understanding their meaning.

-- 11. Use explicit NULLS FIRST or NULLS LAST when
--     predictable NULL ordering is required.

-- 12. Measure missing-data percentages in data pipelines.


-- ============================================================
-- 25. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Find employees with missing departments.

SELECT *
FROM employees
WHERE department IS NULL;


-- Q2. Find employees with assigned departments.

SELECT *
FROM employees
WHERE department IS NOT NULL;


-- Q3. Replace missing department values with Unknown.

SELECT
    employee_name,
    COALESCE(department, 'Unknown') AS department
FROM employees;


-- Q4. Count employees with missing salaries.

SELECT
    COUNT(*) - COUNT(salary) AS missing_salary_count
FROM employees;


-- Q5. Prevent division by zero.

SELECT
    500.0 / NULLIF(0, 0) AS safe_result;


-- Q6. Count all employees.

SELECT
    COUNT(*) AS total_employees
FROM employees;


-- Q7. Count employees with non-NULL salaries.

SELECT
    COUNT(salary) AS employees_with_salary
FROM employees;


-- Q8. Replace missing salary values with zero
-- for a display-only calculation.

SELECT
    employee_name,
    COALESCE(salary, 0) AS displayed_salary
FROM employees;


-- Q9. Identify whether a text value is missing.

SELECT
    CASE
        WHEN NULLIF(TRIM(''), '') IS NULL
            THEN 'Missing'
        ELSE 'Available'
    END AS value_status;


-- Q10. Compare NULL values safely.

SELECT
    NULL IS NOT DISTINCT FROM NULL
        AS null_safe_equality;


-- Q11. Calculate average salary ignoring NULL values.

SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;


-- Q12. Find employees with missing department
-- or missing salary.

SELECT *
FROM employees
WHERE department IS NULL
   OR salary IS NULL;


-- Q13. Count distinct non-NULL departments.

SELECT
    COUNT(DISTINCT department) AS unique_departments
FROM employees;


-- Q14. Return a default value when a string is NULL.

SELECT
    COALESCE(NULL::TEXT, 'Not Available') AS result;


-- Q15. Check whether two different values are distinct.

SELECT
    100 IS DISTINCT FROM 200 AS result;

