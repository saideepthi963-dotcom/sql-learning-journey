
-- ============================================================
-- 1. INTRODUCTION
-- ============================================================

-- Numeric functions are used to perform mathematical
-- calculations on numeric data.

-- Common uses:
-- 1. Salary calculations
-- 2. Financial reporting
-- 3. Data transformations
-- 4. Percentage calculations
-- 5. Data Engineering ETL pipelines


-- ============================================================
-- 2. BASIC ARITHMETIC OPERATORS
-- ============================================================

-- Addition
SELECT 100 + 50 AS addition;

-- Subtraction
SELECT 100 - 50 AS subtraction;

-- Multiplication
SELECT 100 * 5 AS multiplication;

-- Division
SELECT 100.0 / 3 AS division;

-- Modulus (remainder)
SELECT 10 % 3 AS remainder;


-- ============================================================
-- 3. ROUND()
-- ============================================================

-- ROUND rounds a number to a specified decimal position.

SELECT ROUND(123.456::NUMERIC, 2) AS rounded_value;

SELECT ROUND(123.456::NUMERIC, 1) AS rounded_value;

SELECT ROUND(123.456::NUMERIC, 0) AS rounded_value;


-- Calculate monthly salary rounded to two decimals.

SELECT
    employee_name,
    salary,
    ROUND(salary / 12.0, 2) AS monthly_salary
FROM employees;


-- ============================================================
-- 4. CEIL() / CEILING()
-- ============================================================

-- CEIL rounds a number upward to the nearest integer.

SELECT CEIL(12.3) AS ceiling_value;

SELECT CEIL(12.9) AS ceiling_value;

SELECT CEIL(-12.3) AS ceiling_value;


-- Example using employee salaries.

SELECT
    employee_name,
    CEIL(salary / 12.0) AS monthly_salary_ceiling
FROM employees;


-- ============================================================
-- 5. FLOOR()
-- ============================================================

-- FLOOR rounds a number downward to the nearest integer.

SELECT FLOOR(12.3) AS floor_value;

SELECT FLOOR(12.9) AS floor_value;

SELECT FLOOR(-12.3) AS floor_value;


-- Example using employee salaries.

SELECT
    employee_name,
    FLOOR(salary / 12.0) AS monthly_salary_floor
FROM employees;


-- ============================================================
-- 6. ABS()
-- ============================================================

-- ABS returns the absolute value of a number.

SELECT ABS(-100) AS absolute_value;

SELECT ABS(100) AS absolute_value;


-- Calculate absolute difference from a target salary.

SELECT
    employee_name,
    salary,
    ABS(salary - 75000) AS difference_from_target
FROM employees;


-- ============================================================
-- 7. MOD()
-- ============================================================

-- MOD returns the remainder after division.

SELECT MOD(10, 3) AS remainder;

SELECT MOD(20, 4) AS remainder;


-- Find employees with even employee IDs.

SELECT *
FROM employees
WHERE MOD(employee_id, 2) = 0;


-- Find employees with odd employee IDs.

SELECT *
FROM employees
WHERE MOD(employee_id, 2) = 1;


-- ============================================================
-- 8. POWER()
-- ============================================================

-- POWER raises a number to a specified exponent.

SELECT POWER(2, 3) AS power_result;

SELECT POWER(5, 2) AS squared_value;

SELECT POWER(10, 3) AS cubed_value;


-- ============================================================
-- 9. SQRT()
-- ============================================================

-- SQRT returns the square root of a number.

SELECT SQRT(25) AS square_root;

SELECT SQRT(144) AS square_root;

SELECT SQRT(81) AS square_root;


-- ============================================================
-- 10. SIGN()
-- ============================================================

-- SIGN identifies whether a number is positive,
-- negative, or zero.

-- Returns:
-- 1  = Positive
-- -1 = Negative
-- 0  = Zero

SELECT SIGN(100) AS positive_number;

SELECT SIGN(-100) AS negative_number;

SELECT SIGN(0) AS zero_value;


-- Salary difference from 75000.

SELECT
    employee_name,
    salary,
    SIGN(salary - 75000) AS salary_comparison
FROM employees;


-- ============================================================
-- 11. TRUNC()
-- ============================================================

-- TRUNC removes decimal digits without rounding.

SELECT TRUNC(123.456::NUMERIC, 2) AS truncated_value;

SELECT TRUNC(123.456::NUMERIC, 1) AS truncated_value;

SELECT TRUNC(123.456::NUMERIC, 0) AS truncated_value;


-- Monthly salary truncated to two decimal places.

SELECT
    employee_name,
    TRUNC(salary / 12.0, 2) AS monthly_salary
FROM employees;


-- ============================================================
-- 12. RANDOM()
-- ============================================================

-- RANDOM generates a pseudo-random number
-- greater than or equal to 0 and less than 1.

SELECT RANDOM() AS random_number;


-- Generate a random integer between 1 and 100.

SELECT FLOOR(RANDOM() * 100 + 1)::INT AS random_integer;


-- ============================================================
-- 13. GREATEST()
-- ============================================================

-- GREATEST returns the largest value
-- among the supplied expressions.

SELECT GREATEST(100, 200, 300) AS greatest_value;


-- Compare salary with a minimum benchmark.

SELECT
    employee_name,
    salary,
    GREATEST(salary, 70000) AS adjusted_salary
FROM employees;


-- ============================================================
-- 14. LEAST()
-- ============================================================

-- LEAST returns the smallest value
-- among the supplied expressions.

SELECT LEAST(100, 200, 300) AS smallest_value;


-- Apply a maximum salary benchmark.

SELECT
    employee_name,
    salary,
    LEAST(salary, 80000) AS capped_salary
FROM employees;


-- ============================================================
-- 15. PERCENTAGE CALCULATIONS
-- ============================================================

-- Calculate a 10% salary bonus.

SELECT
    employee_name,
    salary,
    ROUND(salary * 0.10, 2) AS bonus
FROM employees;


-- Calculate salary after a 10% increase.

SELECT
    employee_name,
    salary AS current_salary,
    ROUND(salary * 1.10, 2) AS new_salary
FROM employees;


-- Calculate a 5% salary deduction.

SELECT
    employee_name,
    salary,
    ROUND(salary * 0.05, 2) AS deduction
FROM employees;


-- ============================================================
-- 16. NUMERIC FUNCTIONS WITH WHERE
-- ============================================================

-- Find employees with monthly salary above 6000.

SELECT
    employee_name,
    salary,
    ROUND(salary / 12.0, 2) AS monthly_salary
FROM employees
WHERE salary / 12.0 > 6000;


-- Find employees with even employee IDs.

SELECT *
FROM employees
WHERE MOD(employee_id, 2) = 0;


-- ============================================================
-- 17. NUMERIC FUNCTIONS WITH ORDER BY
-- ============================================================

-- Sort employees by monthly salary.

SELECT
    employee_name,
    salary,
    ROUND(salary / 12.0, 2) AS monthly_salary
FROM employees
ORDER BY monthly_salary DESC;


-- Sort employees by absolute difference from 75000.

SELECT
    employee_name,
    salary,
    ABS(salary - 75000) AS salary_difference
FROM employees
ORDER BY salary_difference DESC;


-- ============================================================
-- 18. NUMERIC FUNCTIONS WITH AGGREGATES
-- ============================================================

-- Calculate average salary.

SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;


-- Find highest salary.

SELECT
    MAX(salary) AS highest_salary
FROM employees;


-- Find lowest salary.

SELECT
    MIN(salary) AS lowest_salary
FROM employees;


-- Calculate total salary.

SELECT
    SUM(salary) AS total_salary
FROM employees;


-- ============================================================
-- 19. REAL-WORLD DATA ENGINEERING SCENARIOS
-- ============================================================


-- Example 1: Salary normalization relative to maximum salary.
-- NULLIF protects against division by zero.

SELECT
    employee_name,
    salary,
    ROUND(
        salary::NUMERIC /
        NULLIF((SELECT MAX(salary) FROM employees), 0),
        2
    ) AS normalized_salary
FROM employees;


-- Example 2: Calculate monthly salary.

SELECT
    employee_name,
    salary,
    ROUND(salary / 12.0, 2) AS monthly_salary
FROM employees;


-- Example 3: Apply salary cap of 85000.

SELECT
    employee_name,
    salary,
    LEAST(salary, 85000) AS capped_salary
FROM employees;


-- Example 4: Apply minimum salary threshold of 65000.

SELECT
    employee_name,
    salary,
    GREATEST(salary, 65000) AS minimum_adjusted_salary
FROM employees;


-- Example 5: Calculate percentage difference
-- from a salary benchmark of 75000.

SELECT
    employee_name,
    salary,
    ROUND(
        ((salary - 75000) / 75000.0) * 100,
        2
    ) AS percentage_difference
FROM employees;


-- ============================================================
-- 20. IMPORTANT BEST PRACTICES
-- ============================================================

-- 1. Use ROUND for rounding decimal values.

-- 2. Use TRUNC when decimal digits must be removed
--    without rounding.

-- 3. Use CEIL and FLOOR for upward/downward rounding.

-- 4. Use ABS when only magnitude matters.

-- 5. Use MOD to calculate remainders.

-- 6. Use NULLIF(denominator, 0) to prevent
--    division-by-zero errors.

-- 7. Use NUMERIC for exact decimal calculations
--    such as financial amounts.

-- 8. PostgreSQL integer division truncates decimals.
--    Example: 5 / 2 returns 2.
--    Use 5 / 2.0 for a decimal result.

-- 9. Use GREATEST and LEAST for numeric comparisons.

-- 10. SELECT calculations do not permanently
--     change values in the table.


-- ============================================================
-- 21. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Calculate monthly salary for all employees.

SELECT
    employee_name,
    ROUND(salary / 12.0, 2) AS monthly_salary
FROM employees;


-- Q2. Calculate a 15% salary bonus.

SELECT
    employee_name,
    salary,
    ROUND(salary * 0.15, 2) AS bonus
FROM employees;


-- Q3. Calculate salary after a 20% increase.

SELECT
    employee_name,
    salary,
    ROUND(salary * 1.20, 2) AS new_salary
FROM employees;


-- Q4. Find employees with even employee IDs.

SELECT *
FROM employees
WHERE MOD(employee_id, 2) = 0;


-- Q5. Find employees with odd employee IDs.

SELECT *
FROM employees
WHERE MOD(employee_id, 2) = 1;


-- Q6. Find absolute difference from salary 80000.

SELECT
    employee_name,
    salary,
    ABS(salary - 80000) AS salary_difference
FROM employees;


-- Q7. Calculate average employee salary
-- rounded to two decimal places.

SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;


-- Q8. Apply maximum salary cap of 80000.

SELECT
    employee_name,
    salary,
    LEAST(salary, 80000) AS capped_salary
FROM employees;


-- Q9. Apply minimum salary of 70000.

SELECT
    employee_name,
    salary,
    GREATEST(salary, 70000) AS adjusted_salary
FROM employees;


-- Q10. Calculate salary percentage difference
-- from 70000.

SELECT
    employee_name,
    salary,
    ROUND(
        ((salary - 70000) / 70000.0) * 100,
        2
    ) AS percentage_difference
FROM employees;


-- Q11. Calculate square root of 625.

SELECT SQRT(625) AS square_root;


-- Q12. Calculate 2 raised to the power of 5.

SELECT POWER(2, 5) AS result;


-- Q13. Round salary after a 7.5% increase.

SELECT
    employee_name,
    salary,
    ROUND(salary * 1.075, 2) AS updated_salary
FROM employees;


-- Q14. Find employees whose monthly salary
-- exceeds 5500.

SELECT
    employee_name,
    salary,
    ROUND(salary / 12.0, 2) AS monthly_salary
FROM employees
WHERE salary / 12.0 > 5500;


-- Q15. Calculate employee salary as a percentage
-- of the highest salary.

SELECT
    employee_name,
    salary,
    ROUND(
        salary::NUMERIC * 100 /
        NULLIF((SELECT MAX(salary) FROM employees), 0),
        2
    ) AS percentage_of_highest_salary
FROM employees;

