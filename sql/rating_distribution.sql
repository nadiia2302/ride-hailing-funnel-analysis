with percentage as(
select 
distinct rating , 
count(*) as amount_of_feedback,
sum(count(*)) over() as total_count
from reviews 
group by 1
order by 1)
select
	rating,
	amount_of_feedback,
	1.0*amount_of_feedback/total_count as precentage_by_rating
	from percentage