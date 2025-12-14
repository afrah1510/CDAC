select first_name as "First Name", last_name as "Last Name" from employees;

select distinct department_id from employees;

select first_name from employees order by first_name desc;

select concat(first_name, " ", last_name) as full_name, salary, 0.15*salary as PF from employees;

select employee_id, concat(first_name, " ", last_name) as full_name, salary from employees order by salary asc;

select sum(salary) as total_salary_to_employees from employees;

select max(salary) as max_sal, min(salary) as min_sal from employees;

select avg(salary) as avg_sal, count(employee_id) as total_employees from employees;

select count(employee_id) as total_employees from employees;

select count(distinct job_id) as no_of_jobs from employees;

select upper(first_name) as FIRST_NAME from employees;

select first_name, left(first_name, 3) as first_three_char from employees;

select 172*214+625;

select concat(first_name, " ", last_name) as full_name from employees;

select trim(first_name) as trimmed_first_name from employees;

select concat(first_name, " ", last_name) as full_name, length(first_name)+length(last_name) as length_of_name from employees;

select * from employees where first_name regexp '[0-9]';

select * from employees limit 10;

select round(salary/12, 2) as monthly_salary from employees;
