CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
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
            
select * from retail_sales;

# DATA CLEANING

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

-- total category  
SELECT DISTINCT category FROM retail_sales;

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

SELECT distinct category FROM retail_sales;
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales
WHERE SALE_DATE = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022


select * from retail_sales 
where category = 'clothing' and sale_date between '2022-11-01' and '2022-11-30' and quantity >= 4 ;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category , sum(total_sale),count(*) as total_order from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(age) from retail_sales
where category = 'beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select  * from retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select count(transaction_id),gender , category from retail_sales
group by category , gender ;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select yearly , monthly , avg_sale from (select  year(sale_date) as yearly , month(sale_date) as monthly , avg(total_sale) as avg_sale ,
rank() over(partition by year(sale_date) order by avg(total_sale) desc ) as rnk 
from retail_sales group by yearly , monthly) as t 
where rnk = 1 ;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id , sum(total_sale) as total_sales from retail_sales 
group by customer_id
order by total_sales desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category,count(distinct customer_id) as unique_customer from retail_sales
group by 1 ;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_rate as (select * , case 
when extract(hour from sale_time) <= 12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'evening'
end as shift from retail_sales )

select shift,count(*) as total_orders from hourly_rate
group by shift
order by total_orders desc ;






 
 








 


            
