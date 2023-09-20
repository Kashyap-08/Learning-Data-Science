-- CREATE DATABASE
create database sql_practice;

-- SET THE DATASET AS DEFAULT
use sql_practice;

-- CREATE TABLE employee
create table employee(emp_id int not null,
first_name varchar(20),
last_name varchar(20),
DOB date,
hire_date date,
postion varchar(20),
salary float);

-- INSERT RECORDS
insert into employee values(101, "shashi", "Kumar", '1998-04-25', '2021-01-19','Data Engineer', 25000),
(102, 'krish','naik', '1988-08-18', '2014-01-23','Teacher', 100000),
(103, 'samir', 'mishra', '1985-04-12', '2017-04-10', 'Data Analyst', 50000),
(104, 'suraj', 'warma', '1994-07-02', '2019-03-07', 'Data Engineer', 75000);

-- UPDATE RECORDS
update employee set salary = 45000 where emp_id = 104;

-- LOOK AT THE DATA
select * from employee;

-- INSERT NEW COLUMN
alter table employee
add dept varchar(20);

-- DELETE ROW
delete from employee where emp_id = 102;

-- DROP COLUMN 
alter table employee 
drop dept;

-- DROP TABLE
drop table if exists employee;

-- DROP DATABASE
drop database sql_practice;

