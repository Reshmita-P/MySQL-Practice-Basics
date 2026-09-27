# Creating and using the database
create database org;
use org;

# Creating table and and inserting values
create table employee(Id int primary key auto_increment, Name varchar(30), Salary int, Age int, Gender VarChar(10), Dept VarChar(30));
insert into employee(Name, Salary, Age, Gender, Dept) values('Anne',95000,43,'Female','Sales');
insert into employee(Name, Salary, Age, Gender, Dept) values('Claire',80000,35,'Female','Analytics');
insert into employee(Name, Salary, Age, Gender, Dept) values('David',70000,45,'Male','Operations');
insert into employee(Name, Salary, Age, Gender, Dept) values('Phil',85000,37,'Male','Sales');
insert into employee(Name, Salary, Age, Gender, Dept) values('Ray',90000,45,'Female','Analytics');
insert into employee(Name, Salary, Age, Gender, Dept) values('Rachel',60000,27,'Female','Sales');
insert into employee(Name, Salary, Age, Gender, Dept) values('Bob',80000,34,'Male','Operation');

# Selecting the table
select * from employee;

# Sub queries
select name from employee
where salary=(select max(salary) from employee);
select dept from employee
where age = (select min(age) from employee);
select name, gender from employee
where id = (select max(id) from employee);

# Aggregate function
select avg(age) from employee;
select age from employee
where age > (select avg(age) from employee);
select count(*) as count from employee;

# Selecting employees with even and odd id number
select * from employee
where id%2=0;

select count(*) as even_id_count from employee
where id%2=0;

# Employee name starting with 'R'
select * from employee
where name like 'R%';

# Print first 3 rows
select * from employee 
where id<=3;

select * from employee
limit 3;

# Print last 3 rows
select * from employee 
order by id desc
limit 3;

# Using window function, to display the id number in asc when aim is to print rows from last
select id,Name, Salary, Age, Gender, Dept from(select *,
row_number()over(order by id desc) as rn from employee) a 
where rn <=3
order by id;

# Print gender, where age>40
select gender from employee
where age>40;

# Select name where the second character is a (%: all character ; _: one character)
select name from employee
where name like '_a%';

#AND,OR, NOT
select * from employee
where id >5 and dept ='Sales';

select * from employee
where id > 5 and dept <> 'Sales';

# Update table
update employee set name = 'Jeni' where id=7;

# Print names that end with vowels 
select name from employee
where name like '%a' or name like '%e' or name like '%i' or name like '%o' or name like '%u';

select name from employee
where name regexp '[aeiou]$';

# Count of sales dept
select count(*) as count_of_sales from employee where dept = 'Sales';

# Group by dept
select dept, count(dept) as count_of_department from employee
group by dept;

--------------------------------------------------------------------------------------------------------------------------------------------------------
# Working with 2 tables
  
create table customers(customer_id int primary key auto_increment, first_name varchar(30), last_name varchar(30), email varchar(30));
insert into customers(first_name,last_name,email) 
values ('Boy','George','george@gmail.com')
,('George','Michael','gm@gmail.com')
,('David','Bowie','david@gmail.com')
,('Blue','Steele','blue@gmail.com');
select * from customers;

create table orders (order_id int primary key auto_increment, order_date date, amount float, customer_id int);
insert into orders (order_date,amount,customer_id) 
values ('2016/02/10',99.99,1),('2017/11/11',35.50,1),('2014/12/12',800.67,2),('2015/01/03',12.50,2);
select * from orders;

# Print leap year order_date column from orders table
  
#Method 1 
select * from orders
where dayofyear(concat(year(order_date),'-12-31')) = 366;

#Method 2
with ct as (select *,
case
when 
(year(order_date) % 400 = 0)
OR
(year(order_date) % 4 = 0 AND year(order_date) % 100 != 0) then 1
else 0
end as dat from orders)
select order_date from ct
where dat=1;

#Method 3
select * from orders
where
case
when 
(year(order_date) % 400 = 0)
OR
(year(order_date) % 4 = 0 AND year(order_date) % 100 != 0) then 1
else 0
end;

# Group the same customer_id from orders table and print the max amount 
select max(amount) as maximum_amount from orders
group by customer_id;

# Print last_name that endswith 'e' in customers table
select last_name from customers
where last_name like '%e';

# Print the first and last name that ends with 'e' in customers table
select first_name, last_name from customers
where first_name like '%e' and last_name like '%e';

# Print minimum amount from last 3 rows in orders table
select min(amount) from orders
limit 3;






















