SELECT 
    time,
    CASE 
        WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        ELSE 'Evening' 
    END AS time_of_day
FROM 
    sales;


-- First, add the new column to the table

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
UPDATE sales
SET time_of_day = (
    CASE 
        WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END
);



-- to get the name of days

SELECT date,
TO_CHAR(date, 'FMDay') AS day_name
FROM sales;


-- to add new column day_name to the table

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales
SET day_name = TO_CHAR(date, 'FMDay');


-- to get the name of months from the table

SELECT date, 
     TO_CHAR(date, 'FMMonth') as month_name 
FROM sales



-- to add new column month_name to the table

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = TO_CHAR(date, 'FMMonth');


----------------------EDA---------------------------


-- Q1 how many unique cites are in the table

SELECT DISTINCT city FROM sales;



-- Q2 in which city have each branch?

SELECT DISTINCT branch, city FROM sales;



-- 1. how many unique products are in the table

SELECT COUNT(DISTINCT product_line) FROM sales


-- 2. which one payment is quite used in the table

SELECT payment, COUNT(payment) as common_payment_method
FROM sales
GROUP BY payment
ORDER BY common_payment_method DESC
LIMIT 1 -- for selecting only popular payment methods

-- 3. top 5 selling product in the table

SELECT product_line, COUNT(product_line) as most_sell_product
FROM sales
GROUP BY product_line
ORDER BY most_sell_product DESC LIMIT 5

-- 4 totol revenue per month

SELECT month_name, SUM(total) as total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC

-- 5. in which month get highest cost of goods sold?

SELECT month_name, SUM(cogs) as total_cogs
FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC

-- 6. which product line generate highest revenue?

SELECT product_line, SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC
LIMIT 

-- 7. which city produce highest revenue?

SELECT city, SUM(total) as total_revenue

FROM sales

GROUP BY city

ORDER BY total_revenue DESC


-- 8. which top 5 products line incured the highest VAT?

SELECT product_line, SUM(vat) as total_VAT

FROM sales

GROUP BY product_line

ORDER BY total_VAT DESC

-- 9.  adding a column to the table that retrive each product line according to product category

First, add the new column to the table
ALTER TABLE sales ADD COLUMN product_category VARCHAR(20);

-- Then, update the table with the appropriate values for product_category
UPDATE sales 
SET product_category = 
(CASE 
    WHEN total >= (SELECT AVG(total) FROM sales) THEN 'Good'
    ELSE 'Bad'
END);


-- 10. which brand sold more products than the average product sold?

SELECT branch, SUM(quantity) as quantity

FROM sales

GROUP BY branch

HAVING SUM(quantity) > AVG(quantity)

ORDER BY quantity DESC
LIMIT 1;


-- 11. what is the most popular product by gender?

SELECT gender, product_line, COUNT(gender) AS total_count

FROM sales

GROUP BY gender, product_line

ORDER BY total_count DESC


-- 12. what is the average rating of each product line?

SELECT product_line, ROUND(AVG(rating),2) as average_rating
FROM sales

GROUP BY product_line

ORDER BY average_rating DESC;


============== Sales Analysis ==================


-- 1. number of sales made in each day of week?

SELECT day_name, time_of_day, COUNT(invoice_id) as total_sale

FROM sales

GROUP BY day_name, time_of_day
HAVING day_name NOT IN ('Sunday', 'Saturday');


SELECT day_name, time_of_day, COUNT(invoice_id) as total_sale
FROM sales
WHERE day_name NOT IN ('Sunday', 'Saturday')
GROUP BY day_name, time_of_day


-- 2. identify the customer type that generates the highest rev

SELECT customer_type, SUM(total) as total_sale

FROM sales

GROUP BY customer_type

ORDER BY total_sale DESC 

-- 3. which city has te largest VAT ?

SELECT city, SUM(VAT) as total_VAT
FROM sales
GROUP BY city
ORDER BY total_VAT DESC

-- 4. which customer type pays the most in VAT?

SELECT customer_type, SUM(VAT) as total_VAT

FROM sales

GROUP BY customer_type

ORDER BY total_VAT DESC





-- Customer Analytics

-- 1. how many unique customer data have?

SELECT COUNT(DISTINCT customer_type)
FROM sales


-- 2. how many unique payment methos have?

SELECT COUNT(DISTINCT payment) FROM sales


-- 3. common customer type

SELECT customer_type, COUNT(customer_type) as common_customer

FROM sales

GROUP BY customer_type

ORDER BY common_customer DESC

-- 4. how many gender have?

SELECT gender, COUNT(gender) as common_gender

FROM sales

GROUP BY gender

ORDER BY common_gender DESC;

-- 5. gender distribution per branch

SELECT branch, gender, COUNT(gender) as gender_distribution

FROM sales

GROUP BY branch, gender

ORDER BY branch;


-- 6. which time of thd day do customers give most ratings?

SELECT time_of_day, AVG(rating) as avg_rating

FROM sales

GROUP BY time_of_day


SELECT day_name, AVG(rating) as avg_rating

FROM sales

GROUP BY day_name


-- 7. which day of the week has the best average rating per branch?

SELECT branch, day_name, AVG(rating) as avg_rating

FROM sales

GROUP BY branch, day_name

ORDER BY avg_rating DESC