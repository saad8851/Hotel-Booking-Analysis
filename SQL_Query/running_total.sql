-- ==========================================================
-- Business Question:
-- How do total bookings accumulate over time?
--
-- Why is this important?
-- A running total helps visualize cumulative booking growth
-- over time. It enables hotels to monitor booking trends,
-- evaluate business performance, and identify periods of
-- rapid or slow growth.
--
-- Logic:
-- 1. Group bookings by reservation month using
--    reservation_status_date.
-- 2. Count the total bookings for each month.
-- 3. Use the SUM() window function to calculate the
--    cumulative (running) total of bookings.
-- 4. Order the results chronologically to show booking
--    growth over time.
--
-- Note:
-- DATE_TRUNC('month', reservation_status_date) groups all
-- bookings within the same month, while the window function
-- adds each month's bookings to the previous total.
-- ==========================================================

WITH months AS (
    SELECT
        CAST(DATE_TRUNC('month', reservation_status_date) AS DATE)
            AS reservation_month,
        COUNT(*) AS total_bookings
    FROM hotel_analysis
    GROUP BY DATE_TRUNC('month', reservation_status_date)
)

SELECT
    reservation_month,
    total_bookings,
    SUM(total_bookings) OVER (
        ORDER BY reservation_month
    ) AS running_total
FROM months
ORDER BY reservation_month;
