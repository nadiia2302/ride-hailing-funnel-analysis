with convertion_rides as(select 
date_part('hour',request_ts) as hour,
count(request_ts ) as count_of_ride_requests,
count(accept_ts) as count_of_ride_accept,
avg(accept_ts - request_ts) as avg_difference
from ride_requests
group by 1)
select 
	hour,
	count_of_ride_requests,
	count_of_ride_accept,
	avg_difference,
	1-1.0*count_of_ride_accept/count_of_ride_requests as churn_rate
from convertion_rides