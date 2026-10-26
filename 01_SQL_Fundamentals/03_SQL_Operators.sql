
-- ============================================================
-- 1. COMPARISON OPERATORS
-- ============================================================

-- Equal to (=)
-- Find employees working in IT
SELECT *
FROM employees
WHERE department = 'IT';

-- Not equal to (<>)
-- Find employees not working in IT
SELECT *
FROM employees
WHERE department <> 'IT';

-- Greater than (>)
-- Find employees earning more than 70000
SELECT *
FROM employees
WHERE salary > 70000;

-- Less than (<)
-- Find employees earning less than 80000
SELECT *
FROM employees
WHERE salary < 80000;

-- Greater than or equal to (>=)
-- Find employees earning 75000 or more
SELECT *
FROM employees
WHERE salary >= 75000;

-- Less than or equal to (<=)
-- Find employees earning 65000 or less
SELECT *
FROM employees
WHERE salary <= 65000;


-- ============================================================
-- 2. LOGICAL OPERATORS
-- ============================================================

-- AND: Both conditions must be TRUE
-- Find IT employees earning more than 80000
SELECT *
FROM employees
WHERE department = 'IT'
AND salary > 80000;

-- OR: At least one condition must be TRUE
-- Find employees working in IT or HR
SELECT *
FROM employees
WHERE department = 'IT'
OR department = 'HR';

-- NOT: Reverses a condition
-- Find employees not working in HR
SELECT *
FROM employees
WHERE NOT department = 'HR';

-- Combining AND and OR
-- Find IT employees earning above 70000 or HR employees earning above 60000
SELECT *
FROM employees
WHERE (department = 'IT' AND salary > 70000)
   OR (department = 'HR' AND salary > 60000);


-- ============================================================
-- 3. BETWEEN OPERATOR
-- ============================================================

-- BETWEEN includes both boundary values
-- Find employees earning between 60000 and 80000
SELECT *
FROM employees
WHERE salary BETWEEN 60000 AND 80000;

-- NOT BETWEEN
-- Find employees earning outside 60000 to 80000
SELECT *
FROM employees
WHERE salary NOT BETWEEN 60000 AND 80000;


-- ============================================================
-- 4. IN OPERATOR
-- ============================================================

-- IN checks multiple values
-- Find employees working in IT or Finance
SELECT *
FROM employees
WHERE department IN ('IT', 'Finance');

-- NOT IN
-- Find employees not working in IT or HR
SELECT *
FROM employees
WHERE department NOT IN ('IT', 'HR');


-- ============================================================
-- 5. LIKE OPERATOR
-- ============================================================

-- % represents zero or more characters
-- _ represents exactly one character

-- Names starting with A
SELECT *
FROM employees
WHERE employee_name LIKE 'A%';

-- Names ending with a
SELECT *
FROM employees
WHERE employee_name LIKE '%a';

-- Names containing 'li'
SELECT *
FROM employees
WHERE employee_name LIKE '%li%';

-- Names where the second character is 'o'
SELECT *
FROM employees
WHERE employee_name LIKE '_o%';

-- ILIKE: Case-insensitive pattern matching in PostgreSQL
-- Find names starting with A or a
SELECT *
FROM employees
WHERE employee_name ILIKE 'a%';


-- ============================================================
-- 6. NULL OPERATORS
-- ============================================================

-- IS NULL
-- Find employees whose department is NULL
SELECT *
FROM employees
WHERE department IS NULL;

-- IS NOT NULL
-- Find employees whose department is not NULL
SELECT *
FROM employees
WHERE department IS NOT NULL;


-- ============================================================
-- 7. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================

-- Q1. Find employees earning more than 65000
SELECT *
FROM employees
WHERE salary > 65000;

-- Q2. Find employees working in Finance
SELECT *
FROM employees
WHERE department = 'Finance';

-- Q3. Find employees not working in IT
SELECT *
FROM employees
WHERE department <> 'IT';

-- Q4. Find employees earning between 60000 and 75000
SELECT *
FROM employees
WHERE salary BETWEEN 60000 AND 75000;

-- Q5. Find employees working in HR or Finance
SELECT *
FROM employees
WHERE department IN ('HR', 'Finance');

-- Q6. Find employees whose names start with D
SELECT *
FROM employees
WHERE employee_name LIKE 'D%';

-- Q7. Find IT employees earning at least 75000
SELECT *
FROM employees
WHERE department = 'IT'
AND salary >= 75000;

