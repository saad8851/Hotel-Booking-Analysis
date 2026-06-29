--Compare monthly bookings with the previous month to identify growth or decline.

WITH months AS (
    SELECT
        CAST(DATE_TRUNC('month', reservation_status_date) AS DATE) AS reservation_month,
        COUNT(*) AS total_bookings
    FROM hotel_analysis
    GROUP BY DATE_TRUNC('month', reservation_status_date)
)

SELECT
    reservation_month,
    total_bookings,
    LAG(total_bookings) OVER (ORDER BY reservation_month) AS previous_month_bookings,
    total_bookings -
    LAG(total_bookings) OVER (ORDER BY reservation_month) AS booking_change 
FROM months
ORDER BY reservation_month;