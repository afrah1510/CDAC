use hr_database;

select employee_id, concat(first_name, " ", last_name) as full_name from employees;

select employee_id, concat(lower(first_name), " ", upper(last_name)) as full_name from employees;

select upper(country_name) from countries;

select first_name, length(first_name) as len_first_name from employees;

select email, length(email) as length_of_email from employees where length(email) > 10;

select first_name, substring(first_name, 1, 3) as first_three_char from employees;

select first_name, substring(first_name, -4) as first_three_char from employees;

select last_name, locate('a', last_name) from employees;

select first_name, job_id, locate("IT", job_id) from employees;

select first_name, replace(first_name, 'a', 'X') from employees;

select *, replace(region_name, "Europe", "EU") from regions;

select first_name, ltrim(first_name), rtrim(first_name) from employees;

select city, ltrim(city), rtrim(city) from locations;

select email, left(email, 5) from employees;

select country_name, right(country_name, 3) from countries;

select email, if(instr(email, '@') > 0, substring_index(email, '@', -1), NULL) as domain from employees;

select phone_number, substring_index(phone_number, ".", 1) as country_code from employees;

select first_name, last_name, if(strcmp(first_name, last_name) = 0, 0, 1) as name_match from employees;

-- \r is 13
select region_name, if(replace(region_name, '\r', '') = "Asia", 0, 1) as region_match from regions;

select concat(first_name, "-", last_name, "-", job_id) as full_name_job from employees;

select first_name, substring_index(email, '@', 1) as username from employees;

select last_name, replace(last_name, "e", "E") from employees where last_name like "%e%";

select first_name, locate("o", first_name) from employees;

select city, substring(trim(city), 1, 3) from locations; 

select last_name, locate("n", last_name) from employees where last_name like "%n%";

select first_name, locate("a", first_name) from employees;

select job_title, locate("e", job_title) from jobs where locate("e", job_title) > 5;

select first_name, last_name from employees where first_name < last_name;

select department_name from departments where find_in_set(department_name, "IT, HR");

select first_name, length(first_name) from employees where length(first_name) > 6;

select * from countries where country_name in ("India", "China", "Japan");

select first_name, last_name, department_id from employees where department_id in (50, 60, 70);

select country_name, left(country_name, 2), right(country_name, 2) from countries;

select last_name from employees where locate("o", last_name) > (length(last_name)/2);

select first_name, locate("a", first_name), locate("e", first_name) from employees;

select email, substring_index(email, '@', -1) as domain from employees where substring_index(email, '@', -1) like "example.com";

select count(*) from employees where department_id in (50, 60, 70);

select country_name from countries where region_id in (1, 3);

select first_name, last_name, department_id, salary from employees where department_id in (50, 60, 70) or salary > 10000;

select first_name, last_name, department_id, manager_id from employees where department_id in (50, 60) and manager_id in (103, 108);

select concat(e.first_name, ', ', e.last_name, ', ', c.country_name) as full_info from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id;

select concat(first_name, " ", last_name) as full_name, salary,
case
when salary > 8000 then upper(first_name)
when salary < 8000 then lower(last_name)
else "other"
end as emp_info
from employees;