select
	platform,
	age_range,
	count(case when funnel_name = 'download' then 1 end) as count_of_download_by_age_category
	
from
	funnel_analysis
	group by 1,2
	order by 1,2
	