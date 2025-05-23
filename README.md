![image](https://github.com/user-attachments/assets/8b4b53ee-0468-43c0-8bf4-b8a7f83be99c)# Analyzing-Restaurant-Operations-and-Order-Trends-with-SQL
## Overview
This project uses SQL to analyze restaurant data with the goal of understanding order trends, optimizing delivery performance, and evaluating operational efficiency.
## Objectives
- Evaluate Operational Efficiency
- Analyze Order Trends
- Assess Delivery Performance
- Improve Resource Planning
- Support Data-Driven Decision Making
## Dataset
This dataset is in csv format, includes 45,000 row where each row represents an order, 20 columns which are:
- ID
- Delivery_Person_ID
- Delivery_Person_Age
- Restaurant_Latitude
- Restaurant_Longitude
- Delivery_Location_Latitude
- Delivery_Location_Longitude
- Order_Date
- Time_Orderd
- Time_Order_Picked
- Weather_Conditions
- Road_Traffic_Density
- Vehicle_Condition
- Type_Of_Order
- Type_Of_Vehicle
- Multiple_Deliveries
- Festival
- City
- Time_Taken(min)
## 1- Import the Data
Utilize the Data Table Import Wizard to Import the csv file. 
## 2- Data Profiling
- Getting familiar with the data
- Checking the Data Types of each column
- Check if there are any Duplicate Orders
- Check for Missing Values
## 3- Data Wrangling
### 3.1- Data Cleaning
- Deleting rows with inconsistencies
- Deleting rows where Time_Orderd is null
- Replace null values in Festival field by the mode
- Replace null values in City field by the mode
- Change the data types of the columns Order_Date, Time_Orderd,Time_Order_Picked
- Fix Time_Order_Picked where time is more then 23:59:59
### 3.2- Add New Column
- Add new column Preparation time
### 3.3- Binning
- Binning for column Delivery_Person_Age
## 4- Analysis
### 4.1- Delivery Performance Analysis
- Average Rating by Age bins
- Top Performing Delivery People
- Top Performing Delivery People
- Average Delivery Time by Weather Condition
- Average Delivery Time by Road Traffic
- Average Delivery Time by Vehicle Condition
- Average Delivery Time by Type of Vehicle
- Average Delivery Time by Type of Order
- Average Delivery Time by Multiple Deliveries
- Average Delivery Time by City
- Average Delivery Time by Delivery Person Age
### 4.2 Operations Analysis
- Average Order Preparation Time by Order Type
### 4.3 Order Trend Analysis 
- Number of Orders by Month
- Number of Orders by Day of Week
- Number of Orders by Hour
- Distribution of Orders by Order Type
- Most Common Type of Orders by Weather Condition
- Most Common Type of Orders by Festival
## 5- Insights
- Delivery Agents in their 20's tend to have slightly higher ratings than those in their 30's.
- Average Delivery time in Cloudy/Foggy weather is the longest (28.8-28.9) mins., slightly shorter in Stormy/Windy (25.8,26.1) mins. and the shortest Average delivery time is usually in the sunny weather (22) mins..
- Average Delivery time for Vehicles with condition 0 is around 30 mins. which is 6 minutes longer than condition 1,2.
- Delivery using motorcycles has the longest average delivery time 27.6 mins. which is aroud 3 minutes longer than scooters and electric scooters.
- Semiurban cities have the longest average delivery time 49 mins, Metropolitan 27.1 mins and the shortest is in urban cities 23 mins. 
- Average delivery times for agents in their 30's is around 29 mins. which is 6 mins. longer than average delivery times for agents in their 20's.
- March was the month of highest number of orders around 5x the number of orders in February or April.
- Wednesdays and Fridays are the busiest days of the week.
- Hours from 5pm-11pm are the busiest hours of the day.


- 
