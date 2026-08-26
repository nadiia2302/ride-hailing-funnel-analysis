select platform, count(*) as total_user
from app_downloads 
group by platform
order by total_user desc


