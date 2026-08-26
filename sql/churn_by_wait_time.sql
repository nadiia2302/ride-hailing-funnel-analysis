WITH binned_data AS (
    SELECT 
      
        CASE 
            WHEN (accept_ts - request_ts) <= interval '5 minutes' THEN '0-5 min'
            WHEN (accept_ts - request_ts) <= interval '10 minutes' THEN '6-10 min'
            WHEN (accept_ts - request_ts) > interval '10 minutes' OR accept_ts IS NULL THEN '10+ min'
        END AS wait_time_range,
        request_ts,
        accept_ts
    FROM ride_requests
),
aggregated_stats AS (
    SELECT 
        wait_time_range,
        COUNT(request_ts) AS total_requests,
        COUNT(accept_ts) AS accepted_requests
    FROM binned_data
    GROUP BY 1
)
SELECT 
    wait_time_range,
    total_requests,
    1 - (1.0 * accepted_requests / total_requests) AS churn_rate
FROM aggregated_stats
ORDER BY 
    CASE wait_time_range 
        WHEN '0-5 min' THEN 1 
        WHEN '6-10 min' THEN 2 
        ELSE 3 
    END;