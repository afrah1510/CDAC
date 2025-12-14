create database MyCompany;
use MyCompany;

create table department
(
dept_id int primary key,
dept_name varchar(30)
);

create table employee
(
emp_id int primary key,
emp_name varchar(30),
salary int,
dept_id int,
foreign key (dept_id) references department (dept_id)
);

insert into department value (112, "IT");
insert into department value (205, "Finance");
insert into department value (199, "Marketing");
insert into department value (102, "HR");
insert into department value (150, "Admin");

insert into employee value (2002, "Wilber Pan", 90000, 199);
insert into employee value (2121, "Miles Wei", 70000, 112);
insert into employee value (2236, "Liu Xueyi", 80000, 205);
insert into employee value (2009, "Julia Xiang", 40000, 102);
insert into employee value (2090, "Liu Yuning", 85000, 150);
insert into employee value (2145, "Lareina Song", 55000, 150);

select * from department;
select * from employee;

select * ,(select dept_name from department where department.dept_id = employee.dept_id) as dep_name from employee;

select dept_id from department where dept_name = "IT";
select * from employee where dept_id = 112;

select dept_name, (select count(*) from employee where employee.dept_id = department.dept_id) as count_of_employee from department;

select dept_id from department where dept_name = "Finance";
insert into employee value (1216, "Meena", 35000, 205);

insert into employee value (1111, "John Doe", 45000, 10);

delete from department where dept_id = 205;