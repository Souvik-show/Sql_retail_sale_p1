create database if not exists sql_project_p1;
use sql_project_p1;

create table retail_sales 
(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(45),	
quantity int,
price_per_unit float,
cogs float,
total_sale float
) ;

select count(*) from retail_sales;
drop table retail_sales;

create table retail_sales 
(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(45),	
quantity int,
price_per_unit float,
cogs float,
total_sale float
) ;

select*from reatil_sales;

drop table retail_sales;

select count(*)from reatil_sales;

SELECT a.ï»¿transactions_id + 1 AS missing_id
FROM reatil_sales as  a
LEFT JOIN reatil_sales as b ON a.ï»¿transactions_id + 1 = b.ï»¿transactions_id
WHERE b.ï»¿transactions_id IS NULL
  AND a.ï»¿transactions_id < (SELECT MAX(ï»¿transactions_id) FROm reatil_sales);
  
  select * from reatil_sales
  where ï»¿transactions_id in(150,432,679,746,797,845,921,1150,1225,1367,1391,1432,1845);

alter table reatil_sales rename to retail_sales;
alter table retail_sales change ï»¿transactions_id transactions_id int;
select*from retail_sales;

insert into retail_sales
values
(679,'26-08-2022','08:59:00',64,'Female',18,'Beauty',null,null,null,null),
(746,'05-07-2022','11:33:00',42,'Female',33,'Clothing',null,null,null,null),
(1225,'02-02-2022','09:51:00',137,'Female',57,'Beauty',null,null,null,null);

insert into retail_sales
values
(150,'13-04-2022','08:25:00',89,'Female',null,'Electronics',4,30,16.2,120),
(432,'10-03-2022','11:31:00',17,'Female',null,'Electronics',2,500,190,1000),
(797,'16-09-2022','06:38:00',116,'Male',null,'Clothing',3,25,10.75,75),
(845,'27-10-2022','10:12:00',25,'Male',null,'Clothing',1,500,145,500),
(921,'28-09-2022','09:34:00',101,'Male',null,'Electronics',3,25,8,75);

insert into retail_sales
values
(1391,'01-03-2022','11:29:00',130,'Male',null,'Beauty',2,25,9.25,50),
(1432,'25-12-2022','06:24:00',67,'Female',null,'Electronics',2,500,245,1000),
(1845,'24-05-2022','07:06:00',94,'Male',null,'Clothing',1,500,185,500);

SELECT a.transactions_id + 1 AS missing_id
FROM retail_sales as  a
LEFT JOIN retail_sales as b ON a.transactions_id + 1 = b.transactions_id
WHERE b.transactions_id IS NULL
  AND a.transactions_id < (SELECT MAX(transactions_id) FROm retail_sales);

insert into retail_sales
values
(1150,'22-08-2022','10:04:00',77,'Female',null,'Electronics',4,30,10.2,120),
(1367,'15-04-2022','11:38:00',16,'Female',null,'Electronics',1,50,15.5,50);

select count(*) from retail_sales;

select * from retail_sales
where
transactions_id is null or
sale_date is null or
sale_time is null or
customer_id is null or
gender is null or
category is null or
quantity is null or
price_per_unit is null or
cogs is null or
total_sale is null;

alter table retail_sales change quantiy quantity int;

delete from retail_sales
where
transactions_id is null or
sale_date is null or
sale_time is null or
customer_id is null or
gender is null or
category is null or
quantity is null or
price_per_unit is null or
cogs is null or
total_sale is null;

select count(*) from retail_sales;

select date_format(sale_date,'%Y-%M-%D') as sale_date_formatted
from retail_sales;

SELECT DATE_FORMAT(STR_TO_DATE(sale_date, '%d-%m-%Y'), '%Y-%m-%d') AS formatted_sale_date
FROM retail_sales;

update retail_sales
set sale_date=str_to_date(sale_date,'%d-%m-%Y');

ALTER TABLE retail_sales
MODIFY sale_date DATE;

UPDATE retail_sales
SET sale_time = STR_TO_DATE(sale_time, '%H:%i:%s');

ALTER TABLE retail_sales
MODIFY sale_time TIME;

ALTER TABLE retail_sales
MODIFY cogs float;

ALTER TABLE retail_sales
MODIFY total_sale float;

ALTER TABLE retail_sales
MODIFY price_per_unit float;

select*from retail_sales;

select * from retail_sales;
-- Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date='11-05-2022';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select *
from retail_sales
where category='Clothing'
     and Quantity>=4
     and sale_date between '2022-11-01' and '2022-11-30';
     
-- Write a SQL query to calculate the total sales (total_sale) for each category
select category,sum(total_sale) as Sum_total_sale,count(*) as Count_total_sale
from retail_sales
group by category
order by sum_total_sale desc;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
select category,round(avg(age),2) as Average_age
from retail_sales
group by category
having category='beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000
select transactions_id
from retail_sales
where total_sale>1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
Select category,gender,count(*) as no_of_transactions from retail_sales
group by category,gender
order by category,gender;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year(sale_date) as year_sale,
       month(sale_date) as month_sale,
       round(avg(total_sale),2) as Avg_sale
from retail_sales
group by year_sale,month_sale
order by year_sale,Avg_sale desc;

-- Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale) as highest_total_sale
from retail_sales
group by customer_id
order by highest_total_sale desc
Limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
	count(distinct customer_id) as unique_customer
from retail_sales
group by category
order by unique_customer desc;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS num_orders
FROM 
    retail_sales
GROUP BY 
    shift
ORDER BY  FIELD(shift, 'Morning', 'Afternoon', 'Evening')
