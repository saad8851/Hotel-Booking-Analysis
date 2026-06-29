-- ==========================================================
-- Business Question:
-- What percentage of total bookings comes from each market segment?
--
-- Logic:
-- 1. COUNT(*) calculates bookings for each market segment.
-- 2. SUM(COUNT(*)) OVER() calculates the total bookings across
--    all market segments using a window function.
-- 3. Divide segment bookings by total bookings and multiply by 100
--    to get the percentage contribution.
-- ==========================================================

SELECT
    market_segment,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),
        3
    ) AS prcnt_book
FROM hotel_analysis
GROUP BY market_segment
ORDER BY prcnt_book DESC;

-- ==========================================================
-- Business Question:
-- Which countries have an Average Daily Rate (ADR)
-- higher than the overall (global) average ADR?
--
-- Logic:
-- 1. Calculate the average ADR for each country.
-- 2. Calculate the overall average ADR across the entire dataset.
-- 3. Compare each country's average ADR with the global average.
-- 4. Return only those countries whose average ADR is higher.
--
-- Why use a CTE?
-- It stores the average ADR of each country so we don't have to
-- calculate it multiple times, making the query easier to read.
-- ==========================================================

WITH av AS (
    SELECT
        country,
        AVG(adr) AS avg_adr
    FROM hotel_analysis
    GROUP BY country
)

SELECT
    country,
    ROUND(avg_adr, 2) AS avg_adr
FROM av
WHERE avg_adr > (
    SELECT AVG(adr)
    FROM hotel_analysis
)
ORDER BY avg_adr DESC;
