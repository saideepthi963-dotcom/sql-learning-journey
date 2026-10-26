
-- ============================================================
-- 1. INTRODUCTION TO GROUP BY
-- ============================================================

-- GROUP BY combines rows sharing the same values
-- into groups.

-- It is commonly used with aggregate functions:
-- COUNT(), SUM(), AVG(), MIN(), MAX()

-- Basic syntax:
--
-- SELECT column_name, AGGREGATE_FUNCTION(column)
-- FROM table_name
-- GROUP BY column_name;


-- ============================================================
-- 2. GROUP BY SINGLE COLUMN
-- ============================================================

-- Count employees in each department.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 3. GROUP BY WITH SUM()
-- ============================================================

-- Calculate total salary for each department.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 4. GROUP BY WITH AVG()
-- ============================================================

-- Calculate average salary per department.

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 5. GROUP BY WITH MIN() AND MAX()
-- ============================================================

-- Find minimum and maximum salary per department.

SELECT
    department,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 6. MULTIPLE AGGREGATE FUNCTIONS
-- ============================================================

-- Generate department-level salary statistics.

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
-- 7. GROUP BY MULTIPLE COLUMNS
-- ============================================================

-- Group employees by department and salary.

SELECT
    department,
    salary,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department, salary
ORDER BY department, salary;


-- Note:
-- Each unique department-and-salary combination
-- becomes a separate group.


-- ============================================================
-- 8. GROUP BY WITH WHERE
-- ============================================================

-- WHERE filters individual rows before grouping.

-- Count employees earning more than 65000
-- in each department.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
WHERE salary > 65000
GROUP BY department
ORDER BY department;


-- ============================================================
-- 9. INTRODUCTION TO HAVING
-- ============================================================

-- HAVING filters groups after aggregation.

-- Find departments containing more than one employee.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1
ORDER BY department;


-- ============================================================
-- 10. HAVING WITH SUM()
-- ============================================================

-- Find departments where total salary exceeds 100000.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 100000
ORDER BY total_salary DESC;


-- ============================================================
-- 11. HAVING WITH AVG()
-- ============================================================

-- Find departments with average salary above 70000.

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 70000
ORDER BY average_salary DESC;


-- ============================================================
-- 12. HAVING WITH MIN() AND MAX()
-- ============================================================

-- Find departments where the highest salary exceeds 80000.

SELECT
    department,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department
HAVING MAX(salary) > 80000;


-- ============================================================
-- 13. HAVING WITH MULTIPLE CONDITIONS
-- ============================================================

-- Find departments with at least 2 employees
-- and average salary above 65000.

SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
HAVING COUNT(*) >= 2
   AND AVG(salary) > 65000;


-- ============================================================
-- 14. WHERE VS HAVING
-- ============================================================

-- WHERE:
-- Filters rows before grouping.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
WHERE salary > 70000
GROUP BY department;


-- HAVING:
-- Filters groups after aggregation.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;


-- WHERE and HAVING together.

SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
WHERE salary >= 65000
GROUP BY department
HAVING COUNT(*) >= 2;


-- ============================================================
-- 15. GROUP BY WITH ORDER BY
-- ============================================================

-- Sort departments by highest average salary.

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;


-- ============================================================
-- 16. GROUP BY WITH LIMIT
-- ============================================================

-- Find the top 2 departments by total salary.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC, department
LIMIT 2;


-- ============================================================
-- 17. GROUP BY WITH DISTINCT
-- ============================================================

-- Count distinct salary values in each department.

SELECT
    department,
    COUNT(DISTINCT salary) AS unique_salary_count
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 18. CONDITIONAL AGGREGATION
-- ============================================================

-- Count employees by salary category per department.

SELECT
    department,

    COUNT(*) AS total_employees,

    COUNT(*) FILTER (
        WHERE salary >= 80000
    ) AS high_salary_employees,

    COUNT(*) FILTER (
        WHERE salary >= 65000 AND salary < 80000
    ) AS medium_salary_employees,

    COUNT(*) FILTER (
        WHERE salary < 65000
    ) AS low_salary_employees

FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 19. GROUP BY WITH CASE EXPRESSIONS
-- ============================================================

-- Group employees by salary category.

SELECT
    CASE
        WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 65000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category,

    COUNT(*) AS employee_count

FROM employees

GROUP BY
    CASE
        WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 65000 THEN 'Medium'
        ELSE 'Low'
    END

ORDER BY salary_category;


-- ============================================================
-- 20. GROUP BY WITH NULL VALUES
-- ============================================================

-- NULL values are grouped together.

WITH sample_employees AS (
    SELECT *
    FROM (
        VALUES
            (101, 'IT'),
            (102, NULL),
            (103, 'HR'),
            (104, NULL),
            (105, 'IT')
    ) AS t(employee_id, department)
)
SELECT
    department,
    COUNT(*) AS employee_count
FROM sample_employees
GROUP BY department
ORDER BY department NULLS LAST;


-- ============================================================
-- 21. GROUP BY WITH COALESCE()
-- ============================================================

-- Display missing departments as Unknown.

WITH sample_employees AS (
    SELECT *
    FROM (
        VALUES
            (101, 'IT'),
            (102, NULL),
            (103, 'HR'),
            (104, NULL)
    ) AS t(employee_id, department)
)
SELECT
    COALESCE(department, 'Unknown') AS department_name,
    COUNT(*) AS employee_count
FROM sample_employees
GROUP BY COALESCE(department, 'Unknown')
ORDER BY department_name;


-- ============================================================
-- 22. GROUP BY WITH ROLLUP
-- ============================================================

-- ROLLUP calculates subtotals and grand totals.

-- Department totals and overall total.

SELECT
    CASE
        WHEN GROUPING(department) = 1
            THEN 'Grand Total'
        ELSE COALESCE(department, 'Unknown')
    END AS department,

    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary

FROM employees

GROUP BY ROLLUP(department)
ORDER BY GROUPING(department), department;


-- ============================================================
-- 23. GROUP BY WITH CUBE
-- ============================================================

-- CUBE calculates aggregates for all combinations
-- of the specified grouping columns.

-- Example using department and salary category.

WITH employee_categories AS (
    SELECT
        department,
        salary,
        CASE
            WHEN salary >= 80000 THEN 'High'
            WHEN salary >= 65000 THEN 'Medium'
            ELSE 'Low'
        END AS salary_category
    FROM employees
)
SELECT
    CASE
        WHEN GROUPING(department) = 1
            THEN 'All Departments'
        ELSE COALESCE(department, 'Unknown')
    END AS department,

    CASE
        WHEN GROUPING(salary_category) = 1
            THEN 'All Categories'
        ELSE salary_category
    END AS salary_category,

    COUNT(*) AS employee_count

FROM employee_categories

GROUP BY CUBE(department, salary_category)

ORDER BY
    GROUPING(department),
    department,
    GROUPING(salary_category),
    salary_category;


-- ============================================================
-- 24. GROUP BY WITH STRING_AGG()
-- ============================================================

-- Display employee names within each department.

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
-- 25. REAL-WORLD DATA ENGINEERING EXAMPLES
-- ============================================================


-- Example 1: Department-level payroll reconciliation.

SELECT
    department,
    COUNT(*) AS record_count,
    SUM(salary) AS total_payroll
FROM employees
GROUP BY department
ORDER BY department;


-- Example 2: Identify duplicate department-salary pairs.

SELECT
    department,
    salary,
    COUNT(*) AS duplicate_count
FROM employees
GROUP BY department, salary
HAVING COUNT(*) > 1;


-- Example 3: Data quality check by department.

SELECT
    department,
    COUNT(*) AS total_records,
    COUNT(salary) AS valid_salary_records,
    COUNT(*) - COUNT(salary) AS missing_salaries
FROM employees
GROUP BY department;


-- Example 4: Department salary percentage
-- of total company payroll.

SELECT
    department,
    SUM(salary) AS department_payroll,

    ROUND(
        100.0 * SUM(salary)
        / NULLIF(
            (SELECT SUM(salary) FROM employees),
            0
        ),
        2
    ) AS payroll_percentage

FROM employees
GROUP BY department
ORDER BY payroll_percentage DESC;


-- Example 5: Identify departments
-- with more than one employee.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;


-- ============================================================
-- 26. IMPORTANT BEST PRACTICES
-- ============================================================

-- 1. Use GROUP BY to summarize rows.

-- 2. Use WHERE to filter rows before aggregation.

-- 3. Use HAVING to filter aggregated groups.

-- 4. Every selected non-aggregate expression
--    generally must be grouped or functionally
--    dependent on the grouping columns.

-- 5. Use meaningful aliases for aggregate results.

-- 6. Use COUNT(*) for row counts.

-- 7. Handle NULL values carefully.

-- 8. Use FILTER for conditional aggregation
--    in PostgreSQL.

-- 9. Use ROLLUP for hierarchical subtotals.

-- 10. Use CUBE for all grouping combinations.

-- 11. Use ORDER BY for predictable result ordering.

-- 12. Use GROUP BY for data quality validation,
--     reporting, and reconciliation.


-- ============================================================
-- 27. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Count employees in each department.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- Q2. Find total salary for each department.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;


-- Q3. Calculate average salary per department.

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department;


-- Q4. Find departments containing more than one employee.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;


-- Q5. Find departments with average salary above 70000.

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 70000;


-- Q6. Find total salary by department,
-- sorted highest to lowest.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC;


-- Q7. Find highest salary in every department.

SELECT
    department,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department;


-- Q8. Find lowest salary in every department.

SELECT
    department,
    MIN(salary) AS lowest_salary
FROM employees
GROUP BY department;


-- Q9. Count employees earning above 70000
-- in each department.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
WHERE salary > 70000
GROUP BY department;


-- Q10. Find departments with at least 2 employees
-- earning 65000 or more.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
WHERE salary >= 65000
GROUP BY department
HAVING COUNT(*) >= 2;


-- Q11. Find the department with
-- the highest total payroll.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC, department
LIMIT 1;


-- Q12. Count distinct salaries by department.

SELECT
    department,
    COUNT(DISTINCT salary) AS unique_salaries
FROM employees
GROUP BY department;


-- Q13. Group employees by salary category.

SELECT
    CASE
        WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 65000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category,
    COUNT(*) AS employee_count
FROM employees
GROUP BY salary_category;


-- Q14. Find departments with total salary
-- exceeding 100000.

SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 100000;


-- Q15. Calculate total salary
-- and average salary by department.

SELECT
    department,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department;

