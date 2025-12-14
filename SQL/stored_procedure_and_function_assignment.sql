use hr;

-- 1.	Write a stored procedure to retrieve all employees from the Employees table for a given department ID.
use hr;
delimiter $$
create procedure all_info_did(in d_id int)
deterministic
begin
select * from employees where department_id = d_id;
end;;
$$
delimiter ;

set @dept_id = 90;
call all_info_did(@dept_id);

-- 2.	Create a function that calculates the total salary expenditure for a given department ID.
use hr;
delimiter $$
create function dept_sal_info(d_id int)
returns int
deterministic
begin
declare tot_sal int;
select sum(salary) into tot_sal
from employees where department_id = d_id
group by department_id;
return tot_sal;
end;;
$$
delimiter ;

select dept_sal_info(30) as total_sal_dept;

-- 3.	Develop a stored procedure that accepts an employee ID as an input parameter and increases the salary of that employee by a specified percentage.
use hr;
delimiter $$
create procedure inc_sal(in e_id int)
deterministic
begin
select salary, salary*1.5 as inc_sal from employees
where employee_id = e_id;
end;;
$$
delimiter ;

set @emp = 158;
call inc_sal(@emp);

-- 4.	Write a function to determine the average salary for employees in a specific job title category.
use hr;
delimiter $$
create function job_avg_sal(j_id varchar(20))
returns int
deterministic
begin
declare avg_sal int;
select avg(salary) into avg_sal
from employees where job_id = j_id
group by job_id;
return avg_sal;
end;;
$$
delimiter ;

select job_avg_sal("PU_CLERK") as avg_sal_job;

-- 5.	Create a stored procedure that takes an employee's first name and last name as input parameters and returns the full name in uppercase letters.
use hr;
delimiter $$
create procedure full_name(in fname varchar(20), in lname varchar(20))
deterministic
begin
select concat(first_name, " ", last_name) as emp_name from employees
where first_name = fname and last_name = lname;
end;;
$$
delimiter ;

call full_name("Lex", "De Haan");


-- 6.	Write a stored procedure to insert a new employee into the Employees table with the provided first name, last name, and department ID.
use hr;
delimiter $$
create procedure insert_emp(in fname varchar(20), in lname varchar(20), in dept_id int)
deterministic
begin
insert into employees (first_name, last_name, department_id)
value (fname, lname, dept_id);
end;;
$$
delimiter ;

call insert_emp("Sammy", "Cowell", 40);
select * from employees where department_id = 40;

-- 7.	Create a function to calculate the total number of employees in a specific department.
use hr;
delimiter $$
create function tot_emp_dept(d_id int)
returns int
deterministic
begin
declare no_emp int;
select count(*) into no_emp 
from employees where department_id = d_id
group by department_id;
return no_emp;
end
$$
delimiter ;

select tot_emp_dept(110) as no_of_emp;

-- 8.	Develop a stored procedure that accepts an employee ID as input and deletes that employee's record from the Employees table.
use hr;
delimiter $$
create procedure del_emp(in e_id int)
deterministic
begin
delete from employees
where employee_id = e_id;
end;;
$$
delimiter ;

set @emp = 0;
call del_emp(@emp);
select * from employees where employee_id = @emp;

-- 9.	Write a function to determine the highest salary in the Employees table.
use hr;
delimiter $$
create function high_sal()
returns int
deterministic
begin
declare max_sal int;
select max(salary) into max_sal
from employees;
return max_sal;
end;;
$$
delimiter ;

select high_sal();

-- 10.	Create a stored procedure that takes a department ID as an input parameter and returns the list of employees sorted by their salary in descending order within that department.
use hr;
delimiter $$
create procedure get_emp_sal(in d_id int)
deterministic
begin
select department_id, concat(first_name, " ", last_name) as full_name, salary 
from employees where department_id = d_id
order by salary desc;
end;;
$$
delimiter ;

set @dept_id = 90;
call get_emp_sal(@dept_id);

-- 11.	Write a stored procedure to update the job title of an employee based on their employee ID.
use hr;
delimiter $$
create procedure up_emp(in e_id int)
deterministic
begin
update employees set job_id = "Analyst"
where employee_id = e_id;
end;;
$$
delimiter ;

set @emp = 104;
call up_emp(@emp);
select * from employees where employee_id = @emp;

-- 12.	Create a function that returns the number of employees hired in a specific year.
use hr;
delimiter $$
create function emp_hire(yr int)
returns int
deterministic
begin
declare no_emp int;
select count(*) into no_emp 
from employees where year(hire_date) = yr
group by year(hire_date);
return no_emp;
end
$$
delimiter ;

select emp_hire(1987);

-- 13.	Develop a stored procedure that accepts an employee ID as input and retrieves the employee's details, including their name, department, and salary.
use hr;
delimiter $$
create procedure emp_info(in e_id int)
deterministic
begin
select first_name, last_name, department_id, salary
from employees
where employee_id = e_id;
end;;
$$
delimiter ;

set @emp = 104;
call emp_info(@emp);

-- 14.	Write a function to calculate the average tenure (in years) of employees in the company.
use hr;
delimiter $$
create function avg_year()
returns decimal(6, 2)
deterministic
begin
declare avg_yr int;
select avg(timestampdiff(year, hire_date, curdate())) into avg_yr 
from employees;
return avg_yr;
end
$$
delimiter ;

select avg_year();

-- 15.	Create a stored procedure that takes a department ID as an input parameter and returns the department name along with the count of employees in that department.
use hr;
delimiter $$
create procedure dept_info(in d_id int)
deterministic
begin
select department_name, count(*) as no_of_emp 
from employees e 
left join departments d on e.department_id = d.department_id
where e.department_id = d_id
group by department_name;
end;;
$$
delimiter ;

set @dept_id = 40;
call dept_info(@dept_id);

-- 16.	Write a stored procedure to retrieve the top N highest-paid employees in the company, where N is an input parameter.
use hr;
delimiter $$
create procedure n_high(in num int)
deterministic
begin
declare off_val int;
set off_val = num - 1;
select first_name, last_name, salary
from employees
order by salary desc
limit 1 offset off_val;
end;;
$$
delimiter ;

set @n = 4;
call n_high(@n);

-- 17.	Create a function that calculates the total bonus amount for all employees based on their performance ratings.
use hr;
delimiter $$
create function total_bonus()
returns decimal(10,2)
deterministic
begin
declare total_bonus decimal(10,2);
declare avg_salary decimal(10,2);
select avg(salary) into avg_salary from employees;
select sum(
case 
when salary > avg_salary then salary * 0.15
when salary < avg_salary then salary * 0.1
end
) into total_bonus
from employees;
return total_bonus;
end;;
$$
delimiter ;

select total_bonus();

-- 18.	Develop a stored procedure that accepts a salary threshold as an input parameter and retrieves all employees with salaries above that threshold.
use hr;
delimiter $$
create procedure above_sal(in sal int)
deterministic
begin
select first_name, last_name, salary
from employees
where salary > sal;
end;;
$$
delimiter ;

set @thres = 10000;
call above_sal(@thres);

-- 19.	Write a function to determine the average age of employees in the company based on their birthdates.
use northwind;
delimiter $$
create function avg_age()
returns decimal(6, 2)
deterministic
begin
declare avg_yr int;
select avg(timestampdiff(year, birth_date, curdate())) into avg_yr 
from employees;
return avg_yr;
end;;
$$
delimiter ;

select avg_age();

-- 20.	Create a stored procedure that takes an employee's last name as an input parameter and returns all employees with a similar last name.
use hr;
delimiter $$
create procedure like_lname(in lname varchar(20))
deterministic
begin
select first_name, last_name from employees
where last_name like lname;
end;;
$$
delimiter ;

set @lname = "Smith";
call like_lname(@lname);

-- 21.	Write a stored procedure to update the email address of an employee based on their employee ID.
use hr;
delimiter $$
create procedure up_email(in e_id int)
deterministic
begin
update employees set email = concat(first_name, left(last_name, 1))
where employee_id = e_id;
end;;
$$
delimiter ;

set @emp = 165;
call up_email(@emp);
select first_name, last_name, email from employees where employee_id = @emp;

-- 22.	Create a function that calculates the total experience (in years) of all employees combined in the company.
use hr;
delimiter $$
create function tot_exp()
returns decimal(6, 2)
deterministic
begin
declare tot_yr int;
select sum(timestampdiff(year, hire_date, curdate())) into tot_yr 
from employees;
return tot_yr;
end;;
$$
delimiter ;

select tot_exp();

-- 23.	Develop a stored procedure that accepts a department ID as input and returns the department name along with the average salary of employees in that department.
use hr;
delimiter $$
create procedure dept_data(in d_id int)
deterministic
begin
select department_name, avg(salary) as avg_sal 
from employees e 
left join departments d on e.department_id = d.department_id
where e.department_id = d_id
group by department_name;
end;;
$$
delimiter ;

set @dept_id = 90;
call dept_data(@dept_id);

-- 24.	Write a function to determine the number of employees who have been with the company for more than a specified number of years.
use hr;
delimiter $$
create function emp_yr(yr int)
returns int
deterministic
begin
declare no_of int;
select count(*) into no_of 
from employees
where timestampdiff(year, hire_date, curdate()) > yr;
return no_of;
end;;
$$
delimiter ;

select emp_yr(30);


-- 25.	Create a stored procedure that takes a job title as an input parameter and returns the count of employees holding that job title.
use hr;
delimiter $$
create procedure job_emp_count(in j_id varchar(10))
deterministic
begin
select job_id, count(*) as no_of_emp 
from employees 
where job_id = j_id
group by job_id;
end;;
$$
delimiter ;

set @j_id = "PU_CLERK";
call job_emp_count(@j_id);

-- 26.	Write a stored procedure to retrieve the details of employees who have a salary within a specified range.
use hr;
delimiter $$
create procedure sal_range(in min int, in max int)
deterministic
begin
select first_name, last_name, salary from employees e 
where salary > min and salary < max;
end;;
$$
delimiter ;

set @min = 3000;
set @max = 4000;
call sal_range(@min, @max);

-- 27.	Create a function that calculates the total number of working hours for an employee in a given month.
use hr;
delimiter $$
create function tot_hrs()
returns int
deterministic
begin
declare tot_hr int;
select count(*)*8*24 into tot_hr 
from employees;
return tot_hr;
end;;
$$
delimiter ;

select tot_hrs();

-- 28.	Develop a stored procedure that accepts an employee ID as input and retrieves the employee's department name and manager's name.
use hr;
delimiter $$
create procedure emp_dept_man(in e_id int)
deterministic
begin
select e.employee_id, department_name, concat(m.first_name, " ", m.last_name) as manager_name
from employees e
join departments d on e.department_id = d.department_id
left join employees m on e.manager_id = m.employee_id
where e.employee_id = e_id;
end;;
$$
delimiter ;

set @emp = 165;
call emp_dept_man(@emp);

-- 29.	Write a function to determine the total number of employees hired in each year, grouped by the year of hire.
use hr;
drop function emp_hire_yr;
delimiter $$
create function emp_hire_yr()
returns varchar(4000)
deterministic
begin
declare all_yr varchar(4000);
select group_concat(concat(hire_year, ": ", emp_count) separator ', ') into all_yr 
from (select year(hire_date) as hire_year, count(*) as emp_count
from employees group by hire_year) as sub;
return all_yr;
end
$$
delimiter ;

select emp_hire_yr();

-- 30.	Create a stored procedure that takes a city name as an input parameter and returns the list of employees residing in that city.
use hr;
delimiter $$
create procedure loc_emp(in cname varchar(30))
deterministic
begin
select e.employee_id, concat(first_name, " ", last_name) as full_name
from locations l
join departments d on l.location_id = d.location_id
join employees e on d.department_id = e.department_id
where l.city = cname;
end;;
$$
delimiter ;

set @city = "Toronto";
call loc_emp(@city);


use enterprise_hr;

-- 31.	Write a stored procedure that calculates the average salary increase percentage for employees who have been with the company for more than five years.
delimiter $$
create procedure avg_sal_increase()
deterministic
begin
select *, avg((bonus + allowance) / salary * 100) as avg_increase_pct
from employees
where timestampdiff(year, hire_date, curdate()) > 5
group by employee_id;
end;;
$$
delimiter ;

call avg_sal_increase();

-- 32.	Create a function that calculates the total sales revenue generated by each employee in the Sales department, considering both individual and team contributions.
delimiter $$
create function fn_sales_revenue(emp_id int)
returns decimal(12,2)
deterministic
begin
declare total decimal(12,2);
select sum(amount + team_contribution) into total
from sales where employee_id = emp_id;
return ifnull(total, 0.00);
end;;
$$
delimiter ;

select employee_id, fn_sales_revenue(employee_id) as total_revenue
from employees where department_id = 1;

-- 33.	Develop a stored procedure that accepts a date range as input and retrieves all employee attendance records within that period, including late arrivals and early departures.
delimiter $$
create procedure get_attendance(in start_date date, in end_date date)
deterministic
begin
select a.employee_id, e.first_name, a.date, 
a.arrival_time, a.departure_time,
case when a.arrival_time > '09:30:00' then 'late' 
else 'on time' 
end as arrival_status,
case when a.departure_time < '17:00:00' then 'early leave' 
else 'full day' 
end as departure_status
from attendance a
join employees e on a.employee_id = e.employee_id
where a.date between start_date and end_date;
end;;
$$
delimiter ;

call get_attendance('2025-10-01', '2025-10-03');

-- 34.	Write a function that determines the average number of projects handled by employees in each department and identifies departments with exceptionally high or low project volumes.
delimiter $$
create function fn_avg_projects_per_dept(dept_id int)
returns decimal(5,2)
deterministic
begin
declare avg_projects decimal(5,2);
select avg(project_count) into avg_projects
from (select count(distinct ep.project_id) as project_count
from employee_projects ep
join employees e on ep.employee_id = e.employee_id
where e.department_id = dept_id
group by ep.employee_id) as sub;
return ifnull(avg_projects, 0.00);
end;;
$$
delimiter ;

select department_id, department_name, fn_avg_projects_per_dept(department_id) as avg_projects
from departments;

-- 35.	Create a stored procedure that takes a job title as an input parameter and returns the list of employees holding that job title, along with the total compensation considering bonuses and allowances.
delimiter $$
create procedure get_employees_by_title(in title varchar(50))
deterministic
begin
select employee_id, concat(first_name, ' ', last_name) as name,
salary, bonus, allowance, salary + bonus + allowance as total_compensation
from employees
where job_title = title;
end;;
$$
delimiter ;

call get_employees_by_title('Data Analyst');

-- 36.	Write a stored procedure that calculates the performance rating for each employee based on various criteria, such as project completion, client feedback, and adherence to deadlines.
delimiter $$
create procedure calc_performance_rating()
deterministic
begin
select e.employee_id, concat(e.first_name, ' ', e.last_name) as name,
round(avg(ep.contribution_score)/10, 2) as performance_rating
from employees e
join employee_projects ep on e.employee_id = ep.employee_id
group by e.employee_id;
end;;
$$
delimiter ;

call calc_performance_rating();

-- 37.	Create a function that determines the average time taken to resolve customer issues for each support agent, considering different issue categories and urgency levels.
delimiter $$
create function fn_avg_resolution_time(agt_id int)
returns decimal(6,2)
deterministic
begin
declare avg_time decimal(6,2);
select avg(resolution_time) into avg_time
from support_tickets
where agent_id = agt_id;
return ifnull(avg_time, 0.00);
end;;
$$
delimiter ;

select agent_id, fn_avg_resolution_time(agent_id) as avg_resolution_time
from support_tickets
group by agent_id;

-- 38.	Develop a stored procedure that accepts a date range and a specific project ID as input and retrieves all employee work hours dedicated to that project within the given period.
delimiter $$
create procedure get_project_hours(in pid int, in start_date date, in end_date date)
deterministic
begin
select ep.employee_id, concat(e.first_name, ' ', e.last_name) as name,
ep.hours_worked, ep.contribution_score
from employee_projects ep
join employees e on ep.employee_id = e.employee_id
join projects p on ep.project_id = p.project_id
where ep.project_id = pid 
and p.start_date >= start_date
and p.end_date <= end_date;
end;; 
$$
delimiter ;

call get_project_hours(1, '2025-01-01', '2025-12-31');

-- 39.	Write a function that calculates the employee turnover rate for each department, considering the number of new hires and the number of departures over a specified time frame.
delimiter $$
create function fn_turnover_rate(dept_id int, start_date date, end_date date)
returns decimal(5,2)
deterministic
begin
declare hires int default 0.00;
declare exits int default 0.00;
declare total int default 0.00;
declare rate decimal(5,2);
select count(*) into hires from employees
where department_id = dept_id and hire_date between start_date and end_date;
select count(*) into exits from employees
where department_id = dept_id and hire_date < start_date; 
set total = hires + exits;
if total = 0 then set rate = 0.00;
else set rate = (exits / total) * 100;
end if;
return rate;
end;;
$$
delimiter ;

select department_id, department_name, fn_turnover_rate(department_id, '2025-01-01', '2025-12-31') as turnover_pct
from departments;

-- 40.	Create a stored procedure that takes a location as an input parameter and returns the list of employees who have been involved in projects related to that location, along with their project contributions and performance ratings.
delimiter $$
create procedure get_employees_by_location(in loc varchar(50))
deterministic
begin
select e.employee_id, concat(e.first_name, ' ', e.last_name) as name,
p.project_name, ep.contribution_score
from employee_projects ep
join employees e on ep.employee_id = e.employee_id
join projects p on ep.project_id = p.project_id
where p.location = loc;
end;;
$$
delimiter ;

call get_employees_by_location('Mumbai');
