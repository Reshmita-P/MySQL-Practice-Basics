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

# Print gender, where age>40
select gender from employee
where age>40;

# Select name where the second character is a (%: all character ; _: one character)
select name from employee
where name like '_a%';

#AND, OR, NOT
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






















