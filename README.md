# 🚗 Metrocar User Funnel Analysis (Ride-Hailing)

## Executive Summary

Using SQL and Excel/Google Sheets, I pulled ride and user data from the database and built a Power BI dashboard to track users through the funnel - from app download to completed ride, payment, and review. After identifying that the largest opportunities are at the **Payment** and **Ride Requested** steps, I recommend the product team implement a few adjustments that will lead to higher conversion:

1. **Increase driver supply during peak hours (8-10 AM and 4-7 PM)** with bonuses, reminders, and dynamic pricing.
2. **Reduce wait times** so more requested rides convert to accepted/completed rides instead of being cancelled.
3. **Improve the payment step experience** to cut the 49% drop-off between Ride Accepted and Payment.

---

## Business Problem

Completed rides are essential for Metrocar since they're directly tied to revenue. Product and marketing stakeholders have noticed that fewer users complete a ride than expected (based on users who download the app vs. users who complete their first ride). How can we determine where users are falling out of the funnel, which platforms and age groups convert best, and what product or marketing changes will encourage more users to complete a ride?

1) Funnel Analysis Preview
<img width="1428" height="799" alt="image" src="https://github.com/user-attachments/assets/8560889b-c759-4578-9ee0-c7002f77447c" />

2) User & Ride Detailed Analysis Preview
   
<img width="1447" height="801" alt="image" src="https://github.com/user-attachments/assets/0468ea95-c756-4100-bf13-86ca93b35398" />


---

## Methodology

1. SQL queries that extract, clean, and transform the data from the Postgres database (`app_downloads`, `signups`, `ride_requests`, `transactions`, `reviews`, and the derived `funnel_analysis` table).
2. Build a dashboard in Power BI that tracks the number of users at each funnel stage, by platform and age group.
3. Calculate conversion and drop-off rates in Excel/Google Sheets, and analyze time-of-day and driver-wait-time patterns to find where the biggest opportunities are.

---

## Skills

**SQL:** CTEs, joins, case statements, aggregate functions, date/time functions

**Power BI:** DAX, calculated columns, data visualization, data modeling, filters

**Excel / Google Sheets:** conversion-rate calculations, pivot tables, segment breakdowns

---

## Results & Business Recommendation

The funnel dashboard shows where users drop off - both overall and by platform 
and age group. Overall, conversion drops from 100% at download to just 18% at 
review, and only half of ride requests turn into completed rides (12.4K - 6.2K). 
iOS makes up most of the user base (60.84%, vs. 29.36% Android and 9.8% Web), 
and the 35-44 age group is the most active and completes the most rides, while 
18-24 and 45-54 convert the worst.

The two biggest drop-off points are **Payment** (49.23% churn - the largest in 
the funnel) and **Ride Requested** (29.60% churn). Based on this, here are my 
recommendations:

1. **Add more drivers during peak hours (8-10 AM, 4-7 PM)** - this is when 
demand is highest and most users are lost. Bonuses, reminders, and dynamic 
pricing can help.
2. **Cut driver wait times** - retention is 100% under 10 minutes but drops 
to 14% after that (159,633 requests, 85.9% churn). This is the biggest 
opportunity in the whole funnel.
3. **Simplify the app for 45-54 users** - bigger buttons, clearer instructions, 
since this group has one of the lowest completion rates.
4. **Fix missing age data** - prompt users to enter their age (with a small 
incentive) to improve targeting and check if it's a tracking issue.
5. **Adjust marketing spend** - focus on 18-24 for new users and 35-44 for 
revenue, since they complete the most rides and spend the most.
6. **Improve service quality** - over 46,458 reviews are 1-star, mostly about 
drivers. A bad first ride often leads to churn, so training drivers, removing 
low performers, and rewarding good service could help.

These changes target the biggest drop-off points and give the team a way to 
keep tracking funnel health going forward.

---

## Next Steps

1. Share the dashboard with product, marketing, and support stakeholders.
2. Pilot the top recommendation (driver incentives during peak hours / reducing wait times) and measure impact on conversion.
3. Set up a recurring refresh of the funnel data to track whether changes move the numbers.

---

## Project Deliverables

- **Interactive Dashboard (Power BI)** - [View here](https://app.powerbi.com/view?r=eyJrIjoiY2Y0ZGIxNjYtYmUwYi00ZmQyLWEwOWUtOGI3NWIzYjMxZjM1IiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9)
- **Final Report (PDF)** - [View here](https://drive.google.com/file/d/1To_QYOLUu_2X46_lIk5AMuJPLGz2Ra1x/view)
- **SQL scripts** - see `/sql` folder
- **Excel/Google Sheets calculations** - see `/spreadsheet` folder

---

## Database Connection

The data used in this project was provided during a data analytics trainee
at Data Loves Academy and is confidential - program terms prohibit sharing 
the dataset or database credentials.

The SQL scripts reflect the actual queries used in the analysis and can be 
adapted to any dataset with a similar schema:

**app_downloads** - app download events
- `app_download_key`: unique download ID
- `platform`: ios / android / web
- `download_ts`: download date and time

**signups** - new user registrations
- `user_id`: unique user ID
- `session_id`: linked app download ID
- `signup_ts`: registration date and time
- `age_range`: user age group

**ride_requests** - ride request events
- `ride_id`: unique ride ID
- `user_id`: user who requested the ride
- `driver_id`: driver who accepted the ride
- `request_ts`, `accept_ts`, `pickup_ts`, `dropoff_ts`, `cancel_ts`: event timestamps
- `pickup_location`, `destination_location`: coordinates

**transactions** - payment data
- `ride_id`: linked ride ID
- `purchase_amount_usd`: purchase amount in USD
- `charge_status`: payment status (approved, cancelled)
- `transaction_ts`: transaction timestamp

**reviews** - post-ride user feedback
- `review_id`: unique review ID
- `ride_id`, `driver_id`, `user_id`: linked IDs
- `rating`: rating (0–5)
- `free_response`: free-text user comment

**funnel_analysis** - a derived table built via `create_table_funnel_analysis.sql` 
to simplify funnel analysis, combining key events from the tables above into a 
single step-based structure (`funnel_name`, `number_of_users`, `platform`, `age_range`)

Database: PostgreSQL





