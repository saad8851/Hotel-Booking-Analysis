-- ==========================================================
-- Business Question:
-- Does the type of deposit influence booking cancellations?
--
-- Why is this important?
-- Hotels often require deposits to reduce the likelihood of
-- cancellations. Understanding cancellation behavior by deposit
-- type helps evaluate the effectiveness of different payment policies.

-- Insight:
-- A common expectation is that Non-Refund deposits discourage
-- cancellations because customers risk losing their deposit.
-- However, this dataset may show different behavior, highlighting
-- that analytical findings can vary depending on the data.
-- ==========================================================

SELECT deposit_type,  
    COUNT(*) AS bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 END) AS canceled,
    ROUND(
    SUM(is_canceled)::numeric / COUNT(*) *100, 2)
    AS cancelation_rate
FROM hotel_analysis
GROUP BY deposit_type
ORDER BY cancelation_rate DESC


-- ==========================================================
-- Business Question:
-- How much potential revenue is at risk due to canceled bookings?
--
-- Why is this important?
-- Booking cancellations reduce expected revenue and impact hotel
-- profitability. Estimating the value of canceled bookings helps
-- measure the financial impact of cancellations.

-- Note:
-- The dataset does not contain an actual revenue column.
-- Therefore, potential booking revenue is estimated using:
--       ADR × Total Nights
-- This represents the revenue that could have been earned if the
-- canceled bookings had been completed.
-- ==========================================================

SELECT
    hotel_type,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS total_cancellations,
    ROUND(
        SUM(is_canceled)::numeric * 100 / COUNT(*),
        2
    ) AS cancellation_rate,
    ROUND(
        SUM(CASE WHEN is_canceled = 1 THEN adr * total_nights ELSE 0 END),
        2
    ) AS estimated_revenue_lost
FROM hotel_analysis
GROUP BY hotel_type
ORDER BY estimated_revenue_lost DESC;
