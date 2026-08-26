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

Creating a dashboard to track the user funnel gives product, marketing, and support stakeholders visibility into where users drop off - both overall and by platform and age group. This analysis showed that overall conversion falls from 100% at download to just **18%** of users who leave a review, and only **50%** of users who request a ride go on to complete one (12.4K ride requests → 6.2K completed rides). **iOS** accounts for significantly more of the user base than **Web** (**60.84%** vs. **9.8%**, with Android at 29.36%), and the **35-44** age group (alongside the "Unknown" age category) is both the most active and the most likely to complete a ride, while **18–24** and **45–54** convert the worst.

Because the biggest opportunities are at the **Payment** (49.23% churn - the single largest drop-off in the funnel, occurring right after Ride Accepted) and **Ride Requested** (29.60% churn) steps, I recommend a few product and marketing adjustments:

1. **Balance supply and demand at peak hours** - most rides are requested between 8-10 AM and 4-7 PM, and this is also when the most users are lost; incentivize more drivers to work these windows with bonuses, reminders, and dynamic pricing.
2. **Reduce driver wait times** - retention is 100% when wait time is under 10 minutes but crashes to just 14% once wait time exceeds 10 minutes (159,633 requests, 85.9% churn); this is the single biggest revenue leak identified in the analysis. Getting more drivers on the road during busy periods should directly lift completion rate and cut cancellations.
3. **Improve the app experience for the 45–54 age group** - simplify the interface with bigger buttons and clearer instructions, since this group has among the lowest ride-completion rates.
4. **Fix the "Unknown" age-group data gap** - prompt users to enter their age (with a small incentive/promo) both to improve targeting and to rule out a technical issue behind the large "Unknown" segment.
5. **Refocus marketing spend** - target **18–24** users for acquisition and **35–44** users for monetization, since the 35–44 group both completes the most rides and spends the most.
6. **Invest in service quality** - over 46,458 reviews are 1-star, and review text shows most complaints are about driver service. A bad first ride experience strongly predicts churn, so training drivers, removing consistently low-rated ones, and rewarding good service (promo codes for happy users) should help retention.

I believe these adjustments will best tackle the largest drop-off points, increase conversion, and give the team a repeatable way to monitor funnel health going forward.

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





