create database  walmart_db;
use walmart_db;

select count(*) from walmart;

select * from walmart limit 10;

select distinct payment_method from walmart;

select payment_method ,count(*)
from walmart 
group by payment_method;

select count(distinct Branch)
from walmart;

select Branch,count(*)
from walmart
group by Branch;

-- Business Problems
-- Q.1 Find different payment methods, number of transactions, and quantity sold by payment method

select payment_method ,
		count(*) as no_payments,
        SUM(quantity) as no_qty_sold
from walmart 
group by payment_method;

-- Q.2 Identify the highest-rated category in each branch
-- Display the branch, category, and avg rating

SELECT *
FROM (
    SELECT 
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank_no
    FROM walmart
    GROUP BY branch, category
) AS ranked
WHERE rank_no = 1;

-- Q.3 Identify the busiest day for each branch based on the number of transactions
select
	branch,
    DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS day_name,
    count(*) as no_transactions
from walmart
group by branch,day_name
order by no_transactions desc;

-- Q4: Calculate the total quantity of items sold per payment method

select 
	payment_method,
    sum(quantity) as no_qty_sold
from walmart
group by payment_method;


-- Q5 Determine the average, minimum, and maximum rating of categories for each city

select 
	city,
    category,
    avg(rating) as avg_rating,
    min(rating) as min_rating,
    max(rating) as max_rating
from walmart
group by city,category
order by city;

-- Q6: Calculate the total profit for each category
select
	category,
    sum(unit_price*quantity*profit_margin) as total_profit
from walmart
group by category
order by total_profit  desc;

select * from walmart;

-- Q7: Determine the most common payment method for each branch
select
	branch,
    payment_method,
    count(*) as total_tran,
    rank() over(partition by branch order by count(*) desc) as rank_no
from walmart
group by branch,payment_method;
-- order by branch desc;

-- Q8: Categorize sales into Morning, Afternoon, and Evening shifts

select 
	branch,
	case
		when hour(time(time))<12 THEN 'morning'
        when hour(time(time)) between 12 and 18 then 'afternoon'
        else 'evening'
        end day_time,
        count(*)
from walmart
group by branch, day_time
 order by day_time desc;
        
-- Q9: Identify the 5 branches with the highest revenue decrease ratio from last year to current year (e.g., 2022 to 2023)

with revenue_2022 AS (
    select 
        branch,
        SUM(unit_price*quantity) as revenue
    from walmart
    where year(STR_TO_DATE(date, '%d/%m/%Y')) = 2022
    group by branch
),
revenue_2023 as (
    select 
        branch,
        SUM(unit_price*quantity) AS revenue
    from walmart
    where year(STR_TO_DATE(date, '%d/%m/%Y')) = 2023
    group by  branch
)
select 
    r2022.branch,
    r2022.revenue as 2022_revenue,
    r2023.revenue as 2023_revenue,
    ROUND(((r2022.revenue - r2023.revenue) / r2022.revenue) * 100, 2) as revenue_decrease_ratio
from revenue_2022 as r2022
join revenue_2023 as r2023 on r2022.branch = r2023.branch
where r2022.revenue > r2023.revenue
order by revenue_decrease_ratio desc
limit 5;

-- view table for customer

create view customer_view as
select invoice_id,branch,city,category,unit_price,quantity,date,time,rating 
from walmart;

select * from customer_view;

-- to view profit
create view profit_view as
select category ,unit_price,quantity,date,time,profit_margin
from walmart;

select * from profit_view;

-- branch table
CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_code VARCHAR(5),
    city VARCHAR(100)
);


-- product table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_line VARCHAR(100),
    unit_price DECIMAL(10, 2)
);

-- customer table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_type VARCHAR(50),
    gender VARCHAR(10)
);

-- sales table
CREATE TABLE sales (
    invoice_id VARCHAR(20) PRIMARY KEY,
    branch_id INT,
    customer_id INT,
    product_id INT,
    quantity INT,
    tax DECIMAL(10,2),
    total DECIMAL(10,2),
    date DATE,
    time TIME,
    payment VARCHAR(20),
    rating FLOAT,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

