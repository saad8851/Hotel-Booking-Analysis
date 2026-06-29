-- Identify market segments whose cancellation rate is higher
-- than the average cancellation rate of their hotel type
-- (City Hotel or Resort Hotel). This helps find segments
-- that underperform within each hotel category.

-- Compare segment vs its own hotel type

WITH overall_cancelation_rate AS(
    SELECT ROUND(
        SUM(is_canceled)::numeric/COUNT(*) * 100, 2) AS 
        hotel_cancelation_rate, hotel_type
    FROM hotel_analysis  
    GROUP BY hotel_type
    )

SELECT market_segment, 
       ROUNd(
        SUM(h.is_canceled)::numeric / COUNT(*) *100, 2)
         AS segment_rate, o.hotel_type, o.hotel_cancelation_rate
FROM hotel_analysis h 
JOIN overall_cancelation_rate o ON h.hotel_type = o.hotel_type
GROUP BY market_segment, o.hotel_cancelation_rate, o.hotel_type
HAVING  ROUNd(
        SUM(is_canceled)::numeric / COUNT(*) *100, 2)
         > o.hotel_cancelation_rate
        
-- Identify market segments whose cancellation rate is higher
-- than the overall hotel cancellation rate across all bookings.
-- This provides a high-level view of risky market segments.

-- Compare segment vs entire hotel business

WITH overall_rate AS(
    SELECT ROUND(
        SUM(is_canceled)::numeric/COUNT(*) * 100, 2) AS 
        hotel_cancelation_rate
    FROM hotel_analysis    -- hotel overall rate
)

SELECT market_segment, 
       ROUNd(
        SUM(h.is_canceled)::numeric / COUNT(*) *100, 2)
         AS segment_rate
FROM hotel_analysis h 
GROUP BY market_segment
HAVING  ROUNd(
        SUM(is_canceled)::numeric / COUNT(*) *100, 2)
         > (SELECT hotel_cancelation_rate FROM overall_rate)
        