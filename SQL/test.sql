-- Customer Revenue By Cohort - Yearly Cohort Analysis
WITH
    cohort AS (
        SELECT
            s.customerkey,
            to_char (s.orderdate, 'YYYY-MM') AS cohort_year
        FROM
            sales s
        GROUP BY
            s.customerkey,
            cohort_year
    )
SELECT
    c.customerkey,
    c.cohort_year
FROM
    cohort c
ORDER BY
    c.customerkey