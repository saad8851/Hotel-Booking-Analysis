--. What percentage of total bookings comes from each market segment?

SELECT 
    market_segment,
    ROUND(
    COUNT(*) * 100 /SUM(COUNT(*)) OVER(), 3
    ) AS prcnt_book
FROM hotel_analysis
GROUP BY market_segment
ORDER BY prcnt_book DESC

--countries whose average ADR is above the global average

WITH av AS(
SELECT country,
    AVG(adr) AS avg_adr
FROM hotel_analysis
GROUP BY country
)
SELECT country,
    ROUND(avg_adr, 2) AS avg_adr
FROM av 
WHERE avg_adr > (SELECT AVG(adr) FROM hotel_analysis)
