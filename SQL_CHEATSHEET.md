# SQL MASTER CHEAT SHEET

**Database:** PostgreSQL  
**Focus:** SQL Fundamentals, Interview Preparation & Data Engineering

A quick-reference guide covering essential SQL syntax, functions, and commonly used queries.

---

# 1. SELECT & FROM

**Purpose:** Retrieve data from a table.

```sql
-- Select all columns
SELECT *
FROM employees;

-- Select specific columns
SELECT employee_name, salary
FROM employees;
```

| Keyword | Purpose |
|---|---|
| SELECT | Specifies columns |
| FROM | Specifies the source table |
| * | Selects all columns |

---

# 2. WHERE CLAUSE

**Purpose:** Filter rows based on conditions.

```sql
SELECT *
FROM employees
WHERE salary > 70000;
```

### Comparison Operators

| Operator | Meaning |
|---|---|
| = | Equal |
| <> | Not equal |
| > | Greater than |
| < | Less than |
| >= | Greater than or equal |
| <= | Less than or equal |

### Logical Operators

```sql
-- AND
WHERE department = 'IT' AND salary > 70000

-- OR
WHERE department = 'IT' OR department = 'HR'

-- NOT
WHERE NOT department = 'IT'
```

### Other Filtering Operators

```sql
-- BETWEEN (inclusive)
WHERE salary BETWEEN 60000 AND 80000

-- IN
WHERE department IN ('IT', 'HR')

-- NOT IN
WHERE department NOT IN ('IT', 'HR')

-- LIKE
WHERE employee_name LIKE 'A%'

-- Case-insensitive search in PostgreSQL
WHERE employee_name ILIKE 'a%'

-- NULL checks
WHERE department IS NULL
WHERE department IS NOT NULL
```

**Important:** Use `IS NULL`, not `= NULL`.

---

# 3. ORDER BY

**Purpose:** Sort query results.

```sql
-- Ascending
SELECT *
FROM employees
ORDER BY salary ASC;

-- Descending
SELECT *
FROM employees
ORDER BY salary DESC;

-- Multiple columns
SELECT *
FROM employees
ORDER BY department ASC, salary DESC;
```

| Keyword | Meaning |
|---|---|
| ASC | Ascending (default) |
| DESC | Descending |
| NULLS FIRST | Place NULL values first |
| NULLS LAST | Place NULL values last |

---

# 4. DISTINCT

**Purpose:** Return unique values or combinations.

```sql
-- Unique departments
SELECT DISTINCT department
FROM employees;

-- Unique combinations
SELECT DISTINCT department, salary
FROM employees;

-- Count unique non-NULL departments
SELECT COUNT(DISTINCT department)
FROM employees;
```

**Remember:** `DISTINCT` does not remove records from the underlying table.

### PostgreSQL DISTINCT ON

```sql
-- Highest-paid employee per department
SELECT DISTINCT ON (department)
    department,
    employee_name,
    salary
FROM employees
ORDER BY department, salary DESC, employee_id;
```

---

# 5. LIMIT & OFFSET

**Purpose:** Control the number of returned rows.

```sql
-- First 5 employees
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 5;

-- Skip 5 rows and return the next 5
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 5 OFFSET 5;

-- Highest-paid employee
SELECT *
FROM employees
ORDER BY salary DESC, employee_id
LIMIT 1;
```

### Pagination Formula

`OFFSET = (Page Number - 1) × Page Size`

**Important:** Always use a deterministic `ORDER BY` when paginating.

---

# 6. COLUMN & TABLE ALIASES

**Purpose:** Assign temporary names to columns or tables.

```sql
-- Column aliases
SELECT
    employee_name AS name,
    salary AS annual_salary
FROM employees;

-- Table alias
SELECT
    e.employee_name,
    e.salary
FROM employees AS e;

-- Alias containing spaces
SELECT employee_name AS "Employee Name"
FROM employees;
```

**Remember:** Aliases don't permanently rename database columns.

PostgreSQL allows output aliases in `ORDER BY`, but generally not in `WHERE` at the same query level.

---

# 7. CASE EXPRESSIONS

**Purpose:** Apply conditional logic.

### Basic Syntax

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
```

### Salary Classification

```sql
SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 65000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM employees;
```

### Conditional Aggregation

```sql
SELECT
    SUM(CASE WHEN department = 'IT' THEN 1 ELSE 0 END)
        AS it_employees
FROM employees;
```

**Remember:** `CASE` returns the result associated with the first matching `WHEN` condition.

---

# 8. STRING FUNCTIONS

**Purpose:** Clean, transform, format, and extract text.

| Function | Purpose | Example |
|---|---|---|
| UPPER() | Uppercase | `UPPER('sql')` |
| LOWER() | Lowercase | `LOWER('SQL')` |
| INITCAP() | Capitalize words | `INITCAP('john smith')` |
| LENGTH() | Character count | `LENGTH('SQL')` |
| TRIM() | Remove surrounding spaces | `TRIM(' SQL ')` |
| LTRIM() | Remove leading spaces | `LTRIM(' SQL')` |
| RTRIM() | Remove trailing spaces | `RTRIM('SQL ')` |
| LEFT() | Extract from left | `LEFT('PostgreSQL', 4)` |
| RIGHT() | Extract from right | `RIGHT('PostgreSQL', 3)` |
| SUBSTRING() | Extract substring | `SUBSTRING('SQL' FROM 1 FOR 2)` |
| REPLACE() | Replace text | `REPLACE('Data Analyst', 'Analyst', 'Engineer')` |
| CONCAT() | Combine strings | `CONCAT('Data', ' Engineer')` |
| POSITION() | Find position | `POSITION('Q' IN 'SQL')` |
| SPLIT_PART() | Split text | `SPLIT_PART('a@b.com', '@', 2)` |
| REVERSE() | Reverse text | `REVERSE('SQL')` |
| LPAD() | Pad on left | `LPAD('10', 5, '0')` |
| RPAD() | Pad on right | `RPAD('SQL', 5, '.')` |
| STRING_AGG() | Combine row values | `STRING_AGG(employee_name, ', ')` |
| REGEXP_REPLACE() | Pattern-based replacement | `REGEXP_REPLACE('A123', '[0-9]', '', 'g')` |

### Common Data Engineering Queries

```sql
-- Standardize names
SELECT INITCAP(TRIM(employee_name)) AS clean_name
FROM employees;

-- Generate email-style identifiers
SELECT
    LOWER(REPLACE(employee_name, ' ', '.'))
        || '@company.com' AS email
FROM employees;

-- Generate formatted employee IDs
SELECT
    'EMP-' || LPAD(employee_id::TEXT, 5, '0') AS formatted_id
FROM employees;
```

---

# 9. NUMERIC FUNCTIONS

**Purpose:** Perform mathematical calculations.

### Arithmetic Operators

| Operator | Meaning |
|---|---|
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |
| % | Modulus |

### Numeric Functions

| Function | Purpose | Example | Result |
|---|---|---|---|
| ROUND() | Round decimal | `ROUND(12.567, 2)` | 12.57 |
| CEIL() | Round upward | `CEIL(12.3)` | 13 |
| FLOOR() | Round downward | `FLOOR(12.9)` | 12 |
| ABS() | Absolute value | `ABS(-20)` | 20 |
| MOD() | Remainder | `MOD(10, 3)` | 1 |
| POWER() | Exponentiation | `POWER(2, 3)` | 8 |
| SQRT() | Square root | `SQRT(25)` | 5 |
| SIGN() | Number sign | `SIGN(-10)` | -1 |
| TRUNC() | Truncate decimals | `TRUNC(12.567, 2)` | 12.56 |
| GREATEST() | Largest argument | `GREATEST(10, 20)` | 20 |
| LEAST() | Smallest argument | `LEAST(10, 20)` | 10 |
| RANDOM() | Random number | `RANDOM()` | 0 ≤ x < 1 |

### Salary Calculations

```sql
-- Monthly salary
SELECT
    employee_name,
    ROUND(salary / 12.0, 2) AS monthly_salary
FROM employees;

-- 10% salary increase
SELECT
    employee_name,
    salary * 1.10 AS increased_salary
FROM employees;

-- Absolute salary difference
SELECT
    employee_name,
    ABS(salary - 75000) AS difference
FROM employees;
```

### Division by Zero

```sql
SELECT
    salary::NUMERIC / NULLIF(0, 0) AS result
FROM employees;
```

`NULLIF(denominator, 0)` prevents division by zero by returning NULL when the denominator is zero.

---

# 10. COMMON SQL QUERY EXECUTION ORDER

### Written SQL Order

```sql
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
WHERE salary > 60000
GROUP BY department
HAVING COUNT(*) > 1
ORDER BY employee_count DESC
LIMIT 5;
```

### Logical Processing Order

| Step | Clause | Purpose |
|---|---|---|
| 1 | FROM | Identify source data |
| 2 | WHERE | Filter rows |
| 3 | GROUP BY | Form groups |
| 4 | HAVING | Filter groups |
| 5 | SELECT | Calculate output expressions |
| 6 | DISTINCT | Remove duplicate output rows |
| 7 | ORDER BY | Sort results |
| 8 | LIMIT / OFFSET | Restrict returned rows |

This is a simplified logical model; the database optimizer may execute physical operations differently.

---

# 11. IMPORTANT INTERVIEW DIFFERENCES

| Concept A | Concept B | Difference |
|---|---|---|
| WHERE | HAVING | Filters rows vs groups |
| DISTINCT | GROUP BY | Removes duplicate results vs groups records for aggregation |
| LIMIT | OFFSET | Limits rows vs skips rows |
| ROUND | TRUNC | Rounds values vs removes digits |
| CEIL | FLOOR | Rounds toward positive vs negative infinity |
| GREATEST | MAX | Compares expressions vs aggregates rows |
| LEAST | MIN | Compares expressions vs aggregates rows |
| LIKE | ILIKE | Case-sensitive vs case-insensitive matching in PostgreSQL |
| COUNT(*) | COUNT(column) | Counts all rows vs non-NULL column values |
| AS | Permanent rename | Temporary query alias vs schema change |

---

# 12. SQL BEST PRACTICES

1. Use meaningful column and table names.
2. Avoid `SELECT *` in production queries when only specific columns are required.
3. Use `WHERE` to filter unnecessary rows.
4. Use `ORDER BY` when result ordering matters.
5. Handle NULL values correctly.
6. Use `NUMERIC` for exact financial calculations.
7. Protect against division by zero.
8. Use aliases to improve readability.
9. Format SQL consistently.
10. Understand the difference between SQL dialects.

---
---

# 13. DATE AND TIME FUNCTIONS

**Purpose:** Work with dates, timestamps, intervals, and time-based calculations in PostgreSQL.

## Date and Time Data Types

| Data Type | Purpose |
|---|---|
| DATE | Stores calendar dates |
| TIME | Stores time without time zone |
| TIMESTAMP | Stores date and time without time zone |
| TIMESTAMPTZ | Stores a time zone-aware instant |
| INTERVAL | Represents a duration |

## Current Date and Time

| Function | Purpose |
|---|---|
| `CURRENT_DATE` | Current date |
| `CURRENT_TIME` | Current time with time zone |
| `NOW()` | Current transaction timestamp |
| `CURRENT_TIMESTAMP` | Current transaction timestamp |
| `LOCALTIME` | Current time without time zone |
| `LOCALTIMESTAMP` | Current timestamp without time zone |

## Date Functions

| Function | Purpose | Example |
|---|---|---|
| `EXTRACT()` | Extract date component | `EXTRACT(YEAR FROM CURRENT_DATE)` |
| `DATE_PART()` | Extract date component | `DATE_PART('month', CURRENT_DATE)` |
| `DATE_TRUNC()` | Truncate to time boundary | `DATE_TRUNC('month', NOW())` |
| `AGE()` | Calculate symbolic interval | `AGE(CURRENT_DATE, DATE '2020-01-01')` |
| `TO_CHAR()` | Format date as text | `TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD')` |
| `TO_DATE()` | Convert text to date | `TO_DATE('26-10-2026', 'DD-MM-YYYY')` |
| `TO_TIMESTAMP()` | Convert text to timestamp | `TO_TIMESTAMP('2026-10-26', 'YYYY-MM-DD')` |

## Date Arithmetic

```sql
-- Add 7 days
SELECT CURRENT_DATE + 7;

-- Subtract 30 days
SELECT CURRENT_DATE - 30;

-- Add 3 months
SELECT CURRENT_DATE + INTERVAL '3 months';

-- Difference between dates in days
SELECT DATE '2026-10-26' - DATE '2026-10-01';
```

## DATE_TRUNC Examples

```sql
SELECT DATE_TRUNC('day', NOW());

SELECT DATE_TRUNC('week', NOW());

SELECT DATE_TRUNC('month', NOW());

SELECT DATE_TRUNC('year', NOW());
```

## Date Filtering

```sql
-- Filter records in a date range
SELECT *
FROM orders
WHERE order_date >= DATE '2026-10-01'
  AND order_date < DATE '2026-11-01';
```

*Requires an `orders` table.*

## Data Engineering Applications

| Scenario | Function |
|---|---|
| ETL processing timestamp | `CURRENT_TIMESTAMP` |
| Daily processing date | `CURRENT_DATE` |
| Monthly reporting | `DATE_TRUNC('month', timestamp_column)` |
| Extract year or month | `EXTRACT()` |
| Incremental loading | Timestamp ranges and watermarks |
| Date formatting | `TO_CHAR()` |
| Convert date strings | `TO_DATE()` |
| Calculate elapsed time | Date subtraction or `AGE()` |

## Interview Tips

**CURRENT_DATE vs NOW():** CURRENT_DATE returns a date; NOW() returns a timestamp with time zone.

**EXTRACT vs DATE_TRUNC:** EXTRACT retrieves an individual component. DATE_TRUNC rounds down to a time boundary.

**TIMESTAMP vs TIMESTAMPTZ:** TIMESTAMP does not store time-zone information. TIMESTAMPTZ represents an instant and is displayed according to the session time zone.

**DATE vs TIMESTAMP:** DATE stores only a calendar date, whereas TIMESTAMP also includes time.

**Best practice:** For timestamp ranges, prefer `>= start AND < end` instead of inclusive end-of-day timestamps.

---

---

# 14. NULL HANDLING

**Purpose:** Identify, replace, compare, and process missing values in SQL.

## Understanding NULL

NULL represents a missing or unknown value.

NULL is different from zero, an empty string, and FALSE.

## Common NULL Functions and Operators

| Function / Operator | Purpose |
|---|---|
| `IS NULL` | Identify missing values |
| `IS NOT NULL` | Identify non-NULL values |
| `COALESCE()` | Return the first non-NULL argument |
| `NULLIF()` | Return NULL when two expressions are equal |
| `IS DISTINCT FROM` | NULL-safe inequality |
| `IS NOT DISTINCT FROM` | NULL-safe equality |
| `NULLS FIRST` | Place NULLs first when sorting |
| `NULLS LAST` | Place NULLs last when sorting |

## Common Syntax

```sql
-- Find missing values
SELECT *
FROM employees
WHERE department IS NULL;

-- Find available values
SELECT *
FROM employees
WHERE department IS NOT NULL;

-- Replace missing values
SELECT COALESCE(department, 'Unknown')
FROM employees;

-- Prevent division by zero
SELECT 100.0 / NULLIF(0, 0);

-- NULL-safe comparison
SELECT NULL IS NOT DISTINCT FROM NULL;
```

## NULL with Aggregate Functions

| Expression | Behavior |
|---|---|
| `COUNT(*)` | Counts all rows |
| `COUNT(column)` | Counts non-NULL values |
| `COUNT(DISTINCT column)` | Counts distinct non-NULL values |
| `SUM(column)` | Ignores NULL inputs |
| `AVG(column)` | Ignores NULL inputs |
| `MIN(column)` | Ignores NULL inputs |
| `MAX(column)` | Ignores NULL inputs |

## NULL vs Empty String

```sql
-- Convert an empty string into NULL
SELECT NULLIF('', '');

-- Convert blank or NULL text to Unknown
SELECT COALESCE(NULLIF(TRIM('   '), ''), 'Unknown');
```

## Data Engineering Applications

- Detect missing data in source datasets.
- Standardize blank and NULL values.
- Validate mandatory columns.
- Calculate missing-data percentages.
- Compare source and target records.
- Apply default values when business rules permit.
- Prevent division-by-zero errors.
- Build data quality checks.

## Interview Tips

**NULL vs Zero:** NULL means missing or unknown. Zero is a known numeric value.

**COALESCE vs NULLIF:** COALESCE returns the first non-NULL argument. NULLIF returns NULL when two expressions are equal.

**COUNT(*) vs COUNT(column):** COUNT(*) counts every row, while COUNT(column) ignores NULL values.

**NULL and NOT IN:** NULL values in a NOT IN list can cause unexpected UNKNOWN results. Consider NOT EXISTS when appropriate.

**NULL-safe comparison:** Use IS DISTINCT FROM or IS NOT DISTINCT FROM when comparisons must handle NULL explicitly.

**Important:** Replacing missing values with zero can distort calculations, especially averages.

---

