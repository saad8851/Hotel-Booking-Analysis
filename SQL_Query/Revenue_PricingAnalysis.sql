-- ==========================================================
-- Business Question:
-- Which countries generate the highest estimated revenue?
--
-- Why is this important?
-- Identifying high-revenue countries helps hotels prioritize
-- marketing efforts, allocate resources effectively, and focus
-- on their most profitable customer markets.
-- Note:
-- Since the dataset does not contain an actual revenue column,
-- estimated revenue is calculated using ADR × Total Nights.
-- ==========================================================

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(adr * total_nights) DESC) AS revenue_rank,
    country,
    COUNT(*) AS total_booking,
    ROUND(SUM(adr * total_nights), 2) AS estimated_revenue
FROM hotel_analysis
GROUP BY country
ORDER BY estimated_revenue DESC
LIMIT 10;

-- ==========================================================
-- Business Question:
-- Which months generate the highest estimated revenue?
--
-- Why is this important?
-- Understanding monthly revenue trends helps hotels identify
-- peak earning periods, optimize pricing strategies, and plan
-- staffing and marketing campaigns accordingly.

-- Note:
-- Revenue is estimated because the dataset does not contain an
-- actual revenue column.
-- ==========================================================

SELECT
    SUM(adr * total_nights) AS est_revenue,
    arrival_date_month
FROM hotel_analysis
GROUP BY arrival_date_month
ORDER BY est_revenue DESC;

-- ==========================================================
-- Business Question:
-- Which distribution channels generate the most bookings,
-- and how do they perform in terms of cancellations and
-- revenue lost?
--
-- Why is this important?
-- Distribution channels vary in booking volume and booking
-- quality. Analyzing their cancellation rates and estimated
-- revenue loss helps hotels identify the most profitable and
-- reliable sales channels.
-- Note:
-- Revenue lost is an estimate because the dataset does not
-- include actual revenue values.
-- ==========================================================

SELECT
    distribution_channel,
    COUNT(*) AS total_bookings,
    ROUND(
        SUM(is_canceled)::numeric * 100 / COUNT(*),
        2
    ) AS cancellation_rate,
    ROUND(
        SUM(
            CASE
                WHEN is_canceled = 1
                THEN adr * total_nights
                ELSE 0
            END
        ),
        2
    ) AS estimated_revenue_lost
FROM hotel_analysis
GROUP BY distribution_channel
ORDER BY total_bookings DESC;
