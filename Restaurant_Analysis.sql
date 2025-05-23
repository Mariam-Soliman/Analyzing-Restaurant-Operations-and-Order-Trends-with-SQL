-- 1-Data Profiling

-- getting familiar with the data 

select * from orders;

-- check the data types of each column

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'zomato' AND TABLE_NAME = 'orders';

-- find out all rows where time_ordered, time_order_picked is in decimal format

select * from orders where time_orderd like "%.%";

select * from orders where time_order_picked like "%.%";

-- check if there are any duplicate orders
 
select id from (select id,row_number() over (partition by id) as rn from orders) a where rn>1; 

-- check if there are any null values

select * from orders where id is null or id in ("Nan","N/a");

select * from orders where delivery_person_id is null or delivery_person_id in ("Nan","N/a");

select * from orders where delivery_person_age is null or delivery_person_age in ("Nan","N/a");

select * from orders where delivery_person_ratings is null or delivery_person_ratings in ("Nan","N/a");

select * from orders where restaurant_latitude is null or restaurant_latitude in ("Nan","N/a");

select * from orders where restaurant_longitude is null or restaurant_longitude in ("Nan","N/a");

select * from orders where delivery_location_latitude is null or delivery_location_latitude in ("Nan","N/a");

select * from orders where delivery_location_longitude is null or delivery_location_longitude in ("Nan","N/a");

select * from orders where order_date is null or order_date in ("Nan","N/a");

select * from orders where time_orderd is null or time_orderd in ("Nan","N/a");

select * from orders where time_orderd_picked is null or time_order_picked in ("Nan","N/a");

select * from orders where weather_conditions is null or weather_conditions in ("Nan","N/a");

select * from orders where road_traffic_density is null or road_traffic_density in ("Nan","N/a");

select * from orders where vehicle_condition is null or vehicle_condition in ("Nan","N/a");

select * from orders where type_of_order is null or type_of_order in ("Nan","N/a");

select * from orders where type_of_vehicle is null or type_of_vehicle in ("Nan","N/a");

select * from orders where multiple_deliveries is null or multiple_deliveries in ("Nan","N/a");

select * from orders where festival is null or festival in ("Nan","N/a");

select * from orders where city is null or city in ("Nan","N/a");

select * from orders where `Time_taken (min)` is null or `Time_taken (min)` in ("Nan","N/a");

-- 2-Data Wrangling

-- 2.1-Data Cleaning

-- Deleting Rows with inconsistensies

delete from orders where time_orderd like "%.%";

delete from orders where time_order_picked like "%.%";

-- delete rows from orders where the time_orderd_field is null

delete from orders where time_orderd is null or time_orderd in ("Nan","N/a");

-- replace null values in festival field by the mode

select festival, count(*) as festival_count from orders group by festival order by festival_count desc limit 1;

update orders set festival ="No" where festival ="Nan";

-- replace null values from city field by the mode

select city, count(*) as city_count from orders group by city order by city_count desc limit 1;

update orders set city='Metropolitian' where city ="Nan";

-- change the data types of the columns order_date,time_orderd,time_order_picked

update orders set order_date=str_to_date(order_date,"%d-%m-%Y");

alter table orders modify column order_date date;

alter table orders modify column time_orderd time;

alter table orders modify column time_order_picked time;

-- fix time_order_picked where time is more then 23:59:59

UPDATE orders SET time_order_picked = SUBTIME(time_order_picked, '24:00:00') WHERE time_order_picked > '23:59:59';

-- 2.2-Add new column Preparation time

alter table orders add column Preparation_time time;

update orders set preparation_time=timediff(time_order_picked,time_orderd);

update orders set preparation_time=addtime(preparation_time,"24:00:00") where preparation_time<0;

-- 2.3-Binning for column delivery_person_age

select min(delivery_person_age),max(delivery_person_age) from orders;

alter table orders add column delivery_age_bins text;

update orders set delivery_age_bins=case when delivery_person_age between 20 and 24 then '20-24' 
when delivery_person_age between 25 and 29 then '25-29' 
when delivery_person_age between 30 and 34 then '30-34' 
when delivery_person_age between 35 and 39 then '35-39' 
end ;

-- 3-Analysis

-- 3.1-Analyzing delivery performance

-- finding average rating by age
select delivery_age_bins,round(avg(delivery_person_ratings),1) from orders group by delivery_age_bins order by delivery_age_bins;

-- finding top performing delivery people
with cte as(
select delivery_person_id,round(avg(delivery_person_ratings),1) as rating from orders group by delivery_person_id order by rating desc),
ranked as(
select * ,rank() over (order by rating desc) as rn from cte)
SELECT * FROM ranked WHERE rn = 1;

-- finding lowest performing delivery people
with cte as(
select delivery_person_id,round(avg(delivery_person_ratings),1) as rating from orders group by delivery_person_id order by rating ),
ranked as(
select * ,rank() over (order by rating ) as rn from cte)
SELECT * FROM ranked WHERE rn = 1;

-- finding average delivery time by weather condition
select weather_conditions,round(avg(`Time_taken (min)`),1) from orders group by weather_conditions;

-- finding average delivery time by road traffic
select road_traffic_density,round(avg(`Time_taken (min)`),1) from orders group by road_traffic_density;

-- finding average delivery time by vehicle condition
select vehicle_condition,round(avg(`Time_taken (min)`),1) from orders group by vehicle_condition;

-- finding average delivery time by type of vehicle
select type_of_vehicle,round(avg(`Time_taken (min)`),1) from orders group by type_of_vehicle;

-- finding average delivery time by type of order
select type_of_order,round(avg(`Time_taken (min)`),1) from orders group by type_of_order;

-- finding average delivery time by multiple deliveries
select multiple_deliveries,round(avg(`Time_taken (min)`),1) from orders group by multiple_deliveries;

-- finding average delivery time by city
select city,round(avg(`Time_taken (min)`),1) from orders group by city;

-- finding average delivery time by delivery age
select delivery_age_bins,round(avg(`Time_taken (min)`),1) from orders group by delivery_age_bins;

-- 2.2-Operations Analysis

-- finding out average order preparation time by order type
select type_of_order,sec_to_time(round(avg(time_to_sec(preparation_time)))) from orders group by type_of_order;

-- 2.3-Order trend analysis

-- finding out number of orders by month
select monthname(order_date) as order_month,count(*) as orders_num from orders group by monthname(order_date);

-- finding out number of orders by day of week
select dayname(order_date) as order_day,dayofweek(order_date),count(*) as orders_num from orders group by dayname(order_date),dayofweek(order_date) order by dayofweek(order_date);

-- finding out number of orders by hour
select hour(time_orderd) as order_time,count(*) as orders_num from orders group by hour(time_orderd) order by hour(time_orderd);

-- finding distribution of orders by order type
select type_of_order,count(*) from orders group by type_of_order;

-- finding out most common type of orders by weather condition
with cte as (select weather_conditions,type_of_order,count(type_of_order) as num_of_orders from orders group by weather_conditions,type_of_order),
ranking as(select *,rank() over (partition by weather_conditions order by num_of_orders desc) as rn from cte)
select weather_conditions,type_of_order,num_of_orders from ranking where rn=1;

-- finding out most common type of orders by Festival
with cte as (select festival,type_of_order,count(type_of_order) as num_of_orders from orders group by festival,type_of_order),
ranking as(select *,rank() over (partition by festival order by num_of_orders desc) as rn from cte)
select festival,type_of_order,num_of_orders from ranking where rn=1;

