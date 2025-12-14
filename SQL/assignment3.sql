create database con_assgn;
use con_assgn;

create table countries
(
country_id int, 
country_name varchar(30),
region_id varchar(5)
);

insert into countries value (91, "India", "IN");
select * from countries;


create table dup_countries as
select * from countries where 1=0;

select * from dup_countries;



create table dup_copy_countries as
select * from countries;

select * from dup_copy_countries;



create table ctry1
(
country_id int not null, 
country_name varchar(30),
region_id varchar(5) null
);

insert into ctry1 value (91, "India", "IN");
insert into ctry1 value (886, "Taiwan", null);
insert into ctry1 value (null, "Japan", "JA");

select * from ctry1;



create table jobs 
(
job_id int, 
job_title varchar(20),
min_salary int, 
max_salary int check (max_salary < 25000)
);

insert into jobs value (101, "Jr. Analyst", 10000, 18000);
insert into jobs value (102, "Finance Analyst", 20000, 28000);



create table countries1
(
country_id int, 
country_name varchar(30) check (country_name = "Italy" or country_name  = "India" or country_name = "China"),
region_id varchar(5)
);

insert into countries1 value (91, "India", "IN");
insert into countries1 value (86, "China", "CH");
insert into countries1 value (66, "Thailand", "TH");
select * from countries1;



create table job_history 
(
employee_id int,
start_date date,
end_date date,
job_id int,
department_id int
);

insert into job_history value (101, str_to_date('08/02/2021', '%d/%m/%Y'), str_to_date('02/05/2024', '%d/%m/%Y'), 1704, 99);

select * from job_history;

select employee_id, date_format(start_date, '%d/%m/%Y') AS start_date, 
date_format(end_date, '%d/%m/%Y') AS end_date, job_id, department_id
from job_history;



create table countries2
(
country_id int primary key, 
country_name varchar(30),
region_id varchar(5)
);

insert into countries2 value (91, "India", "IN");
insert into countries2 value (86, "China", "CH");
insert into countries2 value (86, "Thailand", "TH");
select * from countries2;


create table job
(
job_id int, 
job_title varchar(20) default "blank", 
min_salary int default 8000,
max_salary int default null
);

insert into job value (101, "Admin Clerk", 10000, 12000);
insert into job value (102, default, 5000, 7000);
insert into job value (103, "Sr. Associate", default, 35000);
insert into job value (104, "Sales Manager", 20000, default);

select * from job;



create table countries3
(
country_id int unique, 
country_name varchar(30),
region_id varchar(5)
);

insert into countries3 value (91, "India", "IN");
insert into countries3 value (86, "China", "CH");
insert into countries3 value (86, "Thailand", "TH");
select * from countries3;



create table countries4
(
country_id int auto_increment unique, 
country_name varchar(30),
region_id varchar(5)
);

insert into countries4 value (91, "India", "IN");
insert into countries4 (country_name, region_id) value ("Pakistan", "PK");
insert into countries4 (country_name, region_id) value ("Afghanistan", "AF");
select * from countries4;



create table countries5
(
country_id int, 
country_name varchar(30),
region_id varchar(5),
unique (country_id, region_id)
);

insert into countries5 value (91, "India", "IN");
insert into countries5 value (86, "China", "IN");
insert into countries5 value (86, "Thailand", "IN");
select * from countries5;



create table jobs1
(
job_id varchar(10) primary key, 
job_title varchar(35), 
min_salary decimal(6,0),
max_salary decimal(6,0)
);

insert into jobs1 value ("IT112", "Jr. Data Analyst", 10000, 18000);
insert into jobs1 value ("FA560", "Finance Analyst", 20000, 28000);
insert into jobs1 value ("MS040", "Sales Manager", 15000, 20000);

create table job_history1
(
employee_id int primary key, 
start_date date, 
end_date date, 
job_id varchar(10),
department_id int,
foreign key (job_id) references jobs1 (job_id)
);

insert into job_history1 value (112, "2020/10/01", "2022/06/25", "MS040", 40);
insert into job_history1 value (205, "2017/04/18", "2024/06/25", "FA560", 60);
insert into job_history1 value (666, "2014/04/14", "2024/06/24", "MS040", 40);
insert into job_history1 value (745, "2021/03/15", "2025/09/20", "AM263", 63);

select * from jobs1;
select * from job_history1;




create table department1
(
department_id int,
department_name varchar(20),
manager_id int,
location_id int,
primary key (department_id, manager_id)
);

create table employee1
(
employee_id int primary key, 
first_name varchar(10), 
last_name varchar(10), 
email varchar(30), 
phone_number int,
hire_date date, 
job_id int, 
salary int, 
commission int,
department_id int, 
manager_id int,
foreign key (department_id, manager_id) references department1 (department_id, manager_id)
);

insert into department1 value (101, "Admin", 636, 8);

insert into employee1 value (205, "Alice", "Barbara", "alicb@xyz.com", 22335599, "2022/08/10", 887, 20000, 5000, 101, 636);

select * from department1;
select * from employee1;




create table department2
(
department_id int primary key,
department_name varchar(20),
manager_id int,
location_id int
);

create table jobs2
(
job_id int primary key, 
job_title varchar(35), 
min_salary decimal(6,0),
max_salary decimal(6,0)
);

create table employee2
(
employee_id int primary key, 
first_name varchar(10), 
last_name varchar(10), 
email varchar(30), 
phone_number int,
hire_date date, 
job_id int, 
salary int, 
commission int,
department_id int, 
manager_id int,
foreign key (department_id) references department2 (department_id),
foreign key (job_id) references jobs2 (job_id)
);

insert into department2 value (101, "Admin", 636, 8);
insert into jobs2 value (887, "Admin Clerk", 22000, 30000);
insert into employee2 value (205, "Alice", "Barbara", "alicb@xyz.com", 22335599, "2022/08/10", 887, 20000, 5000, 101, 636);

select * from department2;
select * from jobs2;
select * from employee2;





create table jobs3
(
job_id int primary key, 
job_title varchar(35) not null default " ", 
min_salary decimal(6,0) default 8000,
max_salary decimal(6,0) default null
);

create table employee3
(
employee_id int primary key, 
first_name varchar(10), 
last_name varchar(10), 
email varchar(30), 
phone_number int,
hire_date date, 
job_id int, 
salary int, 
commission int,
department_id int, 
manager_id int,
foreign key (job_id) references jobs3 (job_id)
);

insert into jobs3 value (887, default, 22000, default);
insert into employee3 value (205, "Alice", "Barbara", "alicb@xyz.com", 22335599, "2022/08/10", 887, 20000, 5000, 101, 636);

select * from jobs3;
select * from employee3;

delete from jobs3 where job_id=887;





create table jobs4
(
job_id int primary key, 
job_title varchar(35) not null default " ", 
min_salary decimal(6,0) default 8000,
max_salary decimal(6,0) default null
);

create table employee4
(
employee_id int primary key, 
first_name varchar(10), 
last_name varchar(10), 
email varchar(30), 
phone_number int,
hire_date date, 
job_id int, 
salary int, 
commission int,
department_id int, 
manager_id int,
foreign key (job_id) references jobs4 (job_id)
on delete cascade
);

insert into jobs4 value (887, default, 22000, default);
insert into jobs4 value (869, "Sales Manager", 25000, default);
insert into employee4 value (205, "Alice", "Barbara", "alicb@xyz.com", 22335599, "2022/08/10", 887, 20000, 5000, 101, 636);
insert into employee4 value (145, "Bob", "Harley", "bob@xyz.com", 23559896, "2012/08/12", 869, 25000, 8000, 112, 999);

select * from jobs4;
select * from employee4;

delete from jobs4 where job_id=887;





create table jobs5
(
job_id int primary key, 
job_title varchar(35) not null default " ", 
min_salary decimal(6,0) default 8000,
max_salary decimal(6,0) default null
);

create table employee5
(
employee_id int primary key, 
first_name varchar(10), 
last_name varchar(10), 
email varchar(30), 
phone_number int,
hire_date date, 
job_id int, 
salary int, 
commission int,
department_id int, 
manager_id int,
foreign key (job_id) references jobs5 (job_id)
on delete set null
);

insert into jobs5 value (887, default, 22000, default);
insert into jobs5 value (869, "Sales Manager", 25000, default);
insert into employee5 value (205, "Alice", "Barbara", "alicb@xyz.com", 22335599, "2022/08/10", 887, 20000, 5000, 101, 636);
insert into employee5 value (145, "Bob", "Harley", "bob@xyz.com", 23559896, "2012/08/12", 869, 25000, 8000, 112, 999);

select * from jobs5;
select * from employee5;

delete from jobs5 where job_id=887;






create table jobs6
(
job_id int primary key, 
job_title varchar(35) not null default " ", 
min_salary decimal(6,0) default 8000,
max_salary decimal(6,0) default null
);

create table employee6
(
employee_id int primary key, 
first_name varchar(10), 
last_name varchar(10), 
email varchar(30), 
phone_number int,
hire_date date, 
job_id int, 
salary int, 
commission int,
department_id int, 
manager_id int,
foreign key (job_id) references jobs6 (job_id)
on delete no action
);

insert into jobs6 value (887, default, 22000, default);
insert into jobs6 value (869, "Sales Manager", 25000, default);
insert into employee6 value (205, "Alice", "Barbara", "alicb@xyz.com", 22335599, "2022/08/10", 887, 20000, 5000, 101, 636);
insert into employee6 value (145, "Bob", "Harley", "bob@xyz.com", 23559896, "2012/08/12", 869, 25000, 8000, 112, 999);

select * from jobs6;
select * from employee6;

delete from jobs6 where job_id=887;