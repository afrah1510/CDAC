create database insert_assgn;
use insert_assgn;

create table countries
(
country_id varchar(2) null,
country_name varchar(40) null,
region_id decimal(10,0) null
);

select * from countries;

insert into countries value ("TH", "Thailand", 1);

insert into countries (country_id, country_name) value ("HK", "Hong Kong");

create table country_new as select * from countries;
describe country_new;
select * from country_new;

insert into countries value ("BH", "Bahrain", null);

insert into countries values ("MY", "Malaysia", 2), ("VN", "Vietnam", 3), ("RS", "Serbia", 4);

insert into country_new value ("C1", "India", 1001);
insert into country_new value ("C2", "USA", 1002);
insert into country_new value ("C3", "UK", 1003);

insert into countries select * from country_new;

create table jobs (
job_id varchar(10) primary key,
job_title varchar(50),
min_salary decimal(10, 2),
max_salary decimal(10, 2)
);

insert into jobs value (101, "Clerk", 8000, 12000);
insert into jobs value (101, "Assistant", 10000, 14000);

insert into jobs value (102, "Jr. Developer", 20000, 25000);
insert into jobs value (102, "Admin Executive", 50000, 80000);

alter table countries add constraint uc_id unique (country_id, region_id);
insert into countries value ("IN", "India", 91);
insert into countries value ("IN", "Indonesia", 91);

alter table countries modify column country_id int auto_increment unique;
insert into countries value (1, "India", 91);
insert into countries (country_name, region_id) value ("Indonesia", 62);

alter table countries modify column country_name varchar(40) default "N/A";
insert into countries (region_id) value (66);

select * from jobs;

create table job_history (
employee_id int primary key,
job_id varchar(10),
department_id int,
start_date date,
end_date date,
foreign key (job_id) references jobs (job_id)
);

insert into job_history value (1, 101, 60, "2001-10-07", "2002-10-15");
insert into job_history value (2, 102, 90, "2004-06-16", "2007-03-01");
insert into job_history value (3, 105, 110, "2000-01-11", "2006-12-06");

select * from job_history;





create table jobs (
job_id varchar(10) primary key,
job_title varchar(50),
min_salary decimal(10, 2),
max_salary decimal(10, 2)
);

select * from jobs;

create table departments (
department_id int,
department_name varchar(50),
manager_id int,
primary key (department_id, manager_id)
);

insert into departments values (10, 'IT', 1001), (20, 'Sales', 1002), (30, 'HR', 1003);
select * from departments;

create table employees (
employee_id int primary key,
first_name varchar(50),
last_name varchar(50),
age varchar(10),  
salary decimal(10, 2),
department_id int, 
manager_id int,
job_id varchar(10),
unique (department_id, manager_id),
constraint fk_dept_manager foreign key (department_id, manager_id)
references departments (department_id, manager_id), 
constraint fk_dept foreign key (department_id)
references departments (department_id),
constraint fk_job foreign key (job_id)
references jobs (job_id)
);

insert into employees value (1, 'Alice', 'Brown', '28', 11000, 10, 1001, 101);

insert into employees value(2, 'Bob', 'Ernst', '32', 22000, 20, 1002, '102');

select * from employees;
