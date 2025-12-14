create database wildcard_assgn;
use wildcard_assgn;

-- Salesman Table
CREATE TABLE salesman (
  salesman_id INT PRIMARY KEY,
  name VARCHAR(50),
  city VARCHAR(50),
  commission DECIMAL(4,2)
);

-- Customer Table
CREATE TABLE customer (
  customer_id INT PRIMARY KEY,
  cust_name VARCHAR(50),
  city VARCHAR(50),
  grade INT,
  salesman_id INT,
  FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

-- Orders Table
CREATE TABLE orders (
  ord_no INT PRIMARY KEY,
  purch_amt DECIMAL(10,2),
  ord_date DATE,
  customer_id INT,
  salesman_id INT,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

-- Generic Table for col1 pattern matching
CREATE TABLE test_patterns (
  col1 VARCHAR(100)
);

-- Employee Table
CREATE TABLE employee (
  emp_idno INT PRIMARY KEY,
  emp_fname VARCHAR(50),
  emp_lname VARCHAR(50),
  emp_dept VARCHAR(50)
);

-- Salesman Data
INSERT INTO salesman VALUES
(5001, 'James', 'Paris', 0.13),
(5002, 'Nail', 'London', 0.12),
(5003, 'Pit', 'Rome', 0.14),
(5004, 'Paul', 'New York', 0.11),
(5005, 'Karl', 'Paris', 0.15);

-- Customer Data
INSERT INTO customer VALUES
(3001, 'Brad', 'New York', 200, 5001),
(3002, 'Alex', 'London', NULL, 5002),
(3003, 'Brenda', 'Paris', 300, 5001),
(3004, 'Chloe', 'Rome', 100, 5003),
(3005, 'Brian', 'Paris', NULL, 5005),
(3006, 'Nina', 'London', 250, 5002),
(3007, 'Tom', 'Rome', 150, 5003),
(3008, 'Jerry', 'Paris', 200, 5001),
(3009, 'Ben', 'New York', NULL, 5004);

-- Orders Data
INSERT INTO orders VALUES
(7001, 1500.00, '2023-01-10', 3001, 5001),
(7002, 948.50, '2023-01-15', 3003, 5001),
(7003, 1983.43, '2023-02-05', 3004, 5003),
(7004, 2500.00, '2023-02-20', 3007, 5003),
(7005, 500.00, '2023-03-01', 3008, 5001),
(7006, 4000.00, '2023-03-15', 3009, 5004);

-- Test Patterns Data
INSERT INTO test_patterns VALUES
('abc_def'),
('xyz/_test'),
('hello/world'),
('plainstring'),
('value%percent'),
('no_specials');

-- Employee Data
INSERT INTO employee VALUES
(101, 'Nancy', 'Davolio', 'Sales'),
(102, 'Andrew', 'Fuller', 'Marketing'),
(103, 'Janet', 'Leverling', 'IT'),
(104, 'Margaret', 'Peacock', 'HR'),
(105, 'Daniel', 'Davis', 'Finance');










select * from salesman where city in ("Paris", "Rome");

select * from salesman where city = "Paris" or city = "Rome";

select * from salesman where city not in ("Paris", "Rome");

select * from customer where customer_id in (3007, 3008, 3009);

select * from salesman where commission between 0.12 and 0.14;

select * from orders where (purch_amt between 500 and 4000) and not (purch_amt between 948.50 and 1983.43);

select * from salesman where left(name, 1) > "A" and left(name, 1) < "L";

select * from salesman where left(name, 1) < "A" or left(name, 1) > "L";

select * from customer where left(cust_name, 1) like "B%";

select * from customer where right(cust_name, 1) like "%n";

select * from salesman where name like "N__l%";

select * from test_patterns where col1 like "%\_%";

select * from test_patterns where col1 not like "%\_%";

select * from test_patterns where col1 like "%/%";

select * from test_patterns where col1 not like "%/%";

select * from test_patterns where col1 like "%\_/%";

select * from test_patterns where col1 not like "%\_/%";

select * from test_patterns where col1 like "%\%%";

select * from test_patterns where col1 not like "%\%%";

select * from customer where grade is null;

select * from customer where grade is not null;

select * from employee where emp_lname like "D%";