use hr_database;

# Ranking Functions
-- 1.	Find the top 3 highest paid employees in each department using RANK().
with ranked_emps as (
select employee_id, first_name, department_id, salary,
rank() over (partition by department_id order by salary desc) as rank_in_dept
from employees
)
select * from ranked_emps where rank_in_dept <= 3;

-- 2.	Assign a unique row number to each employee within their department using ROW_NUMBER() based on salary descending.
with numbered_emps as (
select employee_id, first_name, department_id, salary,
row_number() over (partition by department_id order by salary desc) as row_num
from employees
)
select * from numbered_emps;

-- 3.	List departments where at least two employees share the same salary rank using DENSE_RANK().
with dense_ranked as (
select department_id, salary,
dense_rank() over (partition by department_id order by salary desc) as emp_dense_rank
from employees
)
select department_id, salary, count(*) as count_same_rank
from dense_ranked
group by department_id, emp_dense_rank, salary
having count(*) >= 2;

-- 4.	Divide employees into 4 equal salary groups using NTILE(4) and display the group number along with employee details.
with salary_groups as (
select employee_id, first_name, department_id, salary,
ntile(4) over (order by salary desc) as salary_group
from employees
)
select * from salary_groups;

-- 5.	Find the top 3 highest paid employees in each department using RANK().
with ranked_emps as (
select employee_id, first_name, department_id, salary,
rank() over (partition by department_id order by salary desc) as rank_in_dept
from employees
)
select * from ranked_emps where rank_in_dept <= 3;

-- 6.	Assign a unique row number to each employee within their department using ROW_NUMBER() based on salary descending.
with numbered_emps as (
select employee_id, first_name, department_id, salary,
row_number() over (partition by department_id order by salary desc) as row_num
from employees
)
select * from numbered_emps;

-- 7.	List departments where at least two employees share the same salary rank using DENSE_RANK().
with dense_ranked as (
select department_id, salary,
dense_rank() over (partition by department_id order by salary desc) as emp_dense_rank
from employees
)
select department_id, salary, count(*) as count_same_rank
from dense_ranked
group by department_id, emp_dense_rank, salary
having count(*) >= 2;

-- 8.	Divide employees into 4 equal salary groups using NTILE(4) and display the group number along with employee details.
with salary_groups as (
select employee_id, first_name, department_id, salary,
ntile(4) over (order by salary desc) as salary_group
from employees
)
select * from salary_groups;



# Aggregate Window Functions
-- 1.	For each employee, show their salary and the average salary of their department using AVG() as a window function.
with avg_salary_cte as (
select employee_id, first_name, department_id, salary,
round(avg(salary) over (partition by department_id), 2) as avg_dept_salary
from employees
)
select * from avg_salary_cte;

-- 2.	Show the running total of salaries for each department ordered by hire date using SUM() window function.
with running_total_cte as (
select employee_id, first_name, department_id, hire_date, salary,
sum(salary) over (partition by department_id order by hire_date) as running_total
from employees
)
select * from running_total_cte;

-- 3.	Find the maximum salary in each department and compare it with each employee’s salary.
with max_salary_cte as (
select employee_id, first_name, department_id, salary,
max(salary) over (partition by department_id) as max_dept_salary
from employees
)
select * from max_salary_cte;

-- 4.	For each employee, show their salary and the average salary of their department using AVG() as a window function.
with avg_salary_cte as (
select employee_id, first_name, department_id, salary,
round(avg(salary) over (partition by department_id), 2) as avg_dept_salary
from employees
)
select * from avg_salary_cte;

-- 5.	Show the running total of salaries for each department ordered by hire date using SUM() window function.
with running_total_cte as (
select employee_id, first_name, department_id, hire_date, salary,
sum(salary) over (partition by department_id order by hire_date) as running_total
from employees
)
select * from running_total_cte;

-- 6.	Find the maximum salary in each department and compare it with each employee’s salary.
with max_salary_cte as (
select employee_id, first_name, department_id, salary,
max(salary) over (partition by department_id) as max_dept_salary
from employees
)
select * from max_salary_cte;



# Value Functions
-- 1.	For each employee, show their salary and the salary of the employee hired just before them using LAG().
with lag_salary_cte as (
select employee_id, first_name, hire_date, salary,
lag(salary) over (order by hire_date) as previous_salary
from employees
)
select * from lag_salary_cte;

-- 2.	Display each employee’s salary and the salary of the next hired employee in the same department using LEAD().
with lead_salary_cte as (
select employee_id, first_name, department_id, hire_date, salary,
lead(salary) over (partition by department_id order by hire_date) as next_salary
from employees
)
select * from lead_salary_cte;

-- 3.	List each department and show the first and last hired employee using FIRST_VALUE() and LAST_VALUE() functions.
with hire_window_cte as (
select employee_id, first_name, department_id, hire_date,
first_value(first_name) over (partition by department_id order by hire_date) as first_hired,
last_value(first_name) over (partition by department_id order by hire_date
rows between unbounded preceding and unbounded following) as last_hired
from employees
)
select distinct department_id, first_hired, last_hired from hire_window_cte;

-- 4.	For each employee, show their salary and the salary of the employee hired just before them using LAG().
with lag_salary_cte as (
select employee_id, first_name, hire_date, salary,
lag(salary) over (order by hire_date) as previous_salary
from employees
)
select * from lag_salary_cte;

-- 5.	Display each employee’s salary and the salary of the next hired employee in the same department using LEAD().
with lead_salary_cte as (
select employee_id, first_name, department_id, hire_date, salary,
lead(salary) over (partition by department_id order by hire_date) as next_salary
from employees
)
select * from lead_salary_cte;

-- 6.	List each department and show the first and last hired employee using FIRST_VALUE() and LAST_VALUE() functions.
with hire_window_cte as (
select employee_id, first_name, department_id, hire_date,
first_value(first_name) over (partition by department_id order by hire_date) as first_hired,
last_value(first_name) over (partition by department_id order by hire_date
rows between unbounded preceding and unbounded following) as last_hired
from employees
)
select distinct department_id, first_hired, last_hired from hire_window_cte;
