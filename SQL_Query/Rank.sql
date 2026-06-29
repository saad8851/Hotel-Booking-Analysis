--Rank hotel types by ADR within each year
SELECT
    hotel_type,
    arrival_date_year,
    ROUND(AVG(adr), 2) AS avg_adr,
    RANK() OVER (
        PARTITION BY arrival_date_year
        ORDER BY AVG(adr) DESC
    ) AS 
FROM hotel_analysis
GROUP BY hotel_type, arrival_date_year
ORDER BY arrival_date_year, rk;