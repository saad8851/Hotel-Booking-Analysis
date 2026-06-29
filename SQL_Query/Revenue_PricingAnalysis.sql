--Top 10 countries contribute the most bookings?
SELECT 
    DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS cnt_rank,
    country,
    COUNT(*) AS total_booking
FROM hotel_analysis
GROUP BY country
ORDER BY total_booking DESC
LIMIT 10
-- This helps in decided where to distribute resources more on the basis of bookings 
-- months generate the highest estimated revenue (ADR × Total Nights)?

SELECT SUM(adr * total_nights) AS est_revenue,
arrival_date_month
FROM hotel_analysis
GROUP BY arrival_date_month
ORDER BY est_revenue DESC

-- Which distribution channels bring the most bookings, and what are their cancellation rates?

SELECT COUNT(*) AS total_bookings,
    distribution_channel,
    ROUND(
    SUM(is_canceled)::numeric / COUNT(*) *100, 2)
    AS cancelation_rate
FROM hotel_analysis
GROUP BY distribution_channel





