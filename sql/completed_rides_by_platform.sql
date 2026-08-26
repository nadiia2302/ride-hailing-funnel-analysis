SELECT platform, SUM(number_of_rides) as count_of_completed_rides
FROM funnel_analysis 
WHERE funnel_name = 'ride_completed' 
GROUP BY platform