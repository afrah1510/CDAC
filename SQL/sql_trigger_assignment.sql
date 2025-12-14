use update_assgn;

-- 1.	How can MySQL triggers be used to automatically update employee records when a department is changed?
-- 		after update trigger
-- backup table
create table employee_role_history (
    emp_id int,
    old_job_id varchar(10),
    old_department_id int,
    changed_at datetime default current_timestamp
);

delimiter $$
create trigger trg_backup_role_before_update
before update on employees
for each row
begin
if old.job_id <> new.job_id or old.department_id <> new.department_id then
insert into employee_role_history (emp_id, old_job_id, old_department_id)
values (old.employee_id, old.job_id, old.department_id);
end if;
end $$
delimiter ;

select employee_id, job_id, department_id from employees where employee_id = 101;
update employees set job_id = 'IT_PROG', department_id = 60 where employee_id = 101;
select * from employee_role_history where emp_id = 101;
select * from employees where employee_id = 101;


-- 2.	What MySQL trigger can be used to prevent an employee from being deleted if they are currently assigned to a department?
-- 		before delete trigger
delimiter $$
create trigger trg_prevent_employee_delete
before delete on employees
for each row
begin
if old.department_id is not null then
signal sqlstate '45000'
set message_text = 'cannot delete employee assigned to a department';
end if;
end $$
delimiter ;

delete from employees where employee_id = 110; 


-- 3.	How can a MySQL trigger be used to send an email notification to HR when an employee is hired or terminated?
-- 		after insert/delete trigger
create table hr_log (
    log_id int auto_increment primary key,
    emp_id int,
    action_type varchar(10),
    log_time datetime default current_timestamp
);

delimiter $$
create trigger trg_log_hire
after insert on employees
for each row
begin
insert into hr_log (emp_id, action_type) values (new.employee_id, 'hire');
end $$

create trigger trg_log_termination
after delete on employees
for each row
begin
insert into hr_log (emp_id, action_type) values (old.employee_id, 'exit');
end $$
delimiter ;

insert into employees (employee_id, first_name, last_name, salary, department_id)
values (1010, 'test', 'hire', 5000, 60);
delete from employees where employee_id = 1010;
select * from hr_log where emp_id = 1010;


-- 4.	What MySQL trigger can be used to automatically assign a new employee to a department based on their job title?
-- 		before insert trigger
delimiter $$
create trigger trg_auto_assign_dept
before insert on employees
for each row
begin
if new.job_id = 'SA_REP' then
set new.department_id = 80;
elseif new.job_id = 'IT_PROG' then
set new.department_id = 60;
end if;
end $$
delimiter ;

insert into employees (employee_id, first_name, job_id, salary)
values (1006, 'insert_test', 'SA_REP', 5000);
select employee_id, job_id, department_id from employees where employee_id = 1006;


-- 5.	How can a MySQL trigger be used to calculate and update the total salary budget for a department 
-- 		whenever a new employee is hired or their salary is changed?
-- 		after update/insert trigger
create table dept_budget (
    department_id int primary key,
    total_salary decimal(10,2)
);

delimiter $$
create trigger trg_update_budget_on_hire
after insert on employees
for each row
begin
insert into dept_budget (department_id, total_salary)
values (new.department_id, new.salary)
on duplicate key update total_salary = total_salary + new.salary;
end $$

create trigger trg_update_budget_on_salary_change
after update on employees
for each row
begin
if old.salary <> new.salary then
update dept_budget
set total_salary = total_salary - old.salary + new.salary
where department_id = new.department_id;
end if;
end $$
delimiter ;

insert into employees (employee_id, first_name, salary, department_id)
values (1005, 'budget_test', 6000, 90);
select * from dept_budget;
update employees set salary = 6500 where employee_id = 1005;
select * from dept_budget where department_id = 90;


-- 6.	What MySQL trigger can be used to enforce a maximum number of employees that can be assigned to a department?
-- 		before insert trigger
delimiter $$
create trigger trg_limit_employees_per_dept
before insert on employees
for each row
begin
declare emp_count int;
select count(*) into emp_count
from employees
where department_id = new.department_id;
if emp_count >= 7 then
signal sqlstate '45000'
set message_text = 'department has reached maximum employee limit';
end if;
end $$
delimiter ;

insert into employees (employee_id, first_name, department_id)
values (909, 'limit_test', 90);
insert into employees (employee_id, first_name, department_id)
values (910, 'limit_test1', 90);
insert into employees (employee_id, first_name, department_id)
values (911, 'limit_test2', 90);
insert into employees (employee_id, first_name, department_id)
values (912, 'limit_test3', 90);
-- trigger
insert into employees (employee_id, first_name, department_id)
values (913, 'limit_test4', 90);


select * from employees;
-- 7.	How can a MySQL trigger be used to update the department manager whenever an employee 
-- 		under their supervision is promoted or leaves the company?
-- 		before update/delete trigger
-- backup table
create table manager_change_log (
    emp_id int,
    old_job_title varchar(100),
    old_manager_id int,
    change_type varchar(10),
    changed_at datetime default current_timestamp
);

delimiter $$
create trigger trg_backup_on_promotion
before update on employees
for each row
begin
if old.job_id <> new.job_id then
insert into manager_change_log (emp_id, old_job_title, old_manager_id, change_type)
values (old.employee_id, old.job_id, old.manager_id, 'promotion');
end if;
end $$

create trigger trg_backup_on_exit
before delete on employees
for each row
begin
insert into manager_change_log (emp_id, old_job_title, old_manager_id, change_type)
values (old.employee_id, old.job_id, old.manager_id, 'exit');
end $$

delimiter ;

update employees set job_id = 'SR_MAN' where employee_id = 165;
select * from manager_change_log where emp_id = 165;
delete from employees where employee_id = 160;
select * from manager_change_log where emp_id = 160;


-- 8.	What MySQL trigger can be used to automatically archive the records of an employee 
-- 		who has been terminated or has left the company?
-- 		before delete trigger
create table archived_employees as select * from employees where 1=0;

delimiter $$
create trigger trg_archive_before_delete
before delete on employees
for each row
begin
insert into archived_employees
select * from employees where employee_id = old.employee_id;
end $$
delimiter ;

delete from employees where employee_id = 105;
select * from archived_employees where employee_id = 105;