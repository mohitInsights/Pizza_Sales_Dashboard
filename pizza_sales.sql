select * from pizza_sales;

-- 1. KPI's Indicators

-- Total_Revenue
select 
	round(sum(total_price), 2) as Total_revenue 
from pizza_sales;

-- Average Order Value
select 
	round(sum(total_price)/ count(distinct(order_id)), 2) as Average_order_value  
from pizza_sales;

-- Total Pizza Sold 
select
	sum(quantity) as Total_pizza_sold 
from pizza_sales;

-- Total Orders
select
	count(distinct(order_id)) as Total_order
from pizza_sales;

-- Average Pizza Per Order
select 
	round(cast(sum(quantity) as decimal(8, 2)) /
	cast(count(distinct(order_id)) as decimal(8, 2)), 2) as Average_Pizza_Per_Order
from pizza_sales;


-- 2. Charts Requirements 

-- Daily Trend for Total Orders
Select 
	to_char(order_date, 'Day') as weekday_name,
	count(distinct(order_id)) as total_orders
from pizza_sales
group by weekday_name
order by total_orders desc;

-- Hourly Trend for Total Orders
Select 
	To_char(order_time, 'HH24') as Hours, -- Instead, we can use "Extract(Hour from order_time)" to get the hourly trends
	count(distinct(order_id)) as total_orders
from pizza_sales
group by hours
order by hours asc;

-- Percentage of Sales By Pizza Category
Select 
	pizza_category,
	round(sum(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) as total_sales
from pizza_sales
group by pizza_category;

-- Percentage of Sales By Pizza Size

Select
	pizza_size,
	Round(sum(total_price) * 100 / (Select sum(total_price) from pizza_sales), 2) as total_sales
from pizza_sales
group by pizza_size
order by total_sales desc;

-- Top 5 Best Pizza Sold
Select 
	pizza_name AS Best_Pizza_by_sales,
	count(order_id) as total_sales
from pizza_sales
group by pizza_name
order by total_sales desc
limit 5;

-- Top 5 Worst Pizza Sold
Select 
	pizza_name as Worst_Pizza_by_sales,
	count(distinct(order_id)) as total_sales
from pizza_sales
group by pizza_name
order by total_sales ASC
limit 5;


