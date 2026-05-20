CREATE DATABASE sql_project1;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    transactions_id INT primary key,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit INT,
    cogs FLOAT,
    total_sale FLOAT
);
SELECT * FROM retail_sales
limit 10;

SELECT * FROM retail_sales
WHERE transactions_id IS NULL
    OR
	sale_date IS NULL
    OR
	sale_time IS NULL
    OR
	customer_id IS NULL
    OR
	gender IS NULL
    OR
	category IS NULL
    OR
	quantity IS NULL
    OR
	price_per_unit IS NULL
    OR
	cogs IS NULL
    OR
	total_sale IS NULL;


--- DATA CLEANING ---

DELETE FROM retail_sales
WHERE transactions_id IS NULL
    OR
	sale_date IS NULL
    OR
	sale_time IS NULL
    OR
	customer_id IS NULL
    OR
	gender IS NULL
    OR
	category IS NULL
    OR
	quantity IS NULL
    OR
	price_per_unit IS NULL
    OR
	cogs IS NULL
    OR
	total_sale IS NULL;

SELECT COUNT(*) FROM retail_sales;

---DATA EXPLORATION---

---how many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

---how many unique customers we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

---how many unique category we have?
SELECT COUNT(DISTINCT category) FROM retail_sales;


---DATA ANALYSIS OR Business key problems

---Ques1 Write a SQL query to retrieve all columns for sales made on ' 2022-11-05
SELECT * FROM retail_sales 
WHERE sale_date ='2022-11-05';

---Ques2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category ILIKE 'Clothing'
AND quantity >= 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

---Ques3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY category;

---Ques4 Write a SQL query to find the average age of customers who purchased items from the "Beauty' category.
SELECT ROUND(AVG(age),2) as AVG_age
FROM retail_sales
WHERE category ILIKE 'Beauty';

---Ques5 Write a SQL query to find all transactions where the total sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale >1000;

---Ques6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT category,gender,COUNT(transactions_id) 
FROM retail_sales
GROUP BY gender,category;

---Ques7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT AVG(total_sale) AS average_sale,EXTRACT(MONTH FROM sale_date) AS month,EXTRACT(YEAR FROM sale_date) AS year
FROM retail_sales
GROUP BY month,year
ORDER BY year,average_sale DESC;

---Ques8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
customer_id,SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

---Ques9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT COUNT(Distinct customer_id) as unique_customers, category
FROM retail_sales
GROUP BY category;

---Ques10  Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(SELECT *,
CASE 
    WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
END AS Shift
FROM retail_sales
)

SELECT 
Shift,COUNT(transactions_id)
FROM hourly_sale
GROUP BY Shift;
---Here above we have created common table expression(CTE) as without it we can not use the new created coloumn for order by and group by.
 
  												   ---END OF THE PROJECT---
