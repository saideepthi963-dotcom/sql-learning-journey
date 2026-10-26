
-- ============================================================
-- 1. INTRODUCTION TO CASE
-- ============================================================

-- CASE is used to implement conditional logic in SQL.
-- It works similarly to IF-ELSE statements in programming.
-- CASE returns a value based on the first matching condition.
-- If no condition matches, ELSE provides a default value.
-- If ELSE is omitted and no condition matches, NULL is returned.

-- Basic Syntax:
--
-- CASE
--     WHEN condition1 THEN result1
--     WHEN condition2 THEN result2
--     ELSE default_result
-- END


-- ============================================================
-- 2. SIMPLE CASE EXPRESSION
-- ============================================================

-- A simple CASE compares one expression against values.

-- Assign department descriptions.
SELECT
    employee_name,
    department,
    CASE department
        WHEN 'IT' THEN 'Information Technology'
        WHEN 'HR' THEN 'Human Resources'
        WHEN 'Finance' THEN 'Finance Department'
        ELSE 'Other Department'
    END AS department_description
FROM employees;


-- ============================================================
-- 3. SEARCHED CASE EXPRESSION
-- ============================================================

-- A searched CASE evaluates conditions using WHEN.

-- Categorize employees based on salary.
SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 80000 THEN 'High Salary'
        WHEN salary >= 65000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM employees;


-- ============================================================
-- 4. CASE WITH MULTIPLE CONDITIONS
-- ============================================================

-- Classify employees based on department and salary.

SELECT
    employee_name,
    department,
    salary,
    CASE
        WHEN department = 'IT' AND salary >= 80000
            THEN 'Senior IT Employee'
        WHEN department = 'IT' AND salary < 80000
            THEN 'IT Employee'
        WHEN department = 'HR'
            THEN 'HR Employee'
        ELSE 'Other Employee'
    END AS employee_category
FROM employees;


-- ============================================================
-- 5. CASE WITH COMPARISON OPERATORS
-- ============================================================

-- Determine salary levels.

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary > 80000 THEN 'Above 80K'
        WHEN salary = 80000 THEN 'Exactly 80K'
        WHEN salary < 80000 THEN 'Below 80K'
        ELSE 'Unknown'
    END AS salary_status
FROM employees;


-- ============================================================
-- 6. CASE WITH BETWEEN
-- ============================================================

-- Categorize employees using salary ranges.

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary BETWEEN 80000 AND 100000
            THEN 'High Income'
        WHEN salary BETWEEN 65000 AND 79999
            THEN 'Medium Income'
        WHEN salary < 65000
            THEN 'Low Income'
        ELSE 'Other'
    END AS income_category
FROM employees;


-- ============================================================
-- 7. CASE WITH IN OPERATOR
-- ============================================================

-- Group departments into business categories.

SELECT
    employee_name,
    department,
    CASE
        WHEN department IN ('IT', 'Finance')
            THEN 'Technical or Financial'
        WHEN department IN ('HR')
            THEN 'Human Resources'
        ELSE 'Other'
    END AS department_group
FROM employees;


-- ============================================================
-- 8. CASE WITH ORDER BY
-- ============================================================

-- Assign custom sorting priority to departments.

-- IT employees first.
-- Finance employees second.
-- HR employees third.

SELECT
    employee_name,
    department,
    salary
FROM employees
ORDER BY
    CASE
        WHEN department = 'IT' THEN 1
        WHEN department = 'Finance' THEN 2
        WHEN department = 'HR' THEN 3
        ELSE 4
    END,
    salary DESC;


-- ============================================================
-- 9. CASE WITH CALCULATIONS
-- ============================================================

-- Calculate bonuses based on department.

-- IT employees receive a 10% bonus.
-- Finance employees receive an 8% bonus.
-- HR employees receive a 5% bonus.

SELECT
    employee_name,
    department,
    salary,
    CASE
        WHEN department = 'IT' THEN salary * 0.10
        WHEN department = 'Finance' THEN salary * 0.08
        WHEN department = 'HR' THEN salary * 0.05
        ELSE 0
    END AS bonus
FROM employees;


-- Calculate updated salary after bonus.

SELECT
    employee_name,
    department,
    salary AS current_salary,
    salary +
    CASE
        WHEN department = 'IT' THEN salary * 0.10
        WHEN department = 'Finance' THEN salary * 0.08
        WHEN department = 'HR' THEN salary * 0.05
        ELSE 0
    END AS updated_salary
FROM employees;


-- ============================================================
-- 10. CASE WITH AGGREGATE FUNCTIONS
-- ============================================================

-- Count employees earning at least 75000.

SELECT
    COUNT(
        CASE
            WHEN salary >= 75000 THEN 1
        END
    ) AS high_salary_employees
FROM employees;


-- Count employees in each department using conditional logic.

SELECT
    SUM(CASE WHEN department = 'IT' THEN 1 ELSE 0 END)
        AS it_employees,

    SUM(CASE WHEN department = 'HR' THEN 1 ELSE 0 END)
        AS hr_employees,

    SUM(CASE WHEN department = 'Finance' THEN 1 ELSE 0 END)
        AS finance_employees
FROM employees;


-- ============================================================
-- 11. CASE WITH GROUP BY
-- ============================================================

-- Count employees in each salary category.

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
-- 12. CASE WITH NULL VALUES
-- ============================================================

-- Handle missing department information.

SELECT
    employee_name,
    department,
    CASE
        WHEN department IS NULL THEN 'Department Not Assigned'
        ELSE department
    END AS department_status
FROM employees;


-- ============================================================
-- 13. NESTED CASE EXPRESSIONS
-- ============================================================

-- A CASE expression can contain another CASE expression.

SELECT
    employee_name,
    department,
    salary,
    CASE
        WHEN department = 'IT' THEN
            CASE
                WHEN salary >= 80000 THEN 'Senior IT'
                ELSE 'Junior IT'
            END

        WHEN department = 'HR' THEN
            CASE
                WHEN salary >= 65000 THEN 'Senior HR'
                ELSE 'Junior HR'
            END

        ELSE 'Other Department'
    END AS employee_level
FROM employees;


-- ============================================================
-- 14. CASE WITH WHERE
-- ============================================================

-- CASE can return a value that is filtered using WHERE.

-- Find employees classified as High or Medium salary.

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 65000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM employees
WHERE salary >= 65000;


-- Note:
-- A SELECT alias cannot generally be used directly
-- in the WHERE clause of the same query.
-- A subquery or CTE can be used for this purpose.

SELECT *
FROM (
    SELECT
        employee_name,
        salary,
        CASE
            WHEN salary >= 80000 THEN 'High'
            WHEN salary >= 65000 THEN 'Medium'
            ELSE 'Low'
        END AS salary_category
    FROM employees
) AS employee_categories
WHERE salary_category = 'High';


-- ============================================================
-- 15. IMPORTANT BEST PRACTICES
-- ============================================================

-- 1. CASE evaluates WHEN conditions in order.

-- 2. The first matching WHEN determines the result.

-- 3. Use ELSE to handle unmatched conditions.

-- 4. Use END to close every CASE expression.

-- 5. Simple CASE compares an expression with values.

-- 6. Searched CASE supports complex conditions.

-- 7. CASE can be used in SELECT, ORDER BY, WHERE,
--    GROUP BY, and aggregate expressions.

-- 8. CASE does not permanently modify table data
--    when used in a SELECT query.

-- 9. Place more specific conditions before general ones.

-- 10. Prefer simple, readable CASE expressions
--     over unnecessarily complex nested conditions.


-- ============================================================
-- 16. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Categorize employees as High or Low salary.
-- High salary means salary >= 75000.

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 75000 THEN 'High'
        ELSE 'Low'
    END AS salary_category
FROM employees;


-- Q2. Display department full names.

SELECT
    employee_name,
    CASE department
        WHEN 'IT' THEN 'Information Technology'
        WHEN 'HR' THEN 'Human Resources'
        WHEN 'Finance' THEN 'Finance Department'
        ELSE 'Other'
    END AS department_name
FROM employees;


-- Q3. Give IT employees a 10% salary increase.
-- Give all other employees a 5% increase.

SELECT
    employee_name,
    department,
    salary,
    CASE
        WHEN department = 'IT' THEN salary * 1.10
        ELSE salary * 1.05
    END AS new_salary
FROM employees;


-- Q4. Categorize employees into three salary levels.

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 65000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_level
FROM employees;


-- Q5. Count employees earning above 70000.

SELECT
    SUM(
        CASE
            WHEN salary > 70000 THEN 1
            ELSE 0
        END
    ) AS employees_above_70k
FROM employees;


-- Q6. Assign department priorities.
-- IT = 1, Finance = 2, HR = 3.

SELECT
    employee_name,
    department,
    CASE
        WHEN department = 'IT' THEN 1
        WHEN department = 'Finance' THEN 2
        WHEN department = 'HR' THEN 3
        ELSE 4
    END AS department_priority
FROM employees;


-- Q7. Categorize salaries as Above Average or
-- Below or Equal to Average.

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary > (SELECT AVG(salary) FROM employees)
            THEN 'Above Average'
        ELSE 'Below or Equal to Average'
    END AS salary_status
FROM employees;


-- Q8. Find employees eligible for a bonus.
-- Employees earning below 70000 are eligible.

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary < 70000 THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS bonus_eligibility
FROM employees;


-- Q9. Calculate bonus based on salary.
-- Salary >= 80000: 10%
-- Salary >= 65000: 7%
-- Otherwise: 5%

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 80000 THEN salary * 0.10
        WHEN salary >= 65000 THEN salary * 0.07
        ELSE salary * 0.05
    END AS bonus_amount
FROM employees;


-- Q10. Count High, Medium, and Low salary employees.

SELECT
    SUM(CASE WHEN salary >= 80000 THEN 1 ELSE 0 END)
        AS high_salary_count,

    SUM(CASE WHEN salary >= 65000 AND salary < 80000
             THEN 1 ELSE 0 END)
        AS medium_salary_count,

    SUM(CASE WHEN salary < 65000 THEN 1 ELSE 0 END)
        AS low_salary_count
FROM employees;
