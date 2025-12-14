create database group_by_assgn;
use group_by_assgn;

CREATE TABLE company_data (
    order_id INT,
    order_date DATE,
    customer_id INT,
    customer_city VARCHAR(50),
    grade INT,
    purchase_amount DECIMAL(10,2),
    salesperson_id INT,
    salesperson_city VARCHAR(50),
    product_id INT,
    product_price DECIMAL(10,2),
    company_id INT,
    department_code INT,
    department_name VARCHAR(50),
    location VARCHAR(50),
    allotment_amount DECIMAL(10,2),
    employee_id INT,
    employee_name VARCHAR(100),
    job_title VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO company_data VALUES
(101, '2012-08-17', 3001, 'Mumbai', 85, 2500.00, 5003, 'Mumbai', 201, 450.00, 1001, 90, 'HR', 'Mumbai', 50000.00, 7001, 'Ravi Kumar', 'Manager', 75000.00),
(102, '2012-08-17', 3002, 'Delhi', 90, 6000.00, 5004, 'Delhi', 202, 550.00, 1002, 91, 'Finance', 'Delhi', 60000.00, 7002, 'Anita Desai', 'Analyst', 65000.00),
(103, '2012-08-18', 3003, 'Chennai', NULL, 3000.00, 5005, 'Chennai', 203, 350.00, 1003, 92, 'IT', 'Chennai', 70000.00, 7003, 'Suresh Rao', 'Programmer', 55000.00),
(104, '2012-08-19', 3004, 'Kolkata', 88, 5760.00, 5006, 'Kolkata', 204, 400.00, 1004, 93, 'Sales', 'Kolkata', 45000.00, 7004, 'Meena Gupta', 'Sales Executive', 48000.00),
(105, '2012-08-20', 3005, 'Pune', NULL, 2000.00, 5007, 'Pune', 205, 600.00, 1005, 94, 'Marketing', 'Pune', 55000.00, 7005, 'Rajesh Sharma', 'Marketing Lead', 62000.00),
(106, '2012-08-21', 3006, 'Nagpur', 82, 3200.00, 5008, 'Nagpur', 206, 475.00, 1006, 95, 'Operations', 'Nagpur', 52000.00, 7006, 'Neha Joshi', 'Operations Lead', 63000.00),
(107, '2012-08-22', 3007, 'Jaipur', 91, 4100.00, 5009, 'Jaipur', 207, 510.00, 1007, 96, 'Legal', 'Jaipur', 48000.00, 7007, 'Amit Verma', 'Legal Advisor', 58000.00),
(108, '2012-08-23', 3008, 'Surat', NULL, 1900.00, 5010, 'Surat', 208, 390.00, 1008, 97, 'Admin', 'Surat', 47000.00, 7008, 'Kavita Mehta', 'Admin Officer', 51000.00),
(109, '2012-08-24', 3009, 'Indore', 87, 2750.00, 5001, 'Indore', 209, 430.00, 1009, 98, 'Support', 'Indore', 49000.00, 7009, 'Manoj Singh', 'Support Engineer', 56000.00),
(110, '2012-08-25', 3010, 'Bhopal', 89, 3600.00, 5002, 'Bhopal', 210, 520.00, 1010, 99, 'Design', 'Bhopal', 53000.00, 7010, 'Priya Nair', 'Designer', 60000.00),
(111, '2012-08-26', 3001, 'Mumbai', 86, 2950.00, 5003, 'Mumbai', 211, 460.00, 1011, 90, 'HR', 'Mumbai', 50000.00, 7011, 'Ravi Kumar', 'Manager', 75000.00),
(112, '2012-08-27', 3002, 'Delhi', 92, 6200.00, 5004, 'Delhi', 212, 570.00, 1012, 91, 'Finance', 'Delhi', 60000.00, 7012, 'Anita Desai', 'Analyst', 65000.00),
(113, '2012-08-28', 3003, 'Chennai', NULL, 3100.00, 5005, 'Chennai', 213, 360.00, 1013, 92, 'IT', 'Chennai', 70000.00, 7013, 'Suresh Rao', 'Programmer', 55000.00),
(114, '2012-08-29', 3004, 'Kolkata', 90, 5800.00, 5006, 'Kolkata', 214, 410.00, 1014, 93, 'Sales', 'Kolkata', 45000.00, 7014, 'Meena Gupta', 'Sales Executive', 48000.00),
(115, '2012-08-30', 3005, 'Pune', NULL, 2100.00, 5007, 'Pune', 215, 620.00, 1015, 94, 'Marketing', 'Pune', 55000.00, 7015, 'Rajesh Sharma', 'Marketing Lead', 62000.00),
(116, '2012-09-01', 3006, 'Nagpur', 84, 3300.00, 5008, 'Nagpur', 216, 480.00, 1016, 95, 'Operations', 'Nagpur', 52000.00, 7016, 'Neha Joshi', 'Operations Lead', 63000.00),
(117, '2012-09-02', 3007, 'Jaipur', 93, 4200.00, 5009, 'Jaipur', 217, 515.00, 1017, 96, 'Legal', 'Jaipur', 48000.00, 7017, 'Amit Verma', 'Legal Advisor', 58000.00),
(118, '2012-09-03', 3008, 'Surat', NULL, 1950.00, 5010, 'Surat', 218, 395.00, 1018, 97, 'Admin', 'Surat', 47000.00, 7018, 'Kavita Mehta', 'Admin Officer', 51000.00),
(119, '2012-09-04', 3009, 'Indore', 88, 2800.00, 5001, 'Indore', 219, 435.00, 1019, 98, 'Support', 'Indore', 49000.00, 7019, 'Manoj Singh', 'Support Engineer', 56000.00),
(120, '2012-09-05', 3010, 'Bhopal', 90, 3700.00, 5002, 'Bhopal', 220, 525.00, 1020, 99, 'Design', 'Bhopal', 53000.00, 7020, 'Priya Nair', 'Designer', 60000.00),
(155, '2012-09-30', 3005, 'Pune', 85, 2600.00, 5007, 'Pune', 255, 610.00, 1055, 94, 'Marketing', 'Pune', 55000.00, 7055, 'Rajesh Sharma', 'Marketing Lead', 62000.00);



select sum(purchase_amount) as total_purch_amt 
from company_data;

select avg(purchase_amount) as avg_purch_amt 
from company_data;

select count(distinct salesperson_id) as no_of_salespeople 
from company_data;

select count(distinct customer_id) as no_of_customer 
from company_data;

select count(customer_id) from company_data 
where grade >= 1;

select max(purchase_amount) as max_purch_amt 
from company_data;

select min(purchase_amount) as min_purch_amt 
from company_data;

select customer_city, max(grade) as max_grade 
from company_data group by customer_city;

select customer_id, max(purchase_amount) as max_purch 
from company_data group by customer_id;

select order_date, max(purchase_amount) as max_purch 
from company_data group by order_date;

select salesperson_id, max(purchase_amount) as max_purch 
from company_data where order_date = "2012-08-17" 
group by salesperson_id;

select customer_id, order_date, max(purchase_amount) as max_purch
from company_data 
group by customer_id, order_date
having max_purch > 2000;

select customer_id, order_date, max(purchase_amount) as max_purch 
from company_data 
group by customer_id, order_date
having max_purch between 2000 and 6000;

select customer_id, order_date, max(purchase_amount) as max_purch 
from company_data 
group by customer_id, order_date
having max_purch in (2000, 3000, 5760, 6000);

select customer_id, max(purchase_amount) as max_purch 
from company_data 
where customer_id between 3002 and 3007
group by customer_id;

select customer_id, max(purchase_amount) as max_purch 
from company_data 
where customer_id between 3002 and 3007
group by customer_id
having max_purch > 1000;

select salesperson_id, max(purchase_amount) as max_purch 
from company_data 
where salesperson_id between 5003 and 5008
group by salesperson_id;

select count(order_id) as no_of_orders 
from company_data 
group by order_date
having order_date = "2012-08-17";

select salesperson_city, count(salesperson_id) as total_salesperson
from company_data
group by salesperson_city;

select order_date, salesperson_id, count(order_id) as total_orders
from company_data
group by order_date, salesperson_id;

select avg(product_price) as avg_product_price
from company_data;

select product_id, count(product_id) as no_of_product
from company_data
where product_price >= 350
group by product_id;

select company_id, avg(product_price) as avg_price 
from company_data
group by company_id;

select department_code, sum(allotment_amount) as total_allotment_price
from company_data
group by department_code;

select department_code, count(employee_id) as no_of_emp
from company_data
group by department_code;

select job_title, avg(salary) as avg_sal
from company_data
group by job_title;

select department_code, count(employee_id) as no_of_emp
from company_data
group by department_code;

select job_title, sum(salary) as total_salary
from company_data
group by job_title;

select location, max(salary) as max_sal
from company_data
group by location;

select location, count(employee_id) as no_of_emp
from company_data
group by location;

select department_name, job_title, count(employee_id) as no_of_emp
from company_data
group by department_name, job_title;

select job_title, count(employee_id) as no_of_emp
from company_data
group by job_title;

select department_name, avg(salary) as avg_sal
from company_data
group by department_name, job_title;

select department_name, location, count(employee_id) as no_of_emp
from company_data
group by department_name, location
having no_of_emp > 5;

select department_name, location, sum(salary) as total_sal
from company_data
group by department_name, location;