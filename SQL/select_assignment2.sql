use hr_database;
describe employees;

select * from employees;

select salary from employees;

select distinct job_id from employees;

select concat(first_name, " ", last_name) as full_name, 
concat("$ ", round(1.15*salary, 2)) as increased_salary from employees;

select concat(first_name, " ", last_name, " & ", job_id) as "Employee & Job" from employees;

select * from employees;

select employee_id, concat(first_name, " ", last_name) as employee_name, 
date_format(hire_date, "%M %d, %Y") as hire_date from employees where hire_date = "1991-02-22";

select concat(first_name, " ", last_name) as employee_name, 
length(first_name)+length(last_name) as length_of_name from employees;

select employee_id, salary, commission_pct from employees;

select distinct department_id, job_id from employees;

select * from employees where department_id <> 2001;

select * from employees where year(hire_date) < "1991";

select avg(salary) from employees where job_id like "Analyst";

select * from employees where first_name = "Blaze";

select * from employees where salary >= salary+commission_pct*salary;

select *, 1.25*salary as increase_salary from employees where 0.25*salary = 3000;

select concat(first_name, " ", last_name) as full_name 
from employees where length(first_name)+length(last_name) = 6;

select * from employees where month(hire_date) = "01";

select concat(e.first_name, " ", e.last_name, " works for ", m.first_name, " ", m.last_name) as works_for
from employees e, employees m where e.manager_id = m.employee_id;

select * from employees where job_id like "%CLERK";

select * from employees where timestampdiff(year, hire_date, curdate()) > 27;

select * from employees where salary < 3500;

select concat(first_name, " ", last_name) as full_name, job_id, salary
from employees where job_id like "Analyst";

select * from employees where year(hire_date) = 1991;

select employee_id, concat(first_name, " ", last_name) as full_name, hire_date, salary
from employees where hire_date < "1991-04-01";

select concat(first_name, " ", last_name) as full_name, job_id 
from employees where manager_id is null or manager_id = 0;

select * from employees where hire_date = "1991-05-01";

select employee_id, concat(first_name, " ", last_name) as full_name, salary, 
timestampdiff(year, hire_date, curdate()) as experience from employees
where manager_id = 68319;

select employee_id, concat(first_name, " ", last_name) as full_name, salary, salary/26 as sal_per_day, 
timestampdiff(year, hire_date, curdate()) as experience from employees
where salary/26 > 100;

select concat(first_name, " ", last_name) as full_name, date_add(hire_date, interval 8 year) as retire_date
from employees where date_add(hire_date, interval 8 year) > "1999-12-31" and date_add(hire_date, interval 8 year) < curdate();

select * from employees where mod(salary, 2) = 1;

select * from employees where length(salary) = 3;
 
select * from employees where month(hire_date) = "04";

select * from employees where day(hire_date) < "19";

select * from employees where job_id like "%SALES" and 
timestampdiff(month, hire_date, curdate()) > 10;