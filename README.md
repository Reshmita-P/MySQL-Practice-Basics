# MySQL-Practice-Basics
MySQL Practice queries

-> Creating and using the database
-> Creating table, inserting, alter and updating the table
-> Where, Group by, Having, Order by, Limit, offset
-> Aggregate functions
-> Logical Operators
-> Pattern matching operators
-> Subqueries
-> Window Functions
-> dayofyear(), concat()
-> Joins
-> Auto increment column values
-> IN, NOT IN, LIKE, REGEXP
-> Constraints
-> User Defined Functions

CONSTRAINTS
1. Primary Key: 
   - Unique Identifier 
   - Unique (keyword during table creation supports null value but not duplicates
   - Strictly allowed for only 1 column in a table. 
   - Mandatory that each table must have unique identifier
   - It is a combination of not null and unique constraint
   - Primary must be initialized while creating the table itself, because, if we alter the table to add a new column
   of primary key in the exsisting table, then for the availble rows it will put null by default
   and null is not supported for primary key. in that case the values in the table must be truncated to add a new primary key columns
   - SYNTAX: create table_name(col_name primary key);
2. Foreign Key
   -  A column in table, that refers to primary key in another table
   - It establishes link between 2 tables
   - Prevents action that destroies the link between these 2 tables
   - Foreign key column table is called the child table (inheritance concept, data from parent to child)
   - foreign key/references
   - Query:-

create table child_table_name(col_1 data_type primary key,
                     col_2 data_type,
                     FOREIGN key(col_2)
                     REFERENCES parent_table_name(col_name));

drop table display;

Cannot delete or update a parent row: a foreign key constraint fails

Inheritance- Deriving a data from parent to child

3. Candidate Key
4. Check 
5. Default
