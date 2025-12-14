-- 1
with hello as
(
select employee_id, concat(coalesce(first_name, ""), " ", last_name) as full_name, 
job_id, department_id, salary
from employees
)
select * from hello;

-- 2
with emp_dept as
(
select distinct department_id, count(employee_id) as no_of_emp 
from employees
where department_id is not null
group by department_id
)
select d.department_id, d.department_name, coalesce(no_of_emp, 0) as headcount
from departments d
left join emp_dept e on d.department_id = e.department_id;

-- 3
with job_sal as
(
select distinct job_id, count(*) as emp_count, round(avg(salary), 2) as avg_salary from employees
where job_id is not null
group by job_id
)
select j.job_id, job_title, emp_count, avg_salary from jobs j
left join job_sal js on j.job_id = js.job_id;

-- 4
with emp_man as
(
select employee_id, concat(first_name, " ", last_name) as employee_name, manager_id 
from employees
where manager_id is not null
)
select e.employee_id, employee_name, e.manager_id, concat(first_name, " ", last_name) as manager_name
from emp_man e
left join employees m
on m.employee_id = e.manager_id;

-- 5
with emp_dept as
(
select distinct department_id from departments
where department_id is not null
)
select employee_id, concat(first_name, " ", last_name) as employee_name,
job_id, e.department_id from employees e
left join emp_dept d on e.department_id = d.department_id
where d.department_id is null;

-- 6
with emp_dept as
(
select distinct department_id from employees
where department_id is not null
)
select d.department_id, d.department_name from departments d
left join emp_dept e on d.department_id = e.department_id
where e.department_id is null;

-- 7
with r_map as
(
select d.department_id, d.department_name, l.city, c.country_name,
trim(replace(r.region_name, '\r', '')) as region_name
from departments d
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
join regions r on c.region_id = r.region_id
)
select employee_id, concat(first_name, " ", last_name) as full_name, r.department_name,
r.city, r.country_name, r.region_name 
from employees e
left join r_map r on e.department_id = r.department_id;

-- 8
with job_pay as
(
select employee_id, concat(first_name, " ", last_name) as full_name, 
job_title, salary, j.min_salary, j.max_salary 
from employees e
join jobs j on e.job_id = j.job_id
)
select * from job_pay where salary < min_salary or salary > max_salary;

-- 9
with top_earn as
(
select employee_id, concat(first_name, " ", last_name) as full_name, salary
from employees
order by salary desc
limit 5
)
select * from top_earn;

-- 10
with emp_job as
(
select distinct department_id, j.job_id, j.job_title, count(employee_id) as no_of_emp 
from employees e
join jobs j on e.job_id = j.job_id
where department_id is not null
group by department_id, j.job_id
)
select d.department_name, e.job_title, coalesce(no_of_emp, 0) as emp_count
from emp_job e
right join departments d on e.department_id = d.department_id;

-- 11
with emp_dept as
(
select employee_id, department_id, salary
from employees
), 
r_map as
(
select d.department_id, r.region_id,
trim(replace(r.region_name, '\r', '')) as region_name
from departments d
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
right join regions r on c.region_id = r.region_id
),
dept_co as
(
select department_id, count(*) as no_of_emp from emp_dept
group by department_id
)
select r.region_id, r.region_name, sum(coalesce(d.no_of_emp, "Unknown")) as headcount 
from r_map r
left join dept_co d on r.department_id = d.department_id
group by r.region_id, r.region_name;

-- 12
with emp_com as
(
select department_id, commission_pct as has_commission, count(*) as headcount
from employees
where commission_pct > 0
group by department_id, commission_pct
order by department_id, commission_pct
)
select * from emp_com;

-- 13
with emp_job as
(
select e.employee_id, concat(first_name, " ", last_name) as full_name,
count(*) as history_row_count from job_history as j
join employees as e
on j.job_id = e.job_id
group by employee_id
)
select * from emp_job;

-- or

with emp_job as
(
select e.employee_id, concat(first_name, " ", last_name) as full_name,
count(*) over (partition by employee_id) as history_row_count from job_history as j
join employees as e
on j.job_id = e.job_id
)
select * from emp_job;


-- 14
with hist_row as
(
select employee_id, job_id AS last_hist_job_id, 
department_id AS last_hist_department_id, end_date AS last_hist_end_date
from job_history
where (start_date is not null and start_date != "0001-01-01"
and start_date < end_date) and 
(end_date is not null and end_date != "0001-01-01")
and end_date = (select max(end_date) from job_history j2
where j2.employee_id = job_history.employee_id
and j2.start_date is not null and j2.start_date != '0001-01-01' and j2.start_date < j2.end_date
and j2.end_date is not null and j2.end_date != '0001-01-01')
order by end_date desc, start_date desc
)
select * from hist_row;

-- or

with latest_history as (
select employee_id, job_id as last_hist_job_id,
department_id as last_hist_department_id,
end_date as last_hist_end_date,
row_number() over (partition by employee_id order by end_date desc, start_date desc) as rn
from job_history
where end_date is not null and end_date != '0001-01-01'
)
select * from latest_history where rn = 1;

-- 15
with ctr_loc as
(
select l.country_id, c.country_name, count(location_id) as location_count
from locations l
join countries c on l.country_id = c.country_id
group by country_id
)
select * from ctr_loc;




-- Regional Workforce
with work_map as
(
select region_name, department_name, count(*) as headcount, 
avg(salary) as avg_salary, min(salary) as min_salary, 
max(salary) as max_salary
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
join regions r on c.region_id = r.region_id
group by region_name, department_name
), 
dept_region_share as
(
select *, 
headcount*100/sum(headcount) over(partition by region_name) as dept_share_pct
from work_map
)
select * from dept_region_share;


-- Pay Range
with pay_range as
(
select employee_id, concat(first_name, " ", last_name) as full_name, 
job_title, salary, 
case
when e.salary < j.min_salary then "Underpaid"
when e.salary > j.max_salary then "Overpaid"
end as sal_cat,
case
when e.salary < j.min_salary then j.min_salary-e.salary
when e.salary > j.max_salary then e.salary-j.max_salary
end as dev_amt
from employees e
join jobs j on e.job_id = j.job_id
where salary < min_salary or salary > max_salary
), 
rank_violators as
(
select *, 
dense_rank() over(partition by job_title order by dev_amt desc) as top_violators
from pay_range
)
select * from rank_violators where top_violators = 1;


-- Job Mobility
with job_mobility as (
select employee_id, count(distinct job_id) as number_of_distinct_jobs,
count(distinct department_id) as number_of_distinct_departments
from job_history where employee_id != 0
group by employee_id
),
latest_history as (
select employee_id, job_id as hist_job_id,
row_number() over (partition by employee_id order by end_date desc) as rn
from job_history where employee_id != 0
),
current_vs_history as (
select e.employee_id, e.job_id as current_job_id, lh.hist_job_id
from employees e
join latest_history lh on e.employee_id = lh.employee_id
where lh.rn = 1 and e.employee_id != 0
)
select 
jm.employee_id, jm.number_of_distinct_jobs,
jm.number_of_distinct_departments,
case when jm.number_of_distinct_departments > 1 then 'moved departments' else 'static' end as dept_movement,
cvh.hist_job_id, cvh.current_job_id,
case when cvh.hist_job_id != cvh.current_job_id then 'changed role' else 'same role' end as role_change
from job_mobility jm
left join current_vs_history cvh on jm.employee_id = cvh.employee_id;


-- Region Hiring and Tenure
with tenure_calc as (
select e.employee_id, e.salary, r.region_name,
timestampdiff(year, e.hire_date, '1999-10-01') as tenure_years
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
join regions r on c.region_id = r.region_id
),
bucketed as (
select *, case 
when tenure_years < 1 then '[0–1)'
when tenure_years < 3 then '[1–3)'
when tenure_years < 5 then '[3–5)'
else '5+'
end as tenure_bucket
from tenure_calc
),
summary as (
select region_name, tenure_bucket, count(*) as headcount, avg(salary) as avg_salary
from bucketed
group by region_name, tenure_bucket
)
select *,
rank() over (partition by region_name order by headcount desc) as bucket_rank
from summary
order by region_name, bucket_rank;


-- Location and Data Quality
with cleaned_locations as (
select l.location_id,
trim(replace(replace(l.city, char(13), ''), '"', '')) as city,
trim(replace(replace(l.state_province, char(13), ''), '"', '')) as state_province,
trim(replace(replace(l.postal_code, char(13), ''), '"', '')) as postal_code,
trim(replace(replace(r.region_name, char(13), ''), '"', '')) as region_name,
l.country_id from locations l
join countries c on l.country_id = c.country_id
join regions r on c.region_id = r.region_id
),
suspect_rows as (
select * from cleaned_locations
where postal_code is null or postal_code = ''
or city is null or city = ''
or state_province is null or state_province = ''
),
countries_without_departments as (
select c.country_id, c.country_name from countries c
left join locations l on c.country_id = l.country_id
left join departments d on l.location_id = d.location_id
where d.department_id is null
)
select 'suspect location' as issue_type, location_id, city, state_province, postal_code, region_name, country_id
from suspect_rows
union all
select 'no departments in country' as issue_type, null, null, null, null, null, country_id
from countries_without_departments;



-- Dept-Region count mapping
with dept_stats as (
select e.department_id, count(*) as headcount,
sum(e.salary) as total_salary, avg(e.salary) as avg_salary,
min(e.salary) as min_salary, max(e.salary) as max_salary
from employees e
group by e.department_id
),
snapshot as (
select d.department_id, d.department_name, d.location_id, 
l.city, r.region_name, ds.headcount, ds.total_salary,
ds.avg_salary, ds.min_salary, ds.max_salary,
rank() over (partition by r.region_name order by ds.avg_salary desc) as rank_by_avg_salary
from dept_stats ds
join departments d on ds.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
join regions r on c.region_id = r.region_id
)
select * from snapshot
order by region_name, rank_by_avg_salary;


-- commission
with emp_region as (
select e.employee_id, r.region_name,
case when e.commission_pct is null then 0 else 1 end as has_commission
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
join regions r on c.region_id = r.region_id
)
select region_name,
sum(has_commission) as with_commission_count,
count(*) - sum(has_commission) as without_commission_count,
round(sum(has_commission) * 100.0 / count(*), 2) as pct_with_commission
from emp_region
group by region_name
order by pct_with_commission desc, region_name;


-- pay within range
with pay_position as (
select e.employee_id, concat(e.first_name, ' ', e.last_name) as name,
j.job_title, e.salary,
round((e.salary - j.min_salary) / nullif(j.max_salary - j.min_salary, 0), 2) as range_pct
from employees e
join jobs j on e.job_id = j.job_id
)
select * from (
select *, rank() over (partition by job_title order by range_pct desc) as rank_in_job
from pay_position
) as ranked
where rank_in_job <= 3;


-- dept pipeline
with dept_salary as (
select e.employee_id, e.department_id, e.salary,
sum(e.salary) over (partition by e.department_id order by e.salary desc 
rows between unbounded preceding and current row) as running_total,
sum(e.salary) over (partition by e.department_id) as total_dept_salary
from employees e
),
pipeline as (
select *,
running_total * 100.0 / total_dept_salary as pct_of_dept_payroll,
rank() over (partition by department_id order by salary desc) as salary_rank
from dept_salary
)
select *
from pipeline
where salary_rank = 1 or pct_of_dept_payroll >= 50;



-- merge Europe and Middle East and Asia

-- 1. headcount and payroll by new region
with remapped_regions as (
select r.region_id,
case 
when trim(replace(r.region_name, '\r', '')) in ('Europe', 'Middle East and Africa') then 'EMEA'
when trim(replace(r.region_name, '\r', '')) = 'Americas' then 'Americas'
when trim(replace(r.region_name, '\r', '')) = 'Asia' then 'Asia'
end as new_region_name,
d.department_id, d.department_name, e.salary
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
join regions r on c.region_id = r.region_id
)
select new_region_name, count(*) as headcount,
sum(salary) as total_payroll, avg(salary) as avg_salary
from remapped_regions
group by new_region_name;

-- 2. top 5 departments by headcount in EMEA
with remapped_regions as (
select r.region_id,
case 
when trim(replace(r.region_name, '\r', '')) in ('Europe', 'Middle East and Africa') then 'EMEA'
when trim(replace(r.region_name, '\r', '')) = 'Americas' then 'Americas'
when trim(replace(r.region_name, '\r', '')) = 'Asia' then 'Asia'
end as new_region_name,
d.department_id, d.department_name, e.salary
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
join regions r on c.region_id = r.region_id
)
select department_id, department_name,
count(*) as headcount
from remapped_regions
where new_region_name = 'EMEA'
group by department_id, department_name
order by headcount desc
limit 5;