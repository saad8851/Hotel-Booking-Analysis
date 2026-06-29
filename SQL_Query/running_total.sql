--Calculate the running total of bookings over time.

WITH months AS(
SELECT 
    CAST(DATE_TRUNC('month', reservation_status_date) AS DATE)
     AS reservation_month,
    COUNT(*) AS total_bookings
FROM hotel_analysis
GROUP BY 
    DATE_TRUNC('month', reservation_status_date) 
)
SELECT 
    reservation_month,
    total_bookings,
    SUM(total_bookings) OVER(ORDER BY reservation_month) AS running_total
FROM months
ORDER BY reservation_month
