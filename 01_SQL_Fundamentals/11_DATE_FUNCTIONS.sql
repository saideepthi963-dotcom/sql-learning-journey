
-- ============================================================
-- 1. INTRODUCTION
-- ============================================================

-- Date and time functions are used to:
-- 1. Retrieve current dates and timestamps
-- 2. Extract date components
-- 3. Perform date calculations
-- 4. Format dates
-- 5. Compare dates
-- 6. Process timestamp data in ETL pipelines

-- Common PostgreSQL Data Types:
-- DATE         -> Stores date
-- TIME         -> Stores time
-- TIMESTAMP    -> Stores date and time without time zone
-- TIMESTAMPTZ  -> Stores a timestamp representing an instant
--                 with time zone-aware input/output
-- INTERVAL     -> Stores a duration


-- ============================================================
-- 2. CURRENT_DATE
-- ============================================================

-- Returns the current date.

SELECT CURRENT_DATE AS today;


-- ============================================================
-- 3. CURRENT_TIME
-- ============================================================

-- Returns the current time with time zone.

SELECT CURRENT_TIME AS current_time_value;


-- ============================================================
-- 4. CURRENT_TIMESTAMP AND NOW()
-- ============================================================

-- Returns the current transaction timestamp.

SELECT CURRENT_TIMESTAMP AS current_timestamp_value;

SELECT NOW() AS current_timestamp_value;

-- NOW() and CURRENT_TIMESTAMP are equivalent in PostgreSQL.
-- Both represent the start of the current transaction.


-- ============================================================
-- 5. LOCALTIME AND LOCALTIMESTAMP
-- ============================================================

-- Current time without time zone.

SELECT LOCALTIME AS local_time_value;

-- Current timestamp without time zone.

SELECT LOCALTIMESTAMP AS local_timestamp_value;


-- ============================================================
-- 6. EXTRACT()
-- ============================================================

-- Extract specific components from a date or timestamp.

SELECT
    EXTRACT(YEAR FROM DATE '2026-10-26') AS year_value;

SELECT
    EXTRACT(MONTH FROM DATE '2026-10-26') AS month_value;

SELECT
    EXTRACT(DAY FROM DATE '2026-10-26') AS day_value;


-- Extract multiple date components.

SELECT
    EXTRACT(YEAR FROM DATE '2026-10-26') AS year,
    EXTRACT(MONTH FROM DATE '2026-10-26') AS month,
    EXTRACT(DAY FROM DATE '2026-10-26') AS day;


-- Extract time components.

SELECT
    EXTRACT(HOUR FROM TIMESTAMP '2026-10-26 14:30:45')
        AS hour,
    EXTRACT(MINUTE FROM TIMESTAMP '2026-10-26 14:30:45')
        AS minute,
    EXTRACT(SECOND FROM TIMESTAMP '2026-10-26 14:30:45')
        AS second;


-- ============================================================
-- 7. DATE_PART()
-- ============================================================

-- DATE_PART extracts parts of a date or timestamp.
-- It is similar to EXTRACT.

SELECT
    DATE_PART('year', DATE '2026-10-26') AS year_value;

SELECT
    DATE_PART('month', DATE '2026-10-26') AS month_value;

SELECT
    DATE_PART('day', DATE '2026-10-26') AS day_value;


-- ============================================================
-- 8. DATE_TRUNC()
-- ============================================================

-- DATE_TRUNC truncates a timestamp to a specified precision.

-- Start of the month.

SELECT
    DATE_TRUNC('month', TIMESTAMP '2026-10-26 15:30:45')
        AS month_start;


-- Start of the year.

SELECT
    DATE_TRUNC('year', TIMESTAMP '2026-10-26 15:30:45')
        AS year_start;


-- Start of the day.

SELECT
    DATE_TRUNC('day', TIMESTAMP '2026-10-26 15:30:45')
        AS day_start;


-- Start of the hour.

SELECT
    DATE_TRUNC('hour', TIMESTAMP '2026-10-26 15:30:45')
        AS hour_start;


-- Start of the week (Monday).

SELECT
    DATE_TRUNC('week', TIMESTAMP '2026-10-26 15:30:45')
        AS week_start;


-- ============================================================
-- 9. INTERVAL
-- ============================================================

-- INTERVAL represents a duration.

-- Add 7 days to a date.

SELECT
    DATE '2026-10-26' + INTERVAL '7 days'
        AS next_week;


-- Subtract 30 days.

SELECT
    DATE '2026-10-26' - INTERVAL '30 days'
        AS previous_date;


-- Add 3 months.

SELECT
    DATE '2026-10-26' + INTERVAL '3 months'
        AS future_date;


-- Add 1 year.

SELECT
    DATE '2026-10-26' + INTERVAL '1 year'
        AS next_year;


-- Add 2 hours.

SELECT
    TIMESTAMP '2026-10-26 10:00:00'
    + INTERVAL '2 hours'
        AS updated_timestamp;


-- ============================================================
-- 10. DATE ARITHMETIC
-- ============================================================

-- Add an integer number of days to a DATE.

SELECT
    DATE '2026-10-26' + 10 AS future_date;


-- Subtract an integer number of days.

SELECT
    DATE '2026-10-26' - 5 AS previous_date;


-- Difference between two DATE values returns days.

SELECT
    DATE '2026-10-26' - DATE '2026-10-01'
        AS days_difference;


-- ============================================================
-- 11. AGE()
-- ============================================================

-- AGE calculates a symbolic interval between dates.

SELECT
    AGE(
        TIMESTAMP '2026-10-26',
        TIMESTAMP '2020-01-15'
    ) AS elapsed_time;


-- Calculate an example employee's years of service.

SELECT
    EXTRACT(
        YEAR FROM AGE(
            DATE '2026-10-26',
            DATE '2020-06-15'
        )
    ) AS completed_years;


-- ============================================================
-- 12. TO_CHAR()
-- ============================================================

-- TO_CHAR formats a date or timestamp as text.

SELECT
    TO_CHAR(
        DATE '2026-10-26',
        'YYYY-MM-DD'
    ) AS formatted_date;


-- Month name and year.

SELECT
    TO_CHAR(
        DATE '2026-10-26',
        'FMMonth YYYY'
    ) AS month_year;


-- Month, day, and year.

SELECT
    TO_CHAR(
        DATE '2026-10-26',
        'MM/DD/YYYY'
    ) AS formatted_date;


-- Format a timestamp.

SELECT
    TO_CHAR(
        TIMESTAMP '2026-10-26 14:30:45',
        'YYYY-MM-DD HH24:MI:SS'
    ) AS formatted_timestamp;


-- ============================================================
-- 13. TO_DATE()
-- ============================================================

-- Converts text into a DATE.

SELECT
    TO_DATE(
        '26-10-2026',
        'DD-MM-YYYY'
    ) AS converted_date;


-- Convert MM/DD/YYYY text into a DATE.

SELECT
    TO_DATE(
        '10/26/2026',
        'MM/DD/YYYY'
    ) AS converted_date;


-- ============================================================
-- 14. TO_TIMESTAMP()
-- ============================================================

-- Converts a string into a timestamp with time zone.

SELECT
    TO_TIMESTAMP(
        '2026-10-26 14:30:45',
        'YYYY-MM-DD HH24:MI:SS'
    ) AS converted_timestamp;

-- The displayed value depends on the session time zone
-- when the input string does not specify a time zone.


-- ============================================================
-- 15. CASTING DATE AND TIMESTAMP VALUES
-- ============================================================

-- Convert timestamp to date.

SELECT
    TIMESTAMP '2026-10-26 14:30:45'::DATE
        AS extracted_date;


-- Convert a date to timestamp.

SELECT
    DATE '2026-10-26'::TIMESTAMP
        AS converted_timestamp;


-- Convert ISO date text to DATE.

SELECT
    CAST('2026-10-26' AS DATE)
        AS converted_date;


-- ============================================================
-- 16. DATE COMPARISONS
-- ============================================================

-- Find whether a date is after a given date.

SELECT
    DATE '2026-10-26' > DATE '2026-01-01'
        AS is_after;


-- Compare two dates.

SELECT
    DATE '2026-10-26' = DATE '2026-10-26'
        AS dates_equal;


-- BETWEEN includes both endpoints.

SELECT
    DATE '2026-10-26'
    BETWEEN DATE '2026-10-01' AND DATE '2026-10-31'
        AS is_in_october;


-- ============================================================
-- 17. CREATE SAMPLE ORDERS DATA
-- ============================================================

-- This temporary sample data supports date practice.
-- It does not create or modify a permanent database table.

WITH orders AS (
    SELECT *
    FROM (
        VALUES
            (1, DATE '2026-10-01', 150.00),
            (2, DATE '2026-10-05', 250.00),
            (3, DATE '2026-10-15', 300.00),
            (4, DATE '2026-09-20', 180.00),
            (5, DATE '2026-08-10', 400.00)
    ) AS t(order_id, order_date, amount)
)
SELECT *
FROM orders;


-- ============================================================
-- 18. FILTER ORDERS BY DATE
-- ============================================================

-- Find orders placed in October 2026.

WITH orders AS (
    SELECT *
    FROM (
        VALUES
            (1, DATE '2026-10-01', 150.00),
            (2, DATE '2026-10-05', 250.00),
            (3, DATE '2026-10-15', 300.00),
            (4, DATE '2026-09-20', 180.00),
            (5, DATE '2026-08-10', 400.00)
    ) AS t(order_id, order_date, amount)
)
SELECT *
FROM orders
WHERE order_date >= DATE '2026-10-01'
  AND order_date < DATE '2026-11-01';


-- ============================================================
-- 19. REAL-WORLD DATA ENGINEERING EXAMPLES
-- ============================================================


-- Example 1: Generate a processing date.

SELECT
    CURRENT_DATE AS processing_date;


-- Example 2: Generate an ETL processing timestamp.

SELECT
    CURRENT_TIMESTAMP AS etl_processed_at;


-- Example 3: Get the beginning of the current month.

SELECT
    DATE_TRUNC('month', CURRENT_TIMESTAMP)
        AS month_start;


-- Example 4: Calculate yesterday's date.

SELECT
    CURRENT_DATE - 1 AS yesterday;


-- Example 5: Calculate the previous 7-day boundary.

SELECT
    CURRENT_TIMESTAMP - INTERVAL '7 days'
        AS seven_days_ago;


-- Example 6: Generate a monthly reporting key.

SELECT
    TO_CHAR(
        CURRENT_DATE,
        'YYYYMM'
    ) AS reporting_month;


-- Example 7: Convert a timestamp into a date.

SELECT
    CURRENT_TIMESTAMP::DATE AS event_date;


-- Example 8: Extract the month from a date.

SELECT
    EXTRACT(
        MONTH FROM DATE '2026-10-26'
    ) AS transaction_month;


-- ============================================================
-- 20. INCREMENTAL DATA LOADING
-- ============================================================

-- Incremental loading processes new or changed records.

-- Example:
-- Load records updated during the previous 24 hours.

-- Illustrative query: the source table must exist.

-- SELECT *
-- FROM source_orders
-- WHERE updated_at >= CURRENT_TIMESTAMP - INTERVAL '1 day';

-- For reliable production pipelines:
-- Use persisted watermarks or batch boundaries.
-- Avoid relying only on a rolling time filter.


-- ============================================================
-- 21. IMPORTANT BEST PRACTICES
-- ============================================================

-- 1. Use DATE for date-only values.

-- 2. Use TIMESTAMP for local date-time values
--    that do not represent a globally unique instant.

-- 3. Prefer TIMESTAMPTZ for event timestamps
--    representing real instants in time.

-- 4. Store event timestamps consistently, commonly in UTC.

-- 5. Use DATE_TRUNC for time-based grouping.

-- 6. Use INTERVAL for date and timestamp arithmetic.

-- 7. Use EXTRACT for retrieving date components.

-- 8. Use TO_CHAR for formatting output.

-- 9. Avoid converting indexed timestamp columns to text
--    unnecessarily when filtering large datasets.

-- 10. Prefer half-open ranges for timestamp filtering:
--     timestamp >= start AND timestamp < next_start.

-- 11. Be aware that CURRENT_TIMESTAMP is fixed
--     at the start of the current transaction.

-- 12. Time zones and daylight-saving transitions
--     can affect timestamp calculations.


-- ============================================================
-- 22. PRACTICE QUESTIONS WITH SOLUTIONS
-- ============================================================


-- Q1. Display the current date.

SELECT CURRENT_DATE AS current_date_value;


-- Q2. Display the current timestamp.

SELECT CURRENT_TIMESTAMP AS current_timestamp_value;


-- Q3. Extract the year from 2026-10-26.

SELECT
    EXTRACT(YEAR FROM DATE '2026-10-26') AS year;


-- Q4. Extract the month from 2026-10-26.

SELECT
    EXTRACT(MONTH FROM DATE '2026-10-26') AS month;


-- Q5. Find the first day of October 2026.

SELECT
    DATE_TRUNC(
        'month',
        TIMESTAMP '2026-10-26'
    )::DATE AS first_day_of_month;


-- Q6. Add 15 days to 2026-10-26.

SELECT
    DATE '2026-10-26' + 15 AS future_date;


-- Q7. Subtract 10 days from 2026-10-26.

SELECT
    DATE '2026-10-26' - 10 AS previous_date;


-- Q8. Calculate the difference between two dates.

SELECT
    DATE '2026-10-26' - DATE '2026-10-01'
        AS days_difference;


-- Q9. Format a date as MM/DD/YYYY.

SELECT
    TO_CHAR(
        DATE '2026-10-26',
        'MM/DD/YYYY'
    ) AS formatted_date;


-- Q10. Convert a date string into DATE.

SELECT
    TO_DATE(
        '26-10-2026',
        'DD-MM-YYYY'
    ) AS converted_date;


-- Q11. Display the previous month's starting date.

SELECT
    (
        DATE_TRUNC('month', CURRENT_DATE)
        - INTERVAL '1 month'
    )::DATE AS previous_month_start;


-- Q12. Calculate a date 90 days from today.

SELECT
    CURRENT_DATE + 90 AS future_date;


-- Q13. Extract the weekday from a date.
-- PostgreSQL DOW: Sunday = 0, Monday = 1.

SELECT
    EXTRACT(DOW FROM DATE '2026-10-26')
        AS day_of_week;


-- Q14. Display the beginning of the current year.

SELECT
    DATE_TRUNC('year', CURRENT_TIMESTAMP)
        AS year_start;


-- Q15. Generate an ETL processing timestamp.

SELECT
    CURRENT_TIMESTAMP AS etl_processed_at;

