use wildcard_assgn;

# Q.1 to 5 - arithmetic
# Q.6 to 11 - wildcard_assgn tables - customer, orders, salesman

# Q.12 to 24
-- create a table
CREATE TABLE nobel_win (
  YEAR year,
  SUBJECT TEXT,
  WINNER TEXT,
  COUNTRY text,
  CATEGORY text
);
-- insert some values
INSERT INTO nobel_win VALUES 
(1970,'Physics','Hannes Alfven','Sweden','Scientist'),
(1970,'Physics','Louis Neel','France','Scientist'),
(1970,'Chemistry','Luis Federico Leloir','France','Scientist'),
(1970,'Physiology','Ulf von Euler','Sweden','Scientist'),
(1970,'Physiology','Bernard Katz','Germany','Scientist'),
(1970,'Literature','Aleksandr Solzhenitsyn','Russia','Linguist'),
(1970,'Economics','Paul Samuelson','USA','Economist'),
(1970,'Physiology','Julius Axelrod','USA','Scientist'),
(1971,'Physics','Dennis Gabor','Hungary','Scientist'),
(1971,'Chemistry','Gerhard Herzberg','Germany','Scientist'),
(1971,'Peace','Willy Brandt','Germany','Chancellor'),
(1971,'Literature','Pablo Neruda','Chile','Linguist'),
(1971,'Economics','Simon Kuznets','Russia','Economist'),
(1978,'Peace','Anwar al-Sadat','Egypt','President'),
(1978,'Peace','Menachem Begin','Israel','Prime Minister'),
(1987,'Chemistry','Donald J. Cram','USA','Scientist'),
(1987,'Chemistry','Jean-Marie Lehn','France','Scientist'),
(1987,'Physiology','Susumu Tonegawa','Japan','Scientist'),
(1994,'Economics','Reinhard Selten','Germany','Economist'),
(1994,'Peace','Yitzhak Rabin','Israel','Prime Minister'),
(1987,'Physics','Johannes Georg Bednorz','Germany','Scientist'),
(1987,'Literature','Joseph Brodsky','Russia','Linguist'),
(1987,'Economics','Robert Solow','USA','Economist'),
(1994,'Literature','Kenzaburo Oe','Japan','Linguist');

# Q. 25 to 30
-- create table item_mast
CREATE TABLE item_mast (
  PRO_ID  int,
  PRO_NAME TEXT,
  PRO_PRICE int,
  PRO_COM int
);
-- insert some values
INSERT INTO item_mast VALUES 
(101,'Mother Board',3200,15),
(102,'Key Board',450,16),
(103,'ZIP drive',250,14),
(104,'Speaker',550,16),
(105,'Monitor',5000,11),
(106,'DVD drive',900,12),
(107,'CD drive',800,12),
(108,'Printer',2600,13),
(109,'Refill cartridge',350,13),
(110,'Mouse',250,12);

-- create table company_mast
CREATE TABLE company_mast (
  COM_ID int,
  COM_NAME TEXT
);

-- insert some values
INSERT INTO company_mast VALUES
(11, 'Samsung'),
(12, 'iBall'),
(13, 'Epson'),
(14, 'Zebronics'),
(15, 'Asus'),
(16, 'HP');

-- create table manufacturer
CREATE TABLE manufacturer (
  MAN_ID int,
  MAN_NAME TEXT
);

-- insert some values
INSERT INTO manufacturer VALUES
(11, 'Samsung Electronics'),
(12, 'iBall India'),
(13, 'Epson Corp'),
(14, 'Zebronics Pvt Ltd'),
(15, 'Asus Inc'),
(16, 'HP Global');

# Q.31 to 33 
-- create a table
CREATE TABLE emp_details (
  EMP_IDNO int,
  EMP_FNAME TEXT,
  EMP_LNAME TEXT,
  EMP_DEPT int
);
-- insert some values
INSERT INTO emp_details VALUES 
(127323,'Michale','Robbin',57),
(526689,'Carlos','Snares',63),
(843795,'Enric','Dosio',57),
(328717,'Jhon','Snares',63),
(444527,'Joseph','Dosni',47),
(659831,'Zanifer','Emily',47),
(847674,'Kuleswar','Sitaraman',57),
(748681,'Henrey','Gabriel',47),
(555935,'Alex','Manuel',57),
(539569,'George','Mardy',27),
(733843,'Mario','Saule',63),
(631548,'Alan','Snappy',27),
(839139,'Maria','Foster',57);


-- ----------------------------------------------------------------------------------------------------------------


select * from salesman;

select "This is Exercise, Practice and Solution" as msg;

select "1" as no, "2" as num, "3" as number;

select 10+15 as sum;

select 10+15-5*2;

select name, commission from salesman;

select ord_date, salesman_id, ord_no, purch_amt from orders;

select distinct salesman_id from salesman;

select name, city from salesman where city = "Paris";

select * from customer;

select ord_no, ord_date, purch_amt from orders where salesman_id = 5001;

select year, subject, winner from nobel_win where year = 1970;

select winner from nobel_win where year = 1970 and subject = "Literature";

select year, subject from nobel_win where winner = "Dennis Gabor";

select winner from nobel_win where year >= 1950 and subject = "Physics";

select year, subject, winner, year from nobel_win where year between 1965 and 1975 and subject = "Chemistry";

select * from nobel_win where category = "Prime Minister" and year = 1972 and winner in ("Menachem Begin", "Yitzhak Rabin");

select * from nobel_win where winner like "Louis%";

select * from nobel_win where subject = "Physics" and year = 1970
union
select * from nobel_win where subject = "Chemistry" and year = 1971;

select * from nobel_win where year = 1970 and subject != "Physiology" and subject != "Economics";

select * from nobel_win where (subject = "Physiology" and year < 1971)
union
select * from nobel_win where (subject = "Peace" and year >= 1974);

select * from nobel_win where winner = "Johannes Georg Bednorz";

select * from nobel_win where subject not like "P%"
order by year desc, winner asc;

select * from nobel_win where year = 1970
order by case
when subject in ("Chemistry", "Economics") then 1 else 0
end asc,
subject, winner;

select * from item_mast where pro_price between 200 and 600;

select avg(pro_price) from item_mast
join manufacturer on pro_com = man_id;

select pro_name as "Item Name", pro_price as "Price in Rs." from item_mast;

select pro_name, pro_price from item_mast where pro_price >= 250
order by pro_price desc, pro_name asc;

select com_id, avg(pro_price) from item_mast
join company_mast on pro_com = com_id
group by com_id order by com_id asc;

select pro_name, pro_price from item_mast where pro_price = (select min(pro_price) from item_mast);

select distinct emp_lname from emp_details;

select * from emp_details where emp_lname = "Snares";

select * from emp_details where emp_dept = 57;

select * from customer where grade > 100;

select * from customer where city = "New York" and grade > 100;

select * from customer where city = "New York" or grade > 100;

select * from customer where city = "New York" or grade < 100;

select * from customer where city != "New York" or grade > 100;

select * from orders where (ord_date = "2012-09-10" and salesman_id > 5005) or purch_amt > 1000;

select * from salesman where commission between 0.10 and 0.12;

select * from orders where (purch_amt < 200 or not (ord_date >= "2012-02-10" and customer_id < 3009));

select * from orders where not ((ord_date = 2012-08-17 or customer_id > 3005) and purch_amt < 1000);

select ord_no, purch_amt, (100*purch_amt)/6000 as "Achieved %",
(100*(6000-purch_amt)/6000) as "Unachieved %" from orders
where (100*purch_amt)/6000 > 50;

select * from emp_details where emp_lname = "Dosni" or emp_lname = "Mardy";

select * from emp_details where emp_dept = 47 or emp_dept = 63;