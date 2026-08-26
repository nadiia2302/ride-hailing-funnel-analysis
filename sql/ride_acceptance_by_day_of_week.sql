	with conversion_acceptance as (select
	case extract(dow from request_ts)
		when 0 then 7
		else extract (dow from request_ts) end as number_day_week,
	to_char(request_ts,'Day') as day_of_week,
	count(user_id) as total_count_requests,
	count(accept_ts) as total_count_accept
		from ride_requests
		group by   1,2
	order by 1)
	select 
	number_day_week,
	day_of_week,
	round(total_count_requests,2) as total_amount_of_requests,
	round(total_count_accept,2) as total_amount_of_accept, 
	1-1.0*total_count_accept/total_count_requests*1 as churn_rate
	from conversion_acceptance