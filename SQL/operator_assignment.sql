select * from jobs where max_salary <= 20000;
select * from employees where salary > 5000;

select * from employees where department_id <> 90;

select * from employees where salary < 4000;

select * from employees where commission_pct is not null;
select * from employees where manager_id is null;

select * from employees where department_id > 50;

select * from employees where department_id = 90;

select * from employees where department_id in (100, 200, 300);

select * from jobs where max_salary >= 10000;

select * from departments where location_id = 1700;

select * from countries where region_id >= 2;

select * from employees where manager_id < 103;

select * from employees where salary >= 8000;

select * from employees where department_id <= 60;

select * from employees where salary between 4000 and 8000;

select * from jobs where min_salary > 6000;

select * from employees where salary != 5000;

select * from departments where manager_id != 0;

select * from countries where region_id != 2;

select * from employees where salary = 6000;

select * from employees where salary > 10000 or department_id = 60;

select * from employees where salary <= 3000;

select * from employees where department_id = 60 and manager_id > 102;

select * from employees where department_id = 100 and salary > 10000;

select * from departments where department_id not in (60, 70, 80);

select * from jobs where not (min_salary < 5000);

select * from employees where department_id not in (100, 60);

select * from employees where last_name like "%son";

select * from employees where first_name like "J%";

select * from employees where salary > 8000 and department_id = 90;

select * from jobs where min_salary < 5000 and max_salary > 20000;

select * from employees where salary > 6000 and department_id in (50, 60);

select * from countries where country_name like "C%" and region_id > 1;

select * from employees where first_name like "%an%" and salary > 4000;

select * from departments where location_id in (1700, 1800);

select * from employees where first_name like "A%" and last_name like "%son%";

select * from employees where salary > 5000 or department_id = 100;

select * from countries where country_name not like "A%" and region_id > 1;

select * from employees where department_id > 50 and salary > 7000;

select * from employees where salary > 10000 or salary < 3000;

select * from employees where salary > 6000 and (commission_pct is null or commission_pct < 0.2);

select * from employees where year(hire_date) between year(current_date())-10 and year(current_date());

select * from employees e where department_id = 50 or salary > (select avg(salary) from employees where department_id = e.department_id);

select * from countries where region_id > 2 and region_id != 4;

select * from employees where salary not between 5000 and 10000;

select * from employees where hire_date not between "1995-01-01" and "2005-12-31";

select * from employees where salary > 5000 and department_id != 50;

select * from employees where salary > 10000 or salary < 3000 and salary != 7000;

select * from jobs where min_salary > 5000 or max_salary < 15000;

select * from jobs where min_salary >= max_salary*0.5;

select * from employees where hire_date > "1990-01-01" and manager_id > 100;

select * from employees where salary > 10000 and (job_id = "IT_PROG" or job_id = "ST_CLERK");