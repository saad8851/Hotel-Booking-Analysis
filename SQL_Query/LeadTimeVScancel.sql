-- How do cancellation rates vary across lead time categories
-- (Short: 0-15 days, Medium: 16-30 days, Long: 31+ days)?
-- Lead time categories were created during data cleaning in Excel.

Select lead_time_category, 
    ROUND(SUM(is_canceled)::numeric / COUNT(*) *100, 2)
        AS cancelation_rate
FROM hotel_analysis
GROUP BY lead_time_category
