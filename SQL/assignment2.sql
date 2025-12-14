create database assignment2;
use assignment2;

create table students
(
id int,
name varchar(20) not null,
age int default 18
);

insert into students value (1, NULL, 20);

insert into students (id, name) value (2, "Ravi");

select * from students;

insert into students (id) VALUES (3);

alter table students alter column age set default 21;
insert into students value (15, "Aliza", default);

alter table students modify column name varchar(20) null;

describe students;

create table department
(
dept_id int primary key,
dept_name varchar(20)
);

insert into department value (1, "IT");
insert into department value (1, "HR");

create table registration
(
stud_id int,
govt_id int,
stud_name varchar(20),
degree varchar(20),
primary key (stud_id, govt_id)
);

describe registration;

create table enrollment
(
student_id int,
course_id int,
stud_name varchar(20),
course varchar(20),
primary key (student_id, course_id)
);

describe enrollment;

insert into enrollment value (2038, 101, "Aliza", "DBMS");
insert into enrollment value (2038, 101, "Aliza", "DBMS");

create table users
(
user_id int auto_increment primary key,
email varchar(30) unique
);

insert into users value (2038, "abc@mail.com");
insert into users (email) value ("abc@mail.com");

insert into users (email) values (null);
insert into users (email) values (null);

select * from users;

create table products
(
p_id int,
p_name varchar(20),
sku varchar(20),
region varchar(20),
unique (sku, region)
);

insert into products value (1498, "Laptop", "A1", "US");
insert into products value (1498, "Laptop", "A1", "US");

create table dept
(
dept_id int primary key,
dept_name varchar(20)
);

create table emp 
(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
constraint fk_emp_id foreign key (dept_id) 
references dept (dept_id)
);

insert into dept value (1, "Admin");
insert into dept value (2, "Finance");
insert into dept value (99, "Marketing");

insert into emp value (1, "Asha", 99);
insert into emp value (2, "Bela", 1);
insert into emp value (3, "Beena", 2);

select * from dept;
select * from emp;

delete from dept where dept_id = 1;



create table dept1
(
dept_id int primary key,
dept_name varchar(20)
);

create table emp1 
(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
constraint fk_emp1_id foreign key (dept_id) 
references dept1 (dept_id)
on delete cascade
);

insert into dept1 value (1, "Admin");
insert into dept1 value (2, "Finance");
insert into dept1 value (99, "Marketing");

insert into emp1 value (1, "Asha", 99);
insert into emp1 value (2, "Bela", 1);
insert into emp1 value (3, "Beena", 2);

select * from dept1;
select * from emp1;

delete from dept1 where dept_id = 1;



create table dept2
(
dept_id int primary key,
dept_name varchar(20)
);

create table emp2 
(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
constraint fk_emp2_id foreign key (dept_id) 
references dept2 (dept_id)
on delete cascade
);

insert into dept2 value (1, "Admin");
insert into dept2 value (2, "Finance");
insert into dept2 value (99, "Marketing");

insert into emp2 value (1, "Asha", 99);
insert into emp2 value (2, "Bela", 1);
insert into emp2 value (3, "Beena", 2);

select * from dept2;
select * from emp2;

delete from dept2 where dept_id = 1;



/*
create table emp 
(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
constraint fk_emp_id foreign key (dept_id) 
references dept (dept_id)
);
*/
alter table emp drop foreign key fk_emp_id;

select table_name,
constraint_name
from information_schema.Table_constraints
where table_schema = database() and
table_name = "emp";


alter table emp
add column manager_id int,
add constraint fk_manager foreign key (manager_id)
references emp (emp_id);

select table_name,
constraint_name
from information_schema.Table_constraints
where table_schema = database() and
table_name = "emp";



create table accounts 
(
acc_id int primary key,
balance int check(balance > 0)
);

insert into accounts value (250226, 89000);
insert into accounts value (1, -100);

select * from accounts;

alter table accounts modify column balance int check(balance > 100 and balance < 1000000);
insert into accounts value (2, 50);


create table invoices 
(
invoice_id int auto_increment primary key,
payment_type varchar(20)
);

insert into invoices value (28549, "Credit Card");
insert into invoices (payment_type) value ("Debit Card");
insert into invoices (payment_type) value ("UPI");

select * from invoices;

delete from invoices where payment_type = "UPI";
select * from invoices;
insert into invoices (payment_type) value ("Netbanking");
select * from invoices;


/*
create table users
(
user_id int auto_increment primary key,
email varchar(30) unique
);

insert into users value (2038, "abc@mail.com");
insert into users (email) value ("abc@mail.com");

insert into users (email) values (null);
insert into users (email) values (null);

select * from users;
*/
alter table users add column phone_no int unique;
describe users;
insert into users (email, phone_no) value ("goodday@mail.com", 123456);
select * from users;

alter table users drop column phone_no;
describe users;




create table library
(
book_id int,
book_title varchar(20),
isbn varchar(20),
branch_id int,
primary key (book_id, branch_id),
unique (isbn, branch_id)
);

insert into library value (1, "Othello", "A123", 101);
insert into library value (1, "King Lear", "A123", 101);
insert into library value (1, "Macbeth", "A123", 102);



create table hospital 
(
pat_id int primary key,
pat_name varchar(20),
appt_time datetime,
ward_no varchar(20),
dr_name varchar(20),
unique (appt_time, ward_no, dr_name)
);

insert into hospital value (101, "Alice", "2024-08-10 11:10:00", "A2", "Dr. Jack");
insert into hospital value (102, "Bob", "2024-08-10 11:10:00", "B3", "Dr. Jack");
insert into hospital value (103, "Charles", "2024-08-10 11:10:00", "A2", "Dr. Jack");

select * from hospital;



create table patient 
(
pat_id int primary key,
pat_name varchar(20),
unique (pat_id)
);

insert into patient value (101, "Alice");
insert into patient value (102, "Bob");
insert into patient value (103, "Charles");
insert into patient value (103, "Charles");
insert into patient value (null, "Drake");

select * from patient;



create table exam_result
(
student_id int,
exam_id int,
course_name varchar(20) unique,
marks int check (marks < 100 and marks > 0),
primary key (student_id, exam_id)
);

insert into exam_result value (101, 24, "English", 85);
insert into exam_result value (102, 24, "Maths", 90);
insert into exam_result value (101, 25, "Hindi", -80);
insert into exam_result value (103, 26, "Maths", 195);

select * from exam_result;



create table customer
(
c_id int primary key,
cust_name varchar(20)
);

create table orders
(
o_id int primary key,
o_type varchar(20),
c_id int,
foreign key (c_id) references customer (c_id)
on update cascade
);

select * from customer;
select * from orders;

insert into customer value (1, "Tan Jianci");
insert into customer value (2, "Zhou Shen");

insert into orders value (101, "Work", 1);
insert into orders value (102, "Home", 1);
insert into orders value (103, "Friend", 2);
insert into orders value (104, "Home", 2);

update customer set cust_name="JC-T" where cust_name="Tan Jianci"; 
update customer set c_id=22 where cust_name="JC-T"; 




create table cust1
(
c_id int primary key,
cust_name varchar(20)
);

create table ord1
(
o_id int primary key,
o_type varchar(20),
c_id int default 99,
foreign key (c_id) references cust1 (c_id)
on delete set default
);

insert into cust1 value (1, "Tan Jianci");
insert into cust1 value (2, "Zhou Shen");

insert into ord1 value (101, "Work", 1);
insert into ord1 value (102, "Home", 1);
insert into ord1 value (103, "Friend", 2);
insert into ord1 value (104, "Home", 2);

delete from cust1 where cust_name="Zhou Shen";



create table categories (
id int primary key,
name varchar(20),
parent_id int,
foreign key (parent_id) references categories(id)
);

insert into categories value (1, "Book", null);

select * from categories;

insert into categories value (2, "Fiction", 1);
insert into categories value (3, "Tragedy", 6);
insert into categories value (4, "Healing", 4);



/*
create table dept
(
dept_id int primary key,
dept_name varchar(20)
);

create table emp 
(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
constraint fk_emp_id foreign key (dept_id) 
references dept (dept_id)
);

insert into dept value (1, "Admin");
insert into dept value (2, "Finance");
insert into dept value (99, "Marketing");

insert into emp value (1, "Asha", 99);
insert into emp value (2, "Bela", 1);
insert into emp value (3, "Beena", 2);

select * from dept;
select * from emp;

delete from dept where dept_id = 1;
*/



create table cust2
(
c_id int primary key,
cust_name varchar(20)
);

create table ord2
(
o_id int primary key,
o_type varchar(20),
c_id int,
foreign key (c_id) references cust2 (c_id)
on delete cascade
);

insert into cust2 value (1, "Tan Jianci");
insert into cust2 value (2, "Zhou Shen");

insert into ord2 value (101, "Work", 1);
insert into ord2 value (102, "Home", 1);
insert into ord2 value (103, "Friend", 2);
insert into ord2 value (104, "Home", 2);

select * from cust2;
select * from ord2;

insert into ord2 value (105, "Business", 9);

set foreign_key_checks = 0;
insert into ord2 values (106, "Business", 9);

set foreign_key_checks = 1;
insert into ord2 values (107, "School", 999);



show index from ord2 where column_name = "c_id";



create table employees
(
e_id int primary key,
gender char(2) check (gender = "M" or gender = "F"),
salary int check (salary > 20000),
d_id int
);

insert into employees value (1, "F", 15000, 99);
insert into employees value (2, "M", 30000, 1);
insert into employees value (3, "X", 50000, 2);



create table dept3
(
d_id int primary key,
d_name varchar(20)
);

create table emp3
(
e_id int primary key,
gender char(2),
salary int,
d_id int,
foreign key (d_id) references dept3 (d_id)
);

insert into dept3 value (1, "Admin");
insert into dept3 value (2, "Finance");
insert into dept3 value (99, "Marketing");

insert into emp3 value (1, "F", 15000, 99);
insert into emp3 value (2, "M", 30000, 1);
insert into emp3 value (3, "X", 50000, 2);

select * from dept3;
select * from emp3;



create table lib1
(
book_id int primary key,
book_title varchar(20),
isbn varchar(20) unique
);

describe lib1;

alter table lib1 drop primary key;



create table dept4
(
dept_id int primary key,
dept_name varchar(20)
);

create table emp4 
(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
constraint fk_emp_dept foreign key (dept_id) 
references dept4 (dept_id)
);

describe emp4;

select table_name,
constraint_name
from information_schema.Table_constraints
where table_schema = database() and
table_name in ("dept4", "emp4");

alter table emp4 drop foreign key fk_emp_dept;
alter table emp4 add constraint fk_employee_department foreign key (dept_id) references dept4 (dept_id);