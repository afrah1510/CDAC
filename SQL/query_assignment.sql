use update_assgn;

-- 1.	Calculate the average rating of all salaries, with an alias for the average salary.
select avg(sal) as average_salary from emp;

-- 2.	Retrieve the name and email address of all customers, with an alias for the concatenation of their first and last name:
select concat(first_name, ' ', last_name) as full_name, email from customers;

-- 3.	Retrieve the number of  departments, with an alias for the count_of_dept.
select count(*) as count_of_dept from dept;

-- 4.	Write a query to calculate the total revenue generated from sales, and alias the sum as "Total Sales Revenue"
select sum(amount) as "Total Sales Revenue" from sales;

-- 5.	Display all the employees whose salary is greater than the average salary of their department. 
select * from emp e where sal > (select avg(sal) from emp where deptno = e.deptno);

-- 6.	Display employees where length of employee name is 5
select * from emp where length(ename) = 5;

-- 7.	Display all employees where employee name start with J and ends with S
select * from emp where ename like 'J%S';

-- 8.	Display all employees where employee does not belong to 10,20,40 department_id
select * from emp where deptno not in (10, 20, 40);

-- 9.	Display all employees where jobs do not belong to the PRESIDENT and MANAGER?
select * from emp where job not in ('PRESIDENT', 'MANAGER');

-- 10.	Display all three figures salary in emp table
select * from emp where sal between 100 and 999;

-- 11.	Display all records in emp table for employee who does not receive any commission
select * from emp where comm is null or comm = 0;

-- 12.	Display all employee names where the first character could be anything, but the second character should be L?
select ename from emp where ename like '_l%';

-- 13.	Display nth highest and nth lowest salary in emp table?
select distinct sal from emp order by sal desc limit 1; 
select distinct sal from emp order by sal asc limit 1; 

-- 14.	Display all the departments where the department has 3 employees?
select deptno from emp group by deptno having count(*) = 3;

-- 15.	Display emp name and corresponding subordinates. Use CONNECT BY clause.
select e1.ename as manager, e2.ename as subordinate
from emp e1 join emp e2 on e1.empno = e2.mgr;

-- 16.	Display all employee name, sal, dept id,department name from emp, dept table where all departments which have employees as well as department does not have any employees. This query should include non matching rows.
select e.ename, e.sal, e.deptno, d.dname
from emp e right join dept d on e.deptno = d.deptno;

-- 17.	Display all employee name, sal, dept id from emp, dept table where all employees which have matching departments as well as employee does not have any departments. This query should include non matching rows.
-- Note: In the below query, employees will always have matching records in dept table. Emp, dept table may not be a good example to answer this question.
select e.ename, e.sal, e.deptno
from emp e left join dept d on e.deptno = d.deptno;

-- 18.	Display all employee name, sal, dept id from emp, dept table where all employees which have matching and non matching department as well as all departments in dept table which has matching and non matching employees. This query should include non matching rows on both the tables. 
-- Note: In the below query, employees will always have matching records in the dept table. Emp, dept table may not be a good example to answer this question.
select e.ename, e.sal, e.deptno, d.dname
from emp e left join dept d on e.deptno = d.deptno
union
select e.ename, e.sal, e.deptno, d.dname
from emp e right join dept d on e.deptno = d.deptno;

-- 19.	Display all ename, empno, dname, loc from emp, dept table without joining two tables
select ename, empno,
(select dname from dept where dept.deptno = emp.deptno) as dname,
(select loc from dept where dept.deptno = emp.deptno) as loc
from emp;

-- 20.	Display all the departments where department does not have any employees
select * from dept where deptno not in (select distinct deptno from emp);

-- 21.	Display all the departments where department does have at least one employee
select * from dept where deptno in (select distinct deptno from emp);

-- 22.	Display all employees who are not managers?
select * from emp where empno not in (select distinct mgr from emp where mgr is not null);

-- 23.	Display ename, deptno from emp table with format of {ename} belongs to {deptno}
select concat(ename, ' belongs to ', deptno) as info from emp;

-- 24.	Display total number of employees hired for 1980,1981,1982. The output should be in one record.
select
sum(year(hiredate) = 1980) as hired_1980,
sum(year(hiredate) = 1981) as hired_1981,
sum(year(hiredate) = 1982) as hired_1982
from emp;

-- 25.	Display employee name, dept id from employee table. Also add another column in the same query and it should display ten for dept 10, twenty for dept 20, thirty for dept 30, fourty for dept 40
select ename, deptno,
case deptno
when 10 then 'ten'
when 20 then 'twenty'
when 30 then 'thirty'
when 40 then 'fourty'
end as dept_label
from emp;

-- 26.	Display all the records in the emp table. The employee name should be lower case. The job first character should be uppercase and the rest of the character in the job field should be lowercase.
select lower(ename) as ename,
concat(upper(left(job,1)), lower(substring(job,2))) as job
from emp;

-- 27.	Display all employees who have joined in the first week of the month ?
select * from emp where day(hiredate) between 1 and 7;

-- 28.	Display all employees who have joined in the 49th week of the year?
select * from emp where week(hiredate, 1) = 49;

-- 29.	Display empid, deptid, salary, salary difference between current record and previous record in emp table. Deptno should be in descending order.
select empno, deptno, sal,
sal - lag(sal) over (order by deptno desc) as sal_diff
from emp;

-- 30.	Create table emp1 and copy the emp table for dept id 10 while creating the table
create table emp1 as select * from emp where deptno = 10;

-- 31.	Create table emp2 with the same structure of emp table. Do not copy the data
create table emp2 like emp;

-- 32.	Insert new record in emp1 table, Merge the emp1 table on emp table.
insert into emp1 values (9999,'NEW','CLERK',null,'2025-10-01',1000.00,null,10);
insert into emp select * from emp1
where empno not in (select empno from emp);

-- 33.	Display all the records for dept id which belongs to employee name JAMES? 
select * from emp where deptno = (select deptno from emp where ename = 'JAMES');

-- 34.	Display all the records in the emp table where salary should be less then or equal to ADAMS salary?
select * from emp where sal <= (select sal from emp where ename = 'ADAMS');

-- 35.	Display all employees that were joined before employee WARD joined?
select * from emp where hiredate < (select hiredate from emp where ename = 'WARD');

-- 36.	Display all subordinates who are working under BLAKE?
select * from emp where mgr = (select empno from emp where ename = 'BLAKE');

-- 37.	Display all subordinates(all levels) for employee BLAKE?
select e1.empno, e1.ename, e1.mgr
from emp e1 where e1.mgr = (select empno from emp where ename = 'BLAKE')
union
select e2.empno, e2.ename, e2.mgr
from emp e2 where e2.mgr in (
select e1.empno from emp e1 where e1.mgr = (select empno from emp where ename = 'BLAKE')
);

-- 38.	Display all records in the emp table for the dept id which belongs to KING's Job? 
select * from emp where deptno in (select deptno 
from emp where job = (select job from emp where ename = 'KING'));

-- 39.	Write a SQL statement to increase the salary of employees under the department 40, 90 and 110 according to the company rules that salary will be increased by 25% for department 40, 15% for department 90 and 10% for department 110 and the rest of the departments will remain the same.
update emp set sal = case
when deptno = 40 then sal * 1.25
when deptno = 90 then sal * 1.15
when deptno = 110 then sal * 1.10
else sal end;

-- 40.	Display list of employee names of those who have joined in Year 81 as MANAGER?
select ename from emp where job = 'MANAGER' and year(hiredate) = 1981;

-- 41.	Display who is making the highest commission?
select ename from emp where comm = (select max(comm) from emp where comm is not null);

-- 42.	Display who is the senior most employee? How many years has been working?
select ename, timestampdiff(year, hiredate, curdate()) as years_worked
from emp order by hiredate asc limit 1;

-- 43.	Display who is the most experienced and least experienced employee?
select ename, hiredate from emp order by hiredate asc limit 1;
select ename, hiredate from emp order by hiredate desc limit 1;

-- 44.	Display employee name, sal, grade, dept name, loc for each employee.
select e.ename, e.sal,
case
when sal <= 1000 then 'a'
when sal > 1000 and sal <= 2000 then 'b'
when sal > 2000 and sal <= 3000 then 'c'
else 'd'
end as grade,
d.dname, d.loc
from emp e
join dept d on e.deptno = d.deptno;

-- 45.	Display all employees whose location is DALLAS?
select * from emp where deptno in (select deptno from dept where loc = 'DALLAS');

-- 46.	Display ename, job, dname, deptno for each employee by using INLINE view?
select e.ename, e.job, d.dname, e.deptno
from (select * from emp) e join dept d on e.deptno = d.deptno;

-- 47.	List employee name, job, sal and department of all employees whose salary is not within the salary grade?
SELECT e.ename, e.job, e.sal, d.dname
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE NOT (
(sal <= 1000) OR
(sal BETWEEN 1001 AND 2000) OR
(sal BETWEEN 2001 AND 3000) OR
(sal > 3000)
);

-- 48.	Use EMP and EMP1 tables. Query should have only three columns. Display empno,ename,sal from both tables including duplicates. 
select empno, ename, sal from emp
union all
select empno, ename, sal from emp1;

-- 49.	Display the employees for empno which belongs to job PRESIDENT?
select * from emp where job = 'PRESIDENT';

-- 50.	Display the total number of records in the Emp table?
select count(*) as total_records from emp;

-- 51.	Display emp table with salary descending order?
select * from emp order by sal desc;

-- 52.	Display all the records in emp table order by ascending deptno, descending salary?
select * from emp order by deptno asc, sal desc;

-- 53.	Display all employees with how many years they have been servicing in the company?
select ename, floor(datediff(curdate(), hiredate)/365) as years_served from emp;

-- 54.	Select hire_date + 1 from employees limit 1;
select hiredate + interval 1 day from emp limit 1;

-- 55.	Select hire_date + interval 1 month from employees limit 1;
select hiredate + interval 1 month from emp limit 1;

-- 56.	Select hire_date - interval 1 year from employees limit 1;
select hiredate - interval 1 year from emp limit 1;

-- 57.	datediff() : return the number of days between two days
select datediff('2025-10-03', hiredate) as days_since_hire from emp;

-- 58.	Add 3 months with hiredate in the EMP table and display the result?
select ename, hiredate, hiredate + interval 3 month as review_date from emp;

-- 59.	Find the date, 15 days after today’s date.
select curdate() + interval 15 day as future_date;

-- 60.	Write a query to display the current date?
select curdate() as today;

-- 61.	Display a distinct job from the emp table?
select distinct job from emp;

-- 62.	Display all the records in the emp table where employees hired after 28-SEP-81 and before 03-DEC-81?
select * from emp where hiredate > '1981-09-28' and hiredate < '1981-12-03';

-- 63.	Write a query that displays the employee’s names with the first letter capitalized and all other letters lowercase for all employees whose name starts with J, A, or M
select concat(upper(left(ename,1)), lower(substring(ename,2))) as formatted_name
from emp where ename like 'j%' or ename like 'a%' or ename like 'm%';

-- 64.	Display all jobs that are in department 10. Include the location of the department in the output.
select e.job, d.loc 
from emp e
join dept d on e.deptno = d.deptno
where e.deptno = 10;

-- 65.	Write a query to display the employee name, department name of all employees who earn a commission
select e.ename, d.dname 
from emp e
join dept d on e.deptno = d.deptno
where e.comm is not null and e.comm > 0;

-- 66.	Display the empno, employee name, sal, and salary increased by 15%.
select empno, ename, sal, sal * 1.15 as increased_salary from emp;

-- 67.	Display employee name, sal, grade. Use emp, salgrade table

-- 			Salary > 15000 Grade A
-- 			Salary > 10000 and < 15000 Grade B
-- 			Salary between  5000 abd 10000  Grade C
-- 			Salary < 5000 Grade D
-- 			
-- 			And Sort on the basis of Grades
select ename, sal,
case 
when sal > 15000 then 'a'
when sal > 10000 then 'b'
when sal between 5000 and 10000 then 'c'
else 'd'
end as grade
from emp
order by grade;