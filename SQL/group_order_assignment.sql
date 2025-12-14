select year(hire_date), count(*) as hire_year from employees group by year(hire_date);

select department_id, count(*) as no_of_employees from employees group by department_id;

select department_id, sum(salary) as total_salary from employees group by department_id order by total_salary desc limit 1; 

select count(distinct job_id) as no_of_jobs from employees;

select sum(salary) as total_salary from employees;

select min(salary) as min_salary from employees;

select job_id, max(salary) as max_salary from employees where job_id like "%PROG" group by job_id;

select department_id, avg(salary) as avg_sal, count(*) from employees where department_id = 90 group by department_id;

select max(salary), min(salary), sum(salary), avg(salary) from employees;

select job_id, count(job_id) as no_of_emp from employees group by job_id;

select max(salary)-min(salary) as diff_salary from employees;

select manager_id, min(salary) as min_sal from employees group by manager_id order by min_sal asc;

select department_id, sum(salary) as total_sal from employees group by department_id;

select job_id, avg(salary) as avg_sal from employees where job_id not like "%PROG" group by job_id;

select job_id, department_id, count(*) as no_of_emp, sum(salary) as total_sal, max(salary) as max_sal, min(salary) as min_sal, avg(salary) as avg_sal from employees where department_id = 90 group by job_id;

select job_id, max(salary) as max_sal from employees group by job_id having max_sal >= 4000;

select department_id, count(*) as no_of_emp, avg(salary) from employees group by department_id having no_of_emp > 10;