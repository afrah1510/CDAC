use hr_database;

select concat(first_name, " ", last_name) as full_name, salary from employees
where salary > (select salary from employees where last_name = "Bull");

select concat(first_name, " ", last_name) as full_name from employees
where department_id = (select department_id from departments where department_name = "IT");

select concat(first_name, " ", last_name) as full_name 
from employees where (manager_id != 0 or manager_id is not null) 
and department_id in (select department_id from departments
where location_id in (select location_id from locations 
where country_id = "US"));

select concat(first_name, " ", last_name) as full_name 
from employees where manager_id in (select manager_id from departments);

select concat(first_name, " ", last_name) as full_name, salary 
from employees where salary > (select avg(salary) from employees);

select concat(first_name, " ", last_name) as full_name, salary, job_id
from employees e where salary = (select min_salary from jobs j 
where j.job_id = e.job_id);

select concat(first_name, " ", last_name) as full_name, salary 
from employees where salary > (select avg(salary) from employees
where department_id = (select department_id from departments 
where department_name = "IT"));

select concat(first_name, " ", last_name) as full_name, salary 
from employees where salary > (select salary from employees
where last_name = "Bell");

select concat(first_name, " ", last_name) as full_name, salary 
from employees where salary in (select min(salary) from employees
group by department_id);

select concat(first_name, " ", last_name) as full_name, salary 
from employees where salary > all (select avg(salary) from employees
group by department_id);

select concat(first_name, " ", last_name) as full_name, salary 
from employees where salary > all (select salary from employees
where job_id = "SH_CLERK" order by salary asc);

select concat(first_name, " ", last_name) as full_name
from employees where employee_id not in (select distinct manager_id
from employees where manager_id is not null);

select employee_id, first_name, last_name, (select department_name
from departments d where d.department_id = e.department_id) as dept_name from employees e;

select employee_id, first_name, last_name, salary from employees a
where salary > (select avg(salary) from employees b
where a.department_id = b.department_id);

select * from employees where employee_id in (select employee_id from employees 
where mod(employee_id, 2) = 0);

select concat(first_name, " ", last_name) as full_name, salary from employees
where salary in (select salary from employees order by salary desc) 
order by salary desc limit 1 offset 4;

select concat(first_name, " ", last_name) as full_name, salary from employees
where salary in (select salary from employees order by salary asc) 
order by salary asc limit 1 offset 3;

select * from (select * from employees 
order by employee_id desc limit 10) as last_ten
order by employee_id asc;

select department_id, department_name from departments
where department_id not in (select department_id from employees);

select concat(first_name, " ", last_name) as full_name, salary from employees
where salary in (select salary from employees order by salary desc) 
order by salary desc limit 3;

select concat(first_name, " ", last_name) as full_name, salary from employees
where salary in (select salary from employees order by salary asc)
order by salary asc limit 3;

select salary from employees where salary = (select distinct salary 
from employees order by salary desc limit 1);


/* ----------------------------------------------------------------- */
select employee_id, first_name, last_name, salary from employees a
where salary > (select avg(salary) from employees b
where a.department_id = b.department_id);

select department_id, department_name from departments d
where department_id in (select department_id from employees
group by department_id
having count(*) > 10);

select concat(first_name, " ", last_name) as full_name, salary from employees 
where department_id in (select department_id 
from employees
group by department_id
having sum(salary) > 1000000);

select avg(salary) as avg_sal from employees 
where employee_id in (select employee_id from employees
where timestampdiff(year, hire_date, curdate()) < 3);

select employee_id, concat(first_name, " ", last_name) as full_name
from employees where manager_id = (select manager_id 
from employees where employee_id = 123);

select d.department_name, avg(e.salary) as avg_sal 
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name
having avg(e.salary) = (select max(avg_salary) from 
(select avg(salary) as avg_salary from employees
group by department_id) as max_sal)
order by avg_sal desc limit 1;

select employee_id, concat(first_name, " ", last_name) as full_name
from employees where salary > 
(select max(salary) from employees 
where department_id = (select department_id
from departments where department_name = "Sales"));

select employee_id, concat(first_name, " ", last_name) as full_name
from employees where manager_id in (select manager_id
from employees where salary > 100000);

select department_id, department_name
from departments where department_id in (select department_id
from employees where timestampdiff(year, hire_date, curdate()) > 5
group by department_id having count(*) >= 1);

select concat(first_name, " ", last_name) as full_name, salary from employees
where salary in (select salary from employees order by salary desc) 
order by salary desc limit 1 offset 1;