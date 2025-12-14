create table department2
(
dept_id int primary key,
dept_name varchar(30)
);

create table employee2
(
emp_id int primary key,
emp_name varchar(30),
salary int,
dept_id int,
foreign key (dept_id) references department2 (dept_id)
on update cascade
);

insert into department2 value (112, "IT");
insert into department2 value (205, "Finance");
insert into department2 value (199, "Marketing");
insert into department2 value (102, "HR");
insert into department2 value (150, "Admin");

insert into employee2 value (2002, "Wilber Pan", 90000, 199);
insert into employee2 value (2121, "Miles Wei", 70000, 112);
insert into employee2 value (2236, "Liu Xueyi", 80000, 205);
insert into employee2 value (2009, "Julia Xiang", 40000, 102);
insert into employee2 value (2090, "Liu Yuning", 85000, 150);
insert into employee2 value (2145, "Lareina Song", 55000, 150);

select * from department2;
select * from employee2;

update department2 set dept_id = 222 where dept_id = 112;