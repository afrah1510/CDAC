select employee_id as ID, first_name as first, last_name as last from employees;

select job_id as JobCode, job_title as Title, min_salary as MinimumSalary from jobs;

select e.first_name, e.last_name from employees e;

select employee_id, concat(first_name, " ", last_name) as FullName from employees order by FullName desc;

select employee_id as ID, first_name as Name, Salary as Income from employees where salary > 5000;

select e.employee_id, e.first_name, d.department_name from employees e
join departments d on e.department_id = d.department_id;

select c.country_name, r.region_name from countries c
join regions r on c.region_id = r.region_id
where r.region_id > 2;

select e.employee_id, e.first_name, d.department_name from employees e
join departments d on e.department_id = d.department_id
where d.department_name = "IT";

select d.department_name, avg(e.salary) as AverageSalary from departments d
join employees e on d.department_id = e.department_id
group by d.department_name;

select r.region_name, count(c.country_name) as CountryCount from regions r
join countries c on r.region_id = c.region_id
group by r.region_name;