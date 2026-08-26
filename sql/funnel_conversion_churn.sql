with user_count as
	(
	select
		'download' as step,
		count(case when funnel_name = 'download' then number_of_users end) as count_of_users
	from
		funnel_analysis
	union all
	select
		'signup',
		count(case when funnel_name = 'signup' then number_of_users end) as count_of_users
	from
		funnel_analysis
	union all
	select
		'ride_requested',
		count(case when funnel_name = 'ride_requested' then number_of_users end) as count_of_users
	from
		funnel_analysis
	union all
	select
		'ride_accepted',
		count(case when funnel_name = 'ride_accepted' then number_of_users end) as count_of_users
	from
		funnel_analysis
	union all
	select
		'ride_completed',
		count(case when funnel_name = 'ride_completed' then number_of_users end) as count_of_users
	from
		funnel_analysis
	union all
	select
		'payment',
		count(case when funnel_name = 'payment' then number_of_users end) as count_of_users
	from
		funnel_analysis
	union all 
		select 
		'review',
		count (case when funnel_name = 'review' then number_of_users end) as count_of_users
	from
		funnel_analysis 
	),

conversion as 
(select
	step,
	count_of_users,
	lag(count_of_users) over(order by case step when 'download' then 1
											when 'signup' then 2
											when 'ride_requested' then 3
											when 'ride_accepted' then 4
											when 'payment' then 5
											when 'ride_completed' then 6
											when 'review' then 7
										end) as prev_users
from
	user_count)

select step, count_of_users,
	1.0*count_of_users/prev_users as conversion_rate,
	1-(1.0*count_of_users/prev_users) as churn_rate
from conversion
