use `premier_products`;
show tables;

-- print all rows and columns -- 
select * from customer;
select * from order_line;
select * from orders;
select * from part;
select * from sales_rep;

-- All rows, last name , first name, sales rep number, city from sales rep table  -- 
select last_name, first_name, sales_rep_num, city from sales_rep;

-- orders and customer number from orders --
select order_num, customer_num from orders;

-- two rows from order_line --
select * from order_line
order by order_num limit 2;

-- entries from customer where sales rep num = 20 --
select c.*, s.sales_rep_num
from customer c
join sales_rep s on s.sales_rep_num=c.sales_rep_num
where s.sales_rep_num=20; 

-- Select only customer name, balance, credit limit from customer where sales rep num=20 --
 select c.customer_name, c.balance, c.credit_limit, s.sales_rep_num
from customer c
join sales_rep s on s.sales_rep_num=c.sales_rep_num
where s.sales_rep_num=20; 

-- Select part num, num ordered, quoted price and total price where total price is (num_ordered * quoted_price) where only 1 num ordered and the order number is 21617 -- 
select part_num, num_ordered, quoted_price, num_ordered*quoted_price as total_price from order_line
where num_ordered=1 and order_num=21617;
-- no results --
-- this produced two results --
select part_num, num_ordered, quoted_price, num_ordered*quoted_price as total_price from order_line
where order_num=21617;

-- all orders from order date between 2010-10-20 and 2010-10-22 --
select * from orders
where order_date>'2010-10-20' and order_date<'2010-10-22';

-- all parts where the part description starts w/ 'D' and end w/ 'er' --
select * from part
where part_description like 'D%' and part_description like '%er';

-- total balance from customer --
select sum(balance) as total_balance from customer;

-- minimum balance from customer --
select min(balance) as minimum_balance from customer;

-- count number of customer in customer --
select count(customer_name) as total_customer from customer;

-- select order num where the quote price is more than 500 but less than 1000 --
select order_num, quoted_price from order_line 
where quoted_price>500 and quoted_price<1000;

-- Create a new table of customer name, last name, and first name from customer and sales rep table by matching up their primary key --

-- I got this code to work
select customer.customer_name, sales_rep.last_name, sales_rep.first_name from customer, sales_rep 
where sales_rep.sales_rep_num=customer.sales_rep_num; 

-- But creating a table would not work for me and I did not have time to fix it 

-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ') CREATE TABLE trial AS ( select customer.customer_name, sales_rep.last_name, ' at line 1
CREATE TABLE customer_and_sales_rep 
AS ( 
SELECT customer.customer_name, sales_rep.last_name, sales_rep.first_name 
TABLE customer, sales_rep
WHERE sales_rep.sales_rep_num=customer.sales_rep_num; 
)

-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ') CREATE TABLE trial AS ( select customer.customer_name, sales_rep.last_name, ' at line 1
CREATE TABLE trial 
AS ( select customer_name, last_name, first_name 
from customer, sales_rep 
where sales_rep.sales_rep_num=customer.sales_rep_num
);

-- Error Code: 1142. INSERT,CREATE command denied to user'ds160'@'10.10.27.215'for table new
create table new
as ( select customer_name
from customer
);

 