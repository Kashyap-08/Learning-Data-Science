## NOTES:
/*
Constraint: 
	* It is used to specify the rules that allows or restricts what value will be stord in a table.alter
	* they are used to ensure accuray and integrity of the table.
	* Constraint can be defined while creating table/modifying table by using CREATE or ALTER command
	* There are 2 types of containts: Column level and Table level
	* Ex: "NOT NULL", "AUTO_INCREMENT", "PRIMARY_KEY", "UNIQUE", "CHECK", "ENUM", "FOREIGN_KEY", "DEFAULT"
*/


-- CREATE DATABASE
create database sql_practice_02;

-- USE THE Test1 DATABASE AS DEFAULT DATABASE
USE sql_practice_02;


-- CREATE TABLE WITHIN DATABASE
CREATE TABLE customer_info(
uuid int auto_increment, 
id int not null,
first_name varchar(20),
last_name varchar(20),
city varchar(20),
date date,
sales int,
key(uuid) -- SET uuid AS KEY SO THAT ANY OTHER COLUMN CAN BECOME PRIMARY-KEY
);
-- NOTE: auto_increment atomatically assign new values to row in incrementail format. In this we may need to set the auto-increment column as index. 
-- then we are free to make any other column as primary key.
-- while inserting if no auto_increment value is specified it will start increment by 1 bydefault
-- if any auto_increment value is given then it will start from the same point

describe customer_info;

-- INSERT DATA INTO sales
INSERT INTO customer_info(id, first_name, last_name, city, date, sales) values(101, 'kashyap', 'kolhe', 'Nagpur', '2023-08-07', 251),
(102, 'raju', 'rastogi', 'Mumbai', '2023-07-27', 310),
(103, 'baburao', 'aapte', 'Pune', '2023-07-15', 178);

insert into customer_info values (1001, 104, 'munna;', 'bhai', 'Delhi', '2023-06-21', 423); -- NOTE: In this insertin, i have gave a different uuid value.

INSERT INTO customer_info(id, first_name, last_name, city, date, sales) values(105, 'raju', 'ram', 'Chennai', '2023-04-03', 324); -- while insertin of this record my uuid will be 1002 because i explicitly provided a different uuuid value



-- UPDATE COLUMN NAME
alter table customer_info
rename column sales to expenditure;

-- LOOK AT DATA
SELECT * From customer_info;

-- CHANGE CONTRAINT OF COLUMN 'expediture' TO NOT TO ACCEPT NULL VALUE
alter table customer_info
modify column expenditure float not null;

-- CHANGE CONTRAINT OF 'id' COLUMN TO ACCEPT UNIQUE ELEMENTS
alter table customer_info
add constraint unique(id);

-- APPLY UNIQUE CONSTRAINT TO MULTIPLE COLUMNS
alter table customer_info
add constraint un_colms unique(id, first_name); -- There will be no duplicate records for which (id, first_name) previously defined

-- DROP CREATED CONSTRAINT
alter table customer_info
drop constraint un_colms;

describe customer_info;

select * from customer_info;

-- CREATE PRIMARY KEY
alter table customer_info
add constraint primary key(id); 

-- TRY CREATING 2ND PRIMARY KEY
alter table customer_info
add constraint primary key(first_name); -- HERE WE WILL GET AN ERROR: Multiple primary key defined. (BECAUSE THERE CANT BE MORE THEN ONE PRIMARY KEY IN TABLE)

-- DROP PRIMARY KEY
alter table customer_info
drop primary key;

-- COMPOSIT KEYS
alter table customer_info
add constraint composit_key primary key(id, first_name);

alter table customer_info
drop primary key;

describe customer_info;

alter table customer_info
add constraint primary key(uuid, id);

-- CANDIDATE KEYS: 

select * from customer_info;

-- CREATE NEW TABLE THAT CONTAIN FOREIGN KEY
create table personal_info(
id int not null,
food_expe int,
travel_exp int,
stay_exp int
);

insert into personal_info values(101, 2, 6, 8),
(101, 4,6,8),
(102, 3,6,2),
(102, 5,7,2),
(103, 4,9,10),
(104, 5,6,7);

insert into personal_info values(107,3,5,7); -- we cant insert records for which we dont have a foreign key in the connected table.

select * from personal_info;

-- CREATE FOREIGN KEY
alter table personal_info
add constraint foreign key(id) references customer_info(id);

describe personal_info;

-- GET RECORD FOR WHICH NAME IS 'raju ram'
select * from customer_info where first_name = 'raju' and last_name = 'ram';

-- SELECT RECORDS FOR WHICH SALES ARE GREATER THEN 300
select * from customer_info where expenditure > 300;

-- SELECT RECORDS FOR MONTH 08
SELECT * FROM customer_info WHERE month(date) = 08;

-- SELECT RECORDS WHERE CITY CONTAINS 'a' LETTER WITHIN ITS NAME
select * FROM customer_info WHERE city like '%a%';

-- USE RANK() OVER sales
SELECT *, rank() over (order by expenditure) as ranked FROM customer_info;

-- USE dense_rank() over sales
SELECT *, dense_rank() over (order by expenditure) as dense_ranked FROM customer_info;

-- USE row_number() OVER sales
SELECT *, row_number() over (order by id) from customer_info;

-- USE row_number() OVER sales
SELECT *, row_number() over (partition by id order by id) as row_num FROM customer_info;

-- SELECT RECORD THAT HAS THIRD HIGHEST EXPENDITURE
select * from (
	SELECT *, rank() over (order by expenditure) as orders FROM customer_info
) as a 
WHERE a.orders = 3;

select * from customer_info;


-- INSERT RECORDS CONTAIN DUPLICATES expenditure RECORDS
INSERT INTO customer_info(id, first_name, last_name, city, date, expenditure) 
values(106, 'raju', 'rastogi', 'Bengaluru', '2023-08-23', 178);

INSERT INTO customer_info(id, first_name, last_name, city, date, expenditure, row_id) 
values(107, 'ramesh', 'suresh', 'NAgpur', '2023-08-24', 200, 7);


-- CREATE NEW COLUMN 'row_id' and assign row_numbers to it
-- STEP 1: CREATING NEW COLUMN
ALTER TABLE customer_info 
ADD COLUMN row_id INT NOT NULL;

-- STEP 2: CREATING NEW TEMPORARY TABLE THAT CONTAIN ROW NUMBERS
CREATE TEMPORARY TABLE tmp_sale AS SELECT id, city, row_number() over (order by id) as row_num FROM customer_info;

select * from tmp_sale;

-- STEP 3: JOINING ORIGINAL TABLE TO TEMPORARY TABLE ON THE BASIS OF EmpID and city BECAUSE THERE ARE NO UNIQUE COLUMNS IN TABLE
UPDATE customer_info 
JOIN tmp_sale 
ON customer_info.id = tmp_sale.id AND customer_info.city = tmp_sale.city
SET customer_info.row_id = tmp_sale.row_num;

select * from customer_info;

-- STEP 4: DROP TEMPORARY TABLE
DROP TEMPORARY TABLE tmp_sale;

-- LOOK AT THE DATA
select * from customer_info;


-- JOIN BETWEEN personal_info AND customer_info
-- ============================================

-- INNER JOIN
select * from customer_info
join personal_info
on customer_info.id = personal_info.id;

-- LEFT JOIN
select * from customer_info
left join personal_info
on customer_info.id = personal_info.id;

-- RIGHT JOIN
select * from customer_info
right join personal_info
on customer_info.id = personal_info.id;

-- FULL JOIN
SELECT * from customer_info
full join personal_info;

-- IMPOER bank_details CSV FILE TO MYSQL WORKBENCH
select * from bank_details;

-- QUESTION: select all records for which the age is between 30 to 35
select * from bank_details where age >= 30 and age <= 35;
-- OR
select * from bank_details where age between 30 and 35;

-- ====================================================================
## STORE PROCEDURES: ITs a collection of pre-compiled SQL statement
# Use of Procedures: Encapsulation, code reusability, security, fast_execution, reduce network traffic, improve performance

-- Create new table
create table student_info(id int,
student_code varchar(20),
first_name varchar(20),
subjects varchar(20),
marks float);

-- CHANGE DATATYPE OF subject_code column
alter table student_info 
modify student_code int;

insert into student_info values(1, 1100, 'kash', 'Data Science', 95),
(2, 1020, 'raju', 'Python', 78),
(3, 1032, 'shyam', 'Machine learning', 89),
(4, 2103, 'baburao', 'AI', 99),
(5, 2143, 'virat', 'SQL', 69),
(6, 3253, 'ramesh', 'Flask', 76);

select * from student_info;

-- CREATE STORE-PROCEDURE


-- create procedure to get records where marks > 70
DELIMITER $$
USE `sql_practice_02`$$
CREATE PROCEDURE `procedure_01` ()
BEGIN
select * from student_info where marks > 70;
END$$

DELIMITER ;
-- call procedure
call procedure_01();

-- create procedure to take arguments as marks and print records greater then marks
delimiter $$
use `sql_practice_02`$$
create procedure `procedure_02` (in marks float)
begin
select * from student_info where student_info.marks >= marks;
end$$
delimiter ;

-- call procedure
call procedure_02(80);

select * from student_info;

-- we can have multiple queries in one procedure
delimiter $$
use `sql_practice_02`$$
create procedure `procedure_03` (in marks float, in sub1 varchar(20), in sub2 varchar(20), in sub3 varchar(20))
begin
select * from student_info as si where si.marks > marks;
select * from student_info as si where si.subjects in (sub1, sub2, sub3);
end$$
delimiter ;

call procedure_03(65, 'AI', 'SQL', 'Python');

-- create procedure to return value into variable
delimiter $$
use `sql_practice_02`$$
create procedure `procedure_04` (out topper float)
begin
select max(marks) into topper from student_info;
end$$
delimiter ;

-- calling procedure and storing output in a variable
call procedure_04(@output_data);

-- printing output
select @output_data;


-- create procedure containing argumetn that acts as input and output at the same time
delimiter $$
use `sql_paractice_02`$$
create procedure `procedure_05` (inout std_code int)
begin
select marks into std_code from student_info where student_code = std_code;
end $$
delimiter ;

-- set variable to pass as input and receive output
set @in_op = 1100;

-- call procedure
call procedure_05(@in_op);

select @in_op;

-- try creating procedure that takes argument form another store procedure
delimiter $$
use `sql_practice_02`$$
create procedure `procedure_06` (inout marks float)
begin
call procedure_05(marks);
select id into marks from student_info where student_info.marks = marks;
end$$
delimiter ;

set @in_op = 1100;
call procedure_06(@in_op);

select @in_op as id;
-- ====================================================================================
-- INDEXING: It's a DB optimization technique to improve speed and effeciency of the data. Index provides a quick way to look for a records.
-- Benefits: Improve query performance, Optimize sorting, effecient joins, Reduce disk I/O.

create index idx_first_name
on student_info(first_name);

select * from student_info where first_name = 'kash'; 
-- This piece of code will run much quickly as compared to normal query without indexing

-- ==========================================================================================
-- VIEW: They are use to jsut create a virtual table that can be use to display specific information and not the whole information
create view student_view  as
select id, student_code, first_name from student_info;

select * from student_view;