use hr_database;

-- 1
select d.department_id, d.department_name, d.location_id, l.street_address, l.city, l.state_province, c.country_name
from departments d
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id;

-- 2
select e.employee_id, first_name, last_name, concat(first_name, " ", last_name) as full_name, d.department_id, d.department_name
from employees e
join departments d on d.department_id = e.department_id;

-- 3
select first_name, last_name, concat(first_name, " ", last_name) as full_name, e.job_id, d.department_id
from employees e
join departments d on d.department_id = e.department_id
join locations l on d.location_id = l.location_id
where l.city like "London";

-- 4
select e.employee_id , e.last_name , e.manager_id, m.last_name
from employees e
join employees m on e.manager_id = m.employee_id;

-- 5
select concat(e.first_name,'-',e.last_name) as full_name, e.hire_date 
from employees e
join employees j on (j.last_name = "Jones")
where e.hire_date > j.hire_date;

-- 6
select  d.department_name, count(e.employee_id) as num_of_emp 
from employees e
join departments d on e.department_id = d.department_id
group by department_name
order by department_name desc;
 
-- 7
select e.employee_id, j.job_title ,j.job_id , timestampdiff(day,jh.start_date,jh.end_date) as no_of_days 
from employees e
join jobs j on j.job_id = e.job_id
join job_history jh on jh.job_id = j.job_id
where jh.department_id = 90;

-- 8
select d.department_id , d.department_name , d.manager_id, e.first_name
from departments d
join employees e on d.manager_id = e.employee_id;

-- 9
select d.department_name, concat(e.first_name, " ", e.last_name) as full_name, l.city
from departments d
join employees e on d.manager_id = e.employee_id
join locations l on d.location_id = l.location_id;

-- 10
select j.job_title, avg(e.salary) as avg_salary 
from jobs j
join employees e on e.job_id = j.job_id
group by j.job_title;

-- 11
select j.job_title, concat(first_name, " ", last_name) as full_name, (e.salary-min_salary) as diff_salary
from jobs j
join employees e on e.job_id = j.job_id;

-- 12
select e.employee_id, concat(first_name, " ", last_name) as full_name, e.salary, concat(j.start_date, " to ", j.end_date) as job_exp
from job_history j
join employees e on j.employee_id = e.employee_id
where e.salary > 10000;

-- 13
select d.department_name, concat(first_name, " ", last_name) as full_name, e.hire_date, e.job_id, j.job_title, e.salary
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id
where j.job_title like "%Manager" and timestampdiff(year, e.hire_date, curdate()) > 15;