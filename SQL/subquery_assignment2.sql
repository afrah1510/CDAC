use hr_database;

select first_name, last_name from employees
where salary > (select salary from employees
where employee_id = 163);

select first_name, last_name, department_id, job_id from employees
where job_id = (select job_id from employees
where employee_id = 169);

select first_name, last_name, department_id from employees
where salary in (select min(salary) from employees
group by department_id);

select employee_id, first_name, last_name from employees
where salary > (select avg(salary) from employees);

select employee_id, first_name, last_name, salary from employees
where manager_id = (select employee_id from employees
where first_name = "Payam");

select e.department_id, e.first_name, e.job_id, d.department_name 
from employees e
join departments d on e.department_id = d.department_id
where e.department_id = (select department_id from departments
where department_name = "Finance");

select * from employees
where salary = 3000 and
manager_id = (select employee_id from employees
where employee_id = 121);

select * from employees where employee_id in
(select employee_id from employees where employee_id in (134, 159, 183));

select * from employees where salary in 
(select salary from employees where salary between 1000 and 3000);

select * from employees where salary between
(select min(salary) from employees) and 2500;

select * from employees where department_id 
not in (select department_id from departments 
where manager_id between 100 and 200);

select concat(first_name, " ", last_name) as full_name, salary from employees 
where salary in (select salary from employees order by salary desc)  
order by salary desc limit 1 offset 1; 

select first_name, last_name, hire_date from employees
where department_id = (select department_id from employees
where first_name = "Clara") and first_name not like "Clara";

select employee_id, first_name, last_name from employees
where department_id in (select department_id from employees
where first_name like "%T%");

select employee_id, first_name, salary from employees
where salary > (select avg(salary) from employees) and 
department_id in (select department_id from employees
where first_name like "%J%");

select employee_id, first_name, last_name, job_id from employees
where department_id in (select department_id from departments
where location_id = (select location_id from locations
where city = "Toronto"));

select employee_id, first_name, last_name, job_id from employees
where salary < any (select salary from employees
where job_id = "MK_MAN");

select employee_id, first_name, last_name, job_id from employees
where salary < any (select salary from employees
where job_id = "MK_MAN") and job_id <> "MK_MAN";

select employee_id, first_name, last_name, job_id from employees
where salary > any (select salary from employees
where job_id = "PU_MAN") and job_id <> "PU_MAN";

select employee_id, first_name, last_name, job_id from employees
where salary > all (select avg(salary) from employees
group by department_id);

select first_name, last_name, department_id from employees
where salary in (select salary from employees
where salary > 3700);

select department_id, sum(salary) as total_salary from employees
where department_id in (select department_id from employees
group by department_id
having count(*) > 1)
group by department_id;

select employee_id, full_name, designation from
(select employee_id, concat(first_name, " ", last_name) as full_name,
case
when job_id = "ST_MAN" then "Salesman"
when job_id = "IT_PROG" then "Developer"
else job_id
end as designation
from employees) as sub;

select employee_id, full_name, salary,
case
when salary > (select avg(salary) from employees) then "High"
when salary < (select avg(salary) from employees) then "Low"
end as sal_status
from
(select employee_id, concat(first_name, " ", last_name) as full_name, 
salary from employees) as sub;

select employee_id, full_name, salary as SalaryDrawn, 
round((salary - (select avg(salary) from employees)), 2) as AvgCompare, 
case
when salary > (select avg(salary) from employees) then "High"
when salary < (select avg(salary) from employees) then "Low"
end as sal_status
from
(select employee_id, concat(first_name, " ", last_name) as full_name, 
salary from employees) as sub;

select department_id, department_name from departments
where department_id in (select department_id from employees
group by department_id
having count(*) > 1);

select last_name from employees
where salary > (select avg(salary) from employees) and 
department_id in (select department_id from departments
where department_name = "IT");

select first_name, last_name, salary from employees
where salary > (select salary from employees
where last_name = "Ozer")
order by last_name asc;

select first_name, last_name  
from employees 
where manager_id in (select manager_id from departments 
where location_id in (select location_id from locations  
where country_id = "US")); 

select first_name, last_name from employees e
where salary > (select 0.5*sum(salary) from employees
where e.department_id = department_id); 

select * from employees 
where manager_id in (select manager_id from departments);

select * from employees 
where employee_id in (select manager_id from departments);

select employee_id, first_name, last_name, salary, department_name, city
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where salary > (select max(salary) from employees
where hire_date between "2002-01-01" and "2003-12-31");

select department_id, department_name from departments
where location_id in (select location_id from locations
where city = "London");

select first_name, last_name, salary, department_id from employees
where salary > (select avg(salary) from employees)
order by salary desc;

select first_name, last_name, department_id from employees
where salary > all (select max(salary) from employees
where department_id = 40);

select department_id, department_name from departments
where location_id = (select location_id from departments
where department_id = 30);

select first_name, last_name, salary, department_id from employees
where department_id = (select department_id from employees
where employee_id = 201);

select first_name, last_name, salary, department_id from employees
where salary in (select salary from employees
where department_id = 40);

select first_name, last_name, department_id from employees
where department_id = (select department_id from departments
where department_name = "Marketing");

select first_name, last_name, salary, department_id from employees
where salary > (select min(salary) from employees
where department_id = 40);

select first_name, last_name, hire_date from employees
where hire_date > (select hire_date from employees
where employee_id = 165);

select first_name, last_name, salary, department_id from employees
where salary < (select min(salary) from employees
where department_id = 70);

select first_name, last_name, salary, department_id from employees
where salary < (select avg(salary) from employees)
and department_id = (select department_id from employees
where first_name = "Laura");

select first_name, last_name, salary, department_id from employees
where department_id = (select department_id from departments
where location_id in (select location_id from locations
where city = "London"));

select city from locations
where location_id = (select location_id from departments 
where department_id = (select department_id from employees
where employee_id = 134));

select * from departments
where department_id in (select department_id from employees
where employee_id in (select employee_id from job_history
group by employee_id
having count(employee_id) > 1)
group by department_id
having max(salary) >= 7000);

select * from departments
where department_id in (select department_id from employees
group by department_id
having min(salary) >= 8000);

select concat(first_name, " ", last_name) as manager_name, department_id from employees
where employee_id in (select manager_id from employees
group by manager_id
having count(employee_id) >= 4);

select * from jobs
where job_id in (select job_id from employees
where employee_id in (select employee_id from job_history
where job_id = "SA_REP"));

select * from employees 
where salary in (select salary from employees order by salary asc)  
order by salary asc limit 1 offset 1;

select * from departments
where manager_id = (select employee_id from employees
where first_name = "Susan");

select department_id, concat(first_name, " ", last_name) as full_name, salary from employees a
where salary = (select max(salary) from employees b
where a.department_id = b.department_id);

select * from employees e
where employee_id not in (select employee_id from job_history);