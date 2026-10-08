Retail Sales Analysis SQL Project

Project Overview :

Database : Retail_Analysis 
Table : [dbo].[SQL - Retail Sales Analysis]
Tools Used : SQL Server 
Focus : Data Cleaning, EDA, Business Insights 

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

Objectives : 
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.

Data Cleaning: 
Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

Project Structure :
1. Database Setup
Database Creation: The project starts by creating a database named Retail_Analysis.
Table Creation: A table named dbo].[SQL - Retail Sales Analysis] is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
CREATE DATABASE Retail_Analysis;

3. Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.

SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers :

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
use retail_analysis;
select * from [dbo].[SQL - Retail Sales Analysis]
where sale_date = '2022-11-05';

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from [dbo].[SQL - Retail Sales Analysis]
where category = 'Clothing' and 
quantiy >= 4 and 
sale_date >= '2022-11-01' and 
sale_date < '2022-12-01';

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as Total_Sales,count(*) as total_orders from [dbo].[SQL - Retail Sales Analysis]
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as avg_age from [dbo].[SQL - Retail Sales Analysis]
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from [dbo].[SQL - Retail Sales Analysis]
where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender, category, count(*) as total_transactions from [dbo].[SQL - Retail Sales Analysis]
group by gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
WITH MonthlySales AS
( SELECT YEAR(sale_date) AS sales_year,MONTH(sale_date) AS sales_month,AVG(total_sale) AS avg_sale FROM [dbo].[SQL - Retail Sales Analysis]
GROUP BY YEAR(sale_date),MONTH(sale_date)),
RankedSales AS(
SELECT sales_year,sales_month,avg_sale,RANK() OVER ( PARTITION BY sales_year ORDER BY avg_sale DESC) AS rn FROM MonthlySales)
SELECT sales_year AS [Year], sales_month AS [Month], avg_sale FROM RankedSales
WHERE rn = 1
ORDER BY sales_year;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select top 5 customer_id, sum(total_sale) as Total_sales from [dbo].[SQL - Retail Sales Analysis]
group by customer_id
order by sum(total_sale) desc;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id) as Unique_customer from [dbo].[SQL - Retail Sales Analysis]
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale 
as(
select *, case when DATEPART (hour , sale_time) <12 then 'Morning'
               when DATEPART (hour , sale_time) between 12 and 17 then 'Afternoon'
          else 'evening' end as shift from [dbo].[SQL - Retail Sales Analysis])

          select shift,count(*) as total_orders from hourly_sale 
          group by shift

Findings :
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

Reports :
Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
Trend Analysis: Insights into sales trends across different months and shifts.
Customer Insights: Reports on top customers and unique customer counts per category.

Conclusion :
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

Thank you for your support, and I look forward to connecting with you!
