select 
platform,
age_range,
count(case when funnel_name = 'ride_completed' then 1 end) as count_of_completed_rides
from funnel_analysis 
group by 1,2
order by 1,2
