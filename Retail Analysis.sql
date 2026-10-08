-- SQL Retail Sales Analysis - P1

CREATE DATABASE Retail_Analysis;

-- Create TABLE

DROP TABLE IF EXISTS [dbo].[SQL - Retail Sales Analysis]
CREATE TABLE [dbo].[SQL - Retail Sales Analysis]
            (
                transactions_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
           
use Retail_Analysis;

select top 10 * from [dbo].[SQL - Retail Sales Analysis];

select count(*) as Total_count from [dbo].[SQL - Retail Sales Analysis];



-- Data Cleaning

SELECT * FROM [dbo].[SQL - Retail Sales Analysis]
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- 
DELETE FROM [dbo].[SQL - Retail Sales Analysis]
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

    -- Data Exploration

    -- How many sales we have?
SELECT COUNT(*) as total_sale FROM [dbo].[SQL - Retail Sales Analysis];

-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM [dbo].[SQL - Retail Sales Analysis];

SELECT DISTINCT category FROM [dbo].[SQL - Retail Sales Analysis];

-- Data Analysis & Business Key Problems & Answers

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

