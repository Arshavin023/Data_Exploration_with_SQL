-- joining all cleaned data and exploring the data to ascertain 
-- The CTE is executed with each of the SELECT queries to evaluate total_rides and average duration for each month, weekday and subscription type
WITH total_data AS (
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.dec_2020)
UNION
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.jan_2021)
UNION
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.feb_2021)
UNION
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.mar_2021)
UNION
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.april_2021)
UNION
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.may_2021)
UNION
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.june_2021)
UNION
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.july_2021)
UNION
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.aug_2021)
UNION
(SELECT ride_id,rideable_type,member_casual, day_of_week, name_of_month, ride_length
FROM cyclistic_company.dbo.sept_2021)
)

SELECT member_casual, name_of_month, COUNT(ride_id) as number_of_rides
FROM total_data
GROUP BY member_casual, name_of_month
ORDER BY number_of_rides DESC

SELECT member_casual, day_of_week, COUNT(ride_id) as number_of_rides
FROM total_data
GROUP BY member_casual, day_of_week
ORDER BY number_of_rides DESC


SELECT member_casual, day_of_week, AVG(ride_length) as average_duration
FROM total_data
GROUP BY member_casual, day_of_week
ORDER BY average_duration DESC

SELECT member_casual, name_of_month, AVG(ride_length) as average_duration
FROM total_data
GROUP BY member_casual, name_of_month
ORDER BY average_duration DESC



