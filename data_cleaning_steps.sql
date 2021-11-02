
-- 1. creating a new table
ALTER TABLE cyclistic_company.dbo.dec_2020
ADD ride_length int, day_of_week varchar(50), name_of_month varchar(50)

--2. updating the existing column
UPDATE cyclistic_company.dbo.dec_2020
SET ride_length = DATEDIFF(second, started_at,ended_at)

UPDATE cyclistic_company.dbo.dec_2020
SET day_of_week = DATENAME(WEEKDAY,started_at)

UPDATE cyclistic_company.dbo.dec_2020
SET name_of_month=DATENAME(MONTH,started_at)

--3. checking and counting length of ride with negative values
SELECT COUNT(ride_length)
FROM cyclistic_company.dbo.dec_2020
WHERE ride_length < 1

--4. deleting rows with negative ride_length
DELETE
FROM cyclistic_company.dbo.dec_2020
WHERE ride_length < 1

--5. dropping a column
ALTER TABLE cyclistic_company.dbo.dec_2020
DROP COLUMN ended_at, started_at,start_station_name,start_station_id,end_station_name,end_station_id,start_lat,start_lng,end_lat,end_lng

-- Step I - V was repeated each monthly dataset: Jan_2021, Feb_2021, Mar_2021, April_2021, May_2021, June_2021, July_2021, Aug_2021, Sept


SELECT * FROM cyclistic_company.dbo.dec_2020
