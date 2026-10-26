
-- ============================================================
-- 1. INTRODUCTION TO STRING FUNCTIONS
-- ============================================================

-- String functions manipulate text values.
-- They are commonly used for:
-- 1. Data cleaning
-- 2. Text formatting
-- 3. Extracting information
-- 4. Standardizing data
-- 5. Data transformation in ETL pipelines


-- ============================================================
-- 2. UPPER()
-- ============================================================

-- Converts text to uppercase.

SELECT
    employee_name,
    UPPER(employee_name) AS uppercase_name
FROM employees;


-- Convert department names to uppercase.

SELECT
    department,
    UPPER(department) AS uppercase_department
FROM employees;


-- ============================================================
-- 3. LOWER()
-- ============================================================

-- Converts text to lowercase.

SELECT
    employee_name,
    LOWER(employee_name) AS lowercase_name
FROM employees;


-- Convert department names to lowercase.

SELECT
    department,
    LOWER(department) AS lowercase_department
FROM employees;


-- ============================================================
-- 4. INITCAP()
-- ============================================================

-- Capitalizes the first letter of each word.

SELECT
    employee_name,
    INITCAP(employee_name) AS formatted_name
FROM employees;


-- Example with text.

SELECT INITCAP('john smith') AS formatted_name;


-- ============================================================
-- 5. LENGTH()
-- ============================================================

-- Returns the number of characters in a string.

SELECT
    employee_name,
    LENGTH(employee_name) AS name_length
FROM employees;


-- Find employees whose names contain more than 4 characters.

SELECT *
FROM employees
WHERE LENGTH(employee_name) > 4;


-- ============================================================
-- 6. TRIM()
-- ============================================================

-- Removes leading and trailing spaces.

SELECT
    TRIM('   Alice   ') AS cleaned_name;


-- Remove spaces from employee names.

SELECT
    employee_name,
    TRIM(employee_name) AS cleaned_name
FROM employees;


-- ============================================================
-- 7. LTRIM()
-- ============================================================

-- Removes leading spaces.

SELECT
    LTRIM('   Alice') AS cleaned_name;


-- ============================================================
-- 8. RTRIM()
-- ============================================================

-- Removes trailing spaces.

SELECT
    RTRIM('Alice   ') AS cleaned_name;


-- ============================================================
-- 9. SUBSTRING()
-- ============================================================

-- Extracts part of a string.

-- Syntax:
-- SUBSTRING(string FROM start_position FOR length)

-- Extract the first 3 characters of employee names.

SELECT
    employee_name,
    SUBSTRING(employee_name FROM 1 FOR 3) AS short_name
FROM employees;


-- Extract the first 2 characters of department names.

SELECT
    department,
    SUBSTRING(department FROM 1 FOR 2) AS department_code
FROM employees;


-- ============================================================
-- 10. LEFT()
-- ============================================================

-- Extracts characters from the beginning of a string.

SELECT
    employee_name,
    LEFT(employee_name, 3) AS first_three_letters
FROM employees;


-- ============================================================
-- 11. RIGHT()
-- ============================================================

-- Extracts characters from the end of a string.

SELECT
    employee_name,
    RIGHT(employee_name, 2) AS last_two_letters
FROM employees;


-- ============================================================
-- 12. REPLACE()
-- ============================================================

-- Replaces occurrences of text with another value.

SELECT
    REPLACE('Data Engineer', 'Engineer', 'Analyst')
        AS updated_text;


-- Replace IT with Technology.

SELECT
    department,
    REPLACE(department, 'IT', 'Technology')
        AS updated_department
FROM employees;


-- ============================================================
-- 13. CONCAT()
-- ============================================================

-- Combines multiple strings.

SELECT
    CONCAT(employee_name, ' - ', department)
        AS employee_details
FROM employees;


-- Combine employee name and salary.

SELECT
    CONCAT(employee_name, ' earns ', salary)
        AS employee_salary_details
FROM employees;


-- ============================================================
-- 14. CONCATENATION OPERATOR (||)
-- ============================================================

-- PostgreSQL uses || to concatenate strings.

SELECT
    employee_name || ' works in ' || department
        AS employee_info
FROM employees;


-- Note:
-- CONCAT() treats NULL arguments as empty strings.
-- The || operator returns NULL if either operand is NULL.


-- ============================================================
-- 15. POSITION()
-- ============================================================

-- Finds the position of a substring.
-- PostgreSQL positions start at 1.
-- Returns 0 when the substring is not found.

SELECT
    POSITION('a' IN 'Data Engineering')
        AS character_position;


-- Find the position of 'a' in employee names.

SELECT
    employee_name,
    POSITION('a' IN LOWER(employee_name)) AS position_of_a
FROM employees;


-- ============================================================
-- 16. SPLIT_PART()
-- ============================================================

-- Splits a string using a delimiter.
-- Returns the selected part.
-- Part numbering starts at 1.

SELECT
    SPLIT_PART('alice@gmail.com', '@', 1) AS username,
    SPLIT_PART('alice@gmail.com', '@', 2) AS domain;


-- Extract words from a sample string.

SELECT
    SPLIT_PART('Data-Engineering-SQL', '-', 2)
        AS extracted_word;


-- ============================================================
-- 17. REPEAT()
-- ============================================================

-- Repeats a string a specified number of times.

SELECT
    REPEAT('SQL ', 3) AS repeated_text;


-- ============================================================
-- 18. REVERSE()
-- ============================================================

-- Reverses the characters in a string.

SELECT
    employee_name,
    REVERSE(employee_name) AS reversed_name
FROM employees;


-- ============================================================
-- 19. LPAD()
-- ============================================================

-- Pads a string on the left to a specified length.

-- Convert employee IDs to 5-character strings,
-- adding leading zeros where required.

SELECT
    employee_id,
    LPAD(employee_id::TEXT, 5, '0') AS formatted_id
FROM employees;


-- ============================================================
-- 20. RPAD()
-- ============================================================

-- Pads a string on the right to a specified length.

SELECT
    employee_name,
    RPAD(employee_name, 12, '.') AS formatted_name
FROM employees;


-- ============================================================
-- 21. STRING_AGG()
-- ============================================================

-- Combines multiple row values into one string.
-- Often used with GROUP BY.

-- Display employee names grouped by department.

SELECT
    department,
    STRING_AGG(employee_name, ', ' ORDER BY employee_name)
        AS employee_names
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 22. REGEXP_REPLACE()
-- ============================================================

-- Replaces text matching a regular expression.
-- Useful for advanced data cleaning.

-- Remove all digits from a string.

SELECT
    REGEXP_REPLACE('Employee123', '[0-9]', '', 'g')
        AS cleaned_text;


-- Remove special characters from sample text.

SELECT
    REGEXP_REPLACE('Alice@#123', '[^a-zA-Z0-9]', '', 'g')
        AS cleaned_text;


-- ============================================================
-- 23. STRING FUNCTIONS WITH WHERE
-- ============================================================

-- Find employees whose names start with A.

SELECT *
FROM employees
WHERE LEFT(employee_name, 1) = 'A';


-- Find employees whose names contain 'a',
-- ignoring case.

SELECT *
FROM employees
WHERE LOWER(employee_name) LIKE '%a%';


-- Find employees with names longer than 5 characters.

SELECT *
FROM employees
WHERE LENGTH(employee_name) > 5;


-- ============================================================
-- 24. STRING FUNCTIONS WITH ORDER BY
-- ============================================================

-- Sort employees by name length.

SELECT
    employee_name,
    LENGTH(employee_name) AS name_length
FROM employees
ORDER BY name_length DESC, employee_name;


-- Sort employees alphabetically without case sensitivity.

SELECT *
FROM employees
ORDER BY LOWER(employee_name);


-- ============================================================
-- 25. HANDLING NULL VALUES
-- ============================================================

-- COALESCE returns the first non-NULL value.

SELECT
    employee_name,
    COALESCE(department, 'Unknown') AS department_name
FROM employees;


-- NULLIF returns NULL when both arguments are equal.

SELECT
    NULLIF('IT', 'IT') AS result;


-- Replace empty strings with NULL.

SELECT
    NULLIF('', '') AS cleaned_value;


-- Combine NULLIF and COALESCE.

SELECT
    COALESCE(NULLIF(TRIM('   '), ''), 'Unknown')
        AS cleaned_value;


-- ============================================================
-- 26. REAL-WORLD DATA ENGINEERING EXAMPLES
-- ============================================================

-- Example 1: Standardize employee names.

SELECT
    employee_id,
    INITCAP(TRIM(employee_name)) AS standardized_name
FROM employees;


-- Example 2: Standardize department names.

SELECT
    employee_id,
    UPPER(TRIM(department)) AS standardized_department
FROM employees;


-- Example 3: Generate employee email addresses.

SELECT
    employee_id,
    employee_name,
    LOWER(
        REPLACE(TRIM(employee_name), ' ', '.')
    ) || '@company.com' AS generated_email
FROM employees;


-- Example 4: Generate formatted employee identifiers.

SELECT
    employee_id,
    'EMP-' || LPAD(employee_id::TEXT, 5, '0')
        AS formatted_employee_id
FROM employees;


-- Example 5: Create a combined employee description.

SELECT
    CONCAT(
        employee_name,
        ' belongs to ',
        department,
        ' department'
    ) AS employee_description
FROM employees;


-- ============================================================
-- 27. IMPORTANT BEST PRACTICES
-- ============================================================

-- 1. Use TRIM() to remove unnecessary surrounding spaces.

-- 2. Use LOWER() or UPPER() to standardize text.

-- 3. Use SUBSTRING(), LEFT(), and RIGHT()
--    to extract portions of strings.

-- 4. Use REPLACE() to substitute text values.

-- 5. Use CONCAT() or || to combine strings.

-- 6. Use SPLIT_PART() to extract values from delimited text.

-- 7. Use REGEXP_REPLACE() for pattern-based data cleaning.

-- 8. Use COALESCE() to handle NULL values.

-- 9. Be careful when applying functions in WHERE clauses.
--    They may prevent ordinary indexes from being used
--    efficiently unless suitable expression indexes exist.

-- 10. String functions in SELECT queries do not permanently
--     modify values stored in the database.


-- ============================================================
-- 28. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Convert all employee names to uppercase.

SELECT
    employee_name,
    UPPER(employee_name) AS uppercase_name
FROM employees;


-- Q2. Convert all department names to lowercase.

SELECT
    department,
    LOWER(department) AS lowercase_department
FROM employees;


-- Q3. Find the length of each employee name.

SELECT
    employee_name,
    LENGTH(employee_name) AS name_length
FROM employees;


-- Q4. Extract the first three letters of employee names.

SELECT
    employee_name,
    LEFT(employee_name, 3) AS short_name
FROM employees;


-- Q5. Extract the last two letters of employee names.

SELECT
    employee_name,
    RIGHT(employee_name, 2) AS last_two_letters
FROM employees;


-- Q6. Combine employee name and department.

SELECT
    CONCAT(employee_name, ' - ', department)
        AS employee_details
FROM employees;


-- Q7. Find employees whose names contain the letter A,
-- ignoring case.

SELECT *
FROM employees
WHERE LOWER(employee_name) LIKE '%a%';


-- Q8. Find employees whose names are longer than 4 characters.

SELECT *
FROM employees
WHERE LENGTH(employee_name) > 4;


-- Q9. Generate employee email addresses.

SELECT
    employee_name,
    LOWER(
        REPLACE(TRIM(employee_name), ' ', '.')
    ) || '@company.com' AS email
FROM employees;


-- Q10. Generate employee IDs with leading zeros.

SELECT
    employee_id,
    LPAD(employee_id::TEXT, 6, '0') AS formatted_id
FROM employees;


-- Q11. Replace IT with Information Technology.

SELECT
    department,
    REPLACE(department, 'IT', 'Information Technology')
        AS updated_department
FROM employees;


-- Q12. Remove leading and trailing spaces from text.

SELECT
    TRIM('   Data Engineering   ') AS cleaned_text;


-- Q13. Extract the domain from an email address.

SELECT
    SPLIT_PART('alice@gmail.com', '@', 2)
        AS email_domain;


-- Q14. Reverse employee names.

SELECT
    employee_name,
    REVERSE(employee_name) AS reversed_name
FROM employees;


-- Q15. Display employee names grouped by department.

SELECT
    department,
    STRING_AGG(employee_name, ', ' ORDER BY employee_name)
        AS employee_names
FROM employees
GROUP BY department
ORDER BY department;
