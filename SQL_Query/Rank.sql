-- ==========================================================
-- Business Question:
-- Which hotel type has the highest Average Daily Rate (ADR)
-- in each year?
--
-- Why is this important?
-- Comparing ADR rankings by year helps identify which hotel
-- type consistently commands higher room prices and how pricing
-- performance changes over time.
-- Note:
-- PARTITION BY arrival_date_year resets the ranking every year.
-- ==========================================================

SELECT
    hotel_type,
    arrival_date_year,
    ROUND(AVG(adr), 2) AS avg_adr,
    RANK() OVER (
        PARTITION BY arrival_date_year
        ORDER BY AVG(adr) DESC
    ) AS rk
FROM hotel_analysis
GROUP BY hotel_type, arrival_date_year
ORDER BY arrival_date_year, rk;
