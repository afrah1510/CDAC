use update_assgn;

CREATE TABLE emp (
  empno decimal(4,0) NOT NULL,
  ename varchar(10) default NULL,
  job varchar(9) default NULL,
  mgr decimal(4,0) default NULL,
  hiredate date default NULL,
  sal decimal(7,2) default NULL,
  comm decimal(7,2) default NULL,
  deptno decimal(2,0) default NULL
);

CREATE TABLE dept (
  deptno decimal(2,0) default NULL,
  dname varchar(14) default NULL,
  loc varchar(13) default NULL
);

INSERT INTO emp VALUES ('7369','SMITH','CLERK','7902','1980-12-17','800.00',NULL,'20');
INSERT INTO emp VALUES ('7499','ALLEN','SALESMAN','7698','1981-02-20','1600.00','300.00','30');
INSERT INTO emp VALUES ('7521','WARD','SALESMAN','7698','1981-02-22','1250.00','500.00','30');
INSERT INTO emp VALUES ('7566','JONES','MANAGER','7839','1981-04-02','2975.00',NULL,'20');
INSERT INTO emp VALUES ('7654','MARTIN','SALESMAN','7698','1981-09-28','1250.00','1400.00','30');
INSERT INTO emp VALUES ('7698','BLAKE','MANAGER','7839','1981-05-01','2850.00',NULL,'30');
INSERT INTO emp VALUES ('7782','CLARK','MANAGER','7839','1981-06-09','2450.00',NULL,'10');
INSERT INTO emp VALUES ('7788','SCOTT','ANALYST','7566','1982-12-09','3000.00',NULL,'20');
INSERT INTO emp VALUES ('7839','KING','PRESIDENT',NULL,'1981-11-17','5000.00',NULL,'10');
INSERT INTO emp VALUES ('7844','TURNER','SALESMAN','7698','1981-09-08','1500.00','0.00','30');
INSERT INTO emp VALUES ('7876','ADAMS','CLERK','7788','1983-01-12','1100.00',NULL,'20');
INSERT INTO emp VALUES ('7900','JAMES','CLERK','7698','1981-12-03','950.00',NULL,'30');
INSERT INTO emp VALUES ('7902','FORD','ANALYST','7566','1981-12-03','3000.00',NULL,'20');
INSERT INTO emp VALUES ('7934','MILLER','CLERK','7782','1982-01-23','1300.00',NULL,'10');

INSERT INTO dept VALUES ('10','ACCOUNTING','NEW YORK');
INSERT INTO dept VALUES ('20','RESEARCH','DALLAS');
INSERT INTO dept VALUES ('30','SALES','CHICAGO');
INSERT INTO dept VALUES ('40','OPERATIONS','BOSTON');


CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);
INSERT INTO customers (first_name, last_name, email) VALUES
('Aalia', 'Khan', 'aalia.khan@example.com'),
('Ravi', 'Patel', 'ravi.patel@example.com'),
('Neha', 'Verma', 'neha.verma@example.com');

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO sales (customer_id, amount, sale_date) VALUES
(1, 15000.00, '2025-09-15'),
(2, 20000.00, '2025-09-20'),
(3, 12000.00, '2025-10-01');





-- 1
select * from emp e where sal > (select avg(sal) from emp where deptno = e.deptno);

-- 2
select * from emp where length(ename) = 5;

-- 3
select * from emp where ename like 'J%S';

-- 4
select * from emp where deptno not in (10, 20, 40);

-- 5
select * from emp where job not in ('PRESIDENT', 'MANAGER');

-- 6
select * from emp where sal between 100 and 999;

-- 7
select * from emp where comm is null or comm = 0;

-- 8
select ename from emp where ename like '_l%';

-- 9
select distinct sal from emp order by sal desc limit 1; 
select distinct sal from emp order by sal asc limit 1; 

-- 10
select deptno from emp group by deptno having count(*) = 3;

-- 11
select e1.ename as manager, e2.ename as subordinate
from emp e1 join emp e2 on e1.empno = e2.mgr;

-- 12
select e.ename, e.sal, e.deptno, d.dname
from emp e right join dept d on e.deptno = d.deptno;

-- 13
select e.ename, e.sal, e.deptno
from emp e left join dept d on e.deptno = d.deptno;

-- 14
select e.ename, e.sal, e.deptno, d.dname
from emp e left join dept d on e.deptno = d.deptno
union
select e.ename, e.sal, e.deptno, d.dname
from emp e right join dept d on e.deptno = d.deptno;

-- 15
select ename, empno,
(select dname from dept where dept.deptno = emp.deptno) as dname,
(select loc from dept where dept.deptno = emp.deptno) as loc
from emp;

-- 16
select * from dept where deptno not in (select distinct deptno from emp);

-- 17
select * from dept where deptno in (select distinct deptno from emp);

-- 18
select * from emp where empno not in (select distinct mgr from emp where mgr is not null);

-- 19
select concat(ename, ' belongs to ', deptno) as info from emp;

-- 20
select
sum(year(hiredate) = 1980) as hired_1980,
sum(year(hiredate) = 1981) as hired_1981,
sum(year(hiredate) = 1982) as hired_1982
from emp;

-- 21
select ename, deptno,
case deptno
when 10 then 'ten'
when 20 then 'twenty'
when 30 then 'thirty'
when 40 then 'fourty'
end as dept_label
from emp;

-- 22
select lower(ename) as ename,
concat(upper(left(job,1)), lower(substring(job,2))) as job
from emp;

-- 23
select * from emp where day(hiredate) between 1 and 7;

-- 24
select * from emp where week(hiredate, 1) = 49;

-- 25
select empno, deptno, sal,
sal - lag(sal) over (order by deptno desc) as sal_diff
from emp;

-- 26
create table emp1 as select * from emp where deptno = 10;

-- 27
create table emp2 like emp;

-- 28
insert into emp1 values (9999,'NEW','CLERK',null,'2025-10-01',1000.00,null,10);
insert into emp select * from emp1
where empno not in (select empno from emp);

-- 29
select * from emp where deptno = (select deptno from emp where ename = 'JAMES');

-- 30
select * from emp where sal <= (select sal from emp where ename = 'ADAMS');

-- 31
select * from emp where hiredate < (select hiredate from emp where ename = 'WARD');

-- 32
select * from emp where mgr = (select empno from emp where ename = 'BLAKE');

-- 33
select e1.empno, e1.ename, e1.mgr
from emp e1 where e1.mgr = (select empno from emp where ename = 'BLAKE')
union
select e2.empno, e2.ename, e2.mgr
from emp e2 where e2.mgr in (
select e1.empno from emp e1 where e1.mgr = (select empno from emp where ename = 'BLAKE')
);

-- 34
select * from emp where deptno in (select deptno 
from emp where job = (select job from emp where ename = 'KING'));

-- 35
update emp set sal = case
when deptno = 40 then sal * 1.25
when deptno = 90 then sal * 1.15
when deptno = 110 then sal * 1.10
else sal end;

-- 36
select ename from emp where job = 'MANAGER' and year(hiredate) = 1981;

-- 37
select ename from emp where comm = (select max(comm) from emp where comm is not null);

-- 38
select ename, timestampdiff(year, hiredate, curdate()) as years_worked
from emp order by hiredate asc limit 1;

-- 39
select ename, hiredate from emp order by hiredate asc limit 1;
select ename, hiredate from emp order by hiredate desc limit 1;

-- 40
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

-- 41
select * from emp where deptno in (select deptno from dept where loc = 'DALLAS');

-- 42
select e.ename, e.job, d.dname, e.deptno
from (select * from emp) e join dept d on e.deptno = d.deptno;

-- 43
SELECT e.ename, e.job, e.sal, d.dname
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE NOT (
(sal <= 1000) OR
(sal BETWEEN 1001 AND 2000) OR
(sal BETWEEN 2001 AND 3000) OR
(sal > 3000)
);

-- 44
select empno, ename, sal from emp
union all
select empno, ename, sal from emp1;

-- 45
select * from emp where job = 'PRESIDENT';