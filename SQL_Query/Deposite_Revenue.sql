SELECT deposit_type,  
    COUNT(*) AS bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 END) AS canceled,
    ROUND(
    SUM(is_canceled)::numeric / COUNT(*) *100, 2)
    AS cancelation_rate
FROM hotel_analysis
GROUP BY deposit_type
ORDER BY cancelation_rate DESC

--A common expectation is that a non-refundable deposit should reduce 
--cancellations. Indeed, analytical reports note that “non-refundable
--deposits nearly eliminate cancellations”. In our data the result may
--be surprising (we saw ~99% cancel in “Non Refund” bookings, 
--likely data-specific), but generally requiring deposits 
--is known to improve commitment.

-- revenue Risk due to canceled bookings

SELECT hotel_type,
    ROUND(SUM(adr * total_nights), 2) AS revenue_risk
FROM hotel_analysis 
WHERE is_canceled = 1
GROUP BY hotel_type



--Since the dataset does not contain a revenue field, potential 
--booking revenue was estimated as ADR × Total Nights.For canceled 
--bookings, this amount was treated as revenue at risk due to cancellation,
--helping quantify the financial impact of booking cancellations."