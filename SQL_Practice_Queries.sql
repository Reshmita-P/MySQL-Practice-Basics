# Table: Employee
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
# Tables: Customers & Orders
  
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
case when (year(order_date) % 400 = 0) OR (year(order_date) % 4 = 0 AND year(order_date) % 100 != 0) then 1
else 0 end as dat from orders)
select order_date from ct
where dat=1;

#Method 3
select * from orders
where
case when (year(order_date) % 400 = 0) OR (year(order_date) % 4 = 0 AND year(order_date) % 100 != 0) then 1
else 0 end;

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

# Year, Month and Day function
select year(order_date) from orders;
select month(order_date) from orders;
select day(order_date) from orders;

# Group by even month
select order_date,amount,customer_id from orders
where month(order_date)%2=0;

select count(*) from orders
where month(order_date)%2=0;

# Having Clause: filtering done by aggregate functions
select * from orders
having month(order_date)%2=0;

# Inserting some more values in the existing table
insert into orders(order_date,amount,customer_id) values('2014-11-12','54.76',3);
insert into orders(order_date,amount,customer_id) values('2014-12-07','54.76',3);
insert into orders(order_date,amount,customer_id) values('2016-12-07','58.76',2);

# print details where count of customer_id >1 and there total amount spent
select customer_id, count(customer_id),round(sum(amount),2) as sum from orders
group by customer_id
having count(customer_id)>1;

# group by year that are greater than 2014 and also print there count
  
select year(order_date) as year, count(order_id) as count_of_order_id from orders
where year(order_date)>'2014'
group by year(order_date);

select count(*) as orders_after_2014 from orders
where year(order_date)>'2014';
#group by year(order_date);

------------------------------------------------------------------------------------------------------------------------------------
# Table: emp_manager

# Method 1
create table emp_manager(id int primary key auto_increment, name varchar(30), department varchar(30), manager_id int)auto_increment=101; 

# Method 2
create table emp_manager(id int primary key auto_increment, name varchar(30), department varchar(30), manager_id int); 
alter table emp_manager auto_increment=101;
insert into emp_manager(name,department,manager_id) values('John','A',null),
('Dan','B',101),('James','A',101),('Amy','A',101),('Anne','B',101),('Ron','A',101);
select * from emp_manager;

#Method 3 - Condition: auto increment by 2
set @@session.auto_increment_increment =2; 
# This session allows only till we open this application and use it. once we close and open the application, auto_increment will reset and increments by 1 asusual
# This increments for new values that are updated newly, not for the exsisting data
insert into emp_manager(name, department,manager_id) values('Jay','C',102),('Ram','C',102);

# Inserted after the session, so increment by 2 is not done
select * from emp_manager;
insert into emp_manager(name, department,manager_id) values('Lily','C',103),('Pooja','B',103); 

# print from id = 103 to id = 106

#IN operator
# Method 1
select * from emp_manager
where id in (103,104,105,106);

# Method 2
select * from emp_manager
where id between 103 and 106; 

# Print 5 rows from starting, skipping the first 2 rows
# Method 1
select * from emp_manager
order by id
limit 5 offset 2; # or, limit 5,2 

# Method 2
select * from emp_manager
where id>=103 and id<=106;

# print the name that does not starts with A 
select * from emp_manager
where name not like 'A%';

#print even ids using IN, Between

select * from emp_manager
where id between (select min(id) from emp_manager) and (select max(id) from emp_manager) and id%2=0;

# Print skipping the last 2 rows 
select * from emp_manager e
where (select count(*) from emp_manager e2
where e.department = e2.department and e2.id>e.id) >=2
order by department;
-----------------------------------------------------------------------------------------------------------------------
# Tables: Staffs & Students
  
create table staffs(id int primary key auto_increment, name varchar(30), age int);
insert into staffs(name,age) values ('Seetha',45),('Kumar',50),('Lily',40),('Lalitha',58),('Senthil',55);
select * from staffs;

/* how to use suto increment for 2 columns in a table, where column 1 must start from 2 and column 2 from 1001 ?
This is not possible, unless 1 column values depends on another column
CREATE TABLE employees (
    manager_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT GENERATED ALWAYS AS (id1 + 999) STORED,
    name VARCHAR(50));
*/

create table students(id int primary key auto_increment, name varchar(30), total_marks float);
insert into students(name,total_marks) values('Leela',495),('Suja',400),('Pooja',398),('Saravanan',390),('Siva',415),
('Sheethal',472),('Abisheek',299),('Varun', 398),('Anitha',472);
select * from students;

alter table staffs
rename column name to staff_name,
rename column id to staff_id;

alter table students
rename column name to student_name,
rename column id to student_id;

#JOINS

# Inner Join: Matched column values in both the tables
select * from staffs s1
inner join students s2
on s1.staff_id=s2.student_id;

# Left Outer Join: all records from left table, and matching records from right
select * from students s1
left outer join staffs s2
on s2. staff_id=s1.student_id;

# Joins
create table suppliers(s_id int primary key auto_increment, s_name varchar(30), p_id int, p_name varchar(30));
create table orderss(o_id int primary key auto_increment, p_id int, order_date date);
create table product(p_id int primary key auto_increment, s_id int, p_name varchar(30), price float, foreign key(s_id) references suppliers(s_id));

insert into suppliers(s_name, p_id, p_name) values ('Arun',10,'TV'),('Aravind',11,'Fridge'),('Anand',12,'Fan'),('Anitha',13,'Mobile'),('Alex',13,'Mobile');
insert into orderss(p_id,order_date) values (12,'2026-01-01'),(11,'2026-12-12'),(11,'2026-05-05'),(12,'2026-01-01'),(12,'2026-01-01');
insert into product(s_id,p_name,price) values (1,'TV',80000),(2,'Fridge',70000),(3,'Fan',5000),(4,'Mobile',15000),(5,'Mobile',30000);


select * from suppliers s
right join orderss o on s.p_id = o.p_id
right join product p on s.p_id = p.p_id;

select * from suppliers s
left join orderss o on s.p_id = o.p_id
left join product p on s.p_id = p.p_id;
#fullouterjoin?
select * from suppliers s
left outer join orderss o on s.p_id = o.p_id
union all
select * from suppliers s 
left outer join orderss o on s.p_id = o.p_id;

select * from suppliers s
left outer join orderss o on s.p_id = o.p_id
union 
select * from suppliers s 
left outer join orderss o on s.p_id = o.p_id;

select * from suppliers s
right outer join orderss o on s.p_id = o.p_id
union all
select * from suppliers s 
right outer join orderss o on s.p_id = o.p_id;

select * from suppliers s
left outer join orderss o on s.p_id = o.p_id
union
select * from suppliers s
left outer join product p on s.p_id = p.p_id;

------------------------------------------------------------------------------------------------------------------------------------------------------------

# Primary Key and Foreign Key 
  
create table primari (id int primary key auto_increment, name varchar(30), age int);
insert into primari(name, age) values('Ram',30),('Seetha',20),('Sethu',49),('Velinta',37),('Lily',41);
select * from primari; #parent table is created
alter table primari add column ids not null unique auto_increment; 
/* this will give error, because primary key can be set only once and auto increment can be done only once in a table. though the constraints not null and unique belongs to primary
key */

create table forein (dept_id int primary key auto_increment,id_primari int, Department varchar(30), 
foreign key (id_primari) references primari(id)) auto_increment=101;
insert into forein(Department) values('Science'),('Maths'),('Social'),('Zoology');
select * from forein; # child table created

# using DEFAULT constraint
alter table primari add column city varchar(30) default 'Chennai';
insert into primari(name,age, city) values ('Jack',40,'Mumbai'),('Patrick',38,default); # if we have preferences to enter 
insert into primari(name,age) values ('Jacks',40); # takes the value by default
select * from primari;
/* keyword default must be added, if u want to use the default value. using null there, will assume the 
value for that row as null and it will print null, hence not using the default value */

alter table primari add column date_ date default (current_date);
insert into primari(name,age,city,date_) values('Pick',34,default,default),('Hatrick',35,'Pune','20.03.2020');
select * from primari;

# add new coulmn, and min marks must be (check) marls>45 else show error
alter table primari add column Marks float check (marks>45);
insert into primari(name, age, marks) values('Lily',24,59);
insert into primari(name, age, marks) values('Anitha',42,44); #constraint violation error will throw

/* Changing column name
condition: for MySql < version 5.0 : keyword- CHANGE
MySql > version 5.0: Keyword- Rename
*/

alter table primari rename column marks to My_marks; # if a column name has check constraint, then that column cannot be renamed nor dropped
alter table primari rename column name to user_name;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

# User defined function to add 2 numbers
delimiter $$
create function add_2_number(a int,b int)
returns int
deterministic
begin
  return a+b;
  end $$
delimiter ;
select add_2_number(10,30);

# Create a function to return average of 3 numbers

delimiter $$
create function avg_3(a float, b float, c float)
returns float
deterministic
begin
 return (a+b+c)/3 ;
 end $$
delimiter ;
select round(avg_3(40,0.2,80.5),2);

# Max of 2 numbers using if else

delimiter $$
create function max_of_2(a float, b float)
returns float
deterministic
begin
 if a>b then
   return a;
 elseif b>a then
   return b;
 else return null;
 end if;
 end $$
 delimiter ;
 select max_of_2(8,2);










			






















