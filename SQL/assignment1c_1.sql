create table department1
(
dept_id int primary key,
dept_name varchar(30)
);

create table employee1
(
emp_id int primary key,
emp_name varchar(30),
salary int,
dept_id int,
foreign key (dept_id) references department1 (dept_id)
on delete cascade
);

insert into department1 value (112, "IT");
insert into department1 value (205, "Finance");
insert into department1 value (199, "Marketing");
insert into department1 value (102, "HR");
insert into department1 value (150, "Admin");

insert into employee1 value (2002, "Wilber Pan", 90000, 199);
insert into employee1 value (2121, "Miles Wei", 70000, 112);
insert into employee1 value (2236, "Liu Xueyi", 80000, 205);
insert into employee1 value (2009, "Julia Xiang", 40000, 102);
insert into employee1 value (2090, "Liu Yuning", 85000, 150);
insert into employee1 value (2145, "Lareina Song", 55000, 150);

select * from department1;
select * from employee1;

delete from department1 where dept_id = 205;