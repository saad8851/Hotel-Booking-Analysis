-- repeated guests vs. first-time guests by cancellation rate
SELECT
    CASE WHEN is_repeated_guest=1  THEN 'repeated_guest' ELSE
    'first_time_guest' END AS guest_type,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS canceled_booking,
    SUM(is_canceled) * 100 /COUNT(*) AS cancelation_rate
FROM hotel_analysis
GROUP BY guest_type

