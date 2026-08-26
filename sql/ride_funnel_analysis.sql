with ride_metrics as
(
select
	count(request_ts) as ride_request_count,
	count(accept_ts) as ride_accept_count,
	count(dropoff_ts) as ride_finish_success,
	count(case 
	when charge_status = 'Approved' then 1 
end) as ride_paid,
	count(rating) as ride_feedback
from
	ride_requests rr
left join transactions t 
on
	rr.ride_id = t.ride_id
left join reviews r 
on
	rr.ride_id = r.ride_id),
full_ride_funnel as(
 select
	1 as step_order,
	'Ride requested' as step_name,
	ride_request_count as ride_count
	from ride_metrics
union all
select 2,
'Ride accepted',
ride_accept_count 
from ride_metrics
union all 
select 3, 
'Ride completed',
ride_finish_success
from ride_metrics
union all
select 4,
'Ride paid',
ride_paid
from ride_metrics 
union all
select 5,
'Ride feedback',
ride_feedback
from ride_metrics
),
conversion_full_ride_funnel as(
select
	step_order,
	step_name,
	ride_count,
	lag(ride_count) over (order by  step_order) as previous_ride_count
from
	full_ride_funnel)
	
select 
	step_order,
	step_name,
	ride_count,
	1.0*ride_count/previous_ride_count as ride_conversion_rate,
	1-1.0*ride_count/previous_ride_count as churn_rate
from conversion_full_ride_funnel;


	