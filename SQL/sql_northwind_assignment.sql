-- Subqueries
-- 1.	Find all products that are more expensive than the average unit price.
select product_name, unit_price from products where unit_price > 
(select avg(unit_price) from products);

-- 2.	List customers who have never placed any orders.
select customer_id, company_name from customers where customer_id not in
(select customer_id from orders);

-- 3.	Retrieve employees who do not supervise anyone.
select employee_id, concat(first_name, " ", last_name) as full_name
from employees where employee_id not in (select reports_to from employees
where reports_to is not null);

-- 4.	Find the suppliers who supply the maximum number of products.
select supplier_id, company_name from suppliers where supplier_id in 
(select supplier_id from products group by supplier_id having count(*) = 
(select max(prod_count) from (select supplier_id, count(*) as prod_count
from products group by supplier_id) as sub));

-- 5.	List product names and prices where the price is higher than any product in category 'Beverages'.
select product_name, unit_price from products where unit_price >
(select max(unit_price) from products where category_id = 
(select category_id from categories where category_name = "Beverages"));

-- 6.	Find employees whose birth dates are earlier than the oldest employee in the 'Sales' title.
select employee_id, concat(first_name, " ", last_name) as full_name from employees
where birth_date < (select min(birth_date) from employees where title like "%Sales%");

-- 7.	List customers whose country has more than 3 customers.
select customer_id, country from customers where country in
(select country from customers group by country having count(*) > 3);

-- 8.	Find products that have never been ordered.
select product_id, product_name from products where product_id not in 
(select product_id from order_details);

-- 9.	Get the order ID and freight of the most expensive (highest freight) order.
select order_id, freight from orders where freight = (select max(freight) from orders);

-- 10.	Retrieve names of employees who have the same city as their supervisor.
select e.employee_id, concat(first_name, " ", last_name) as full_name from employees e
where city = (select city from employees m where e.reports_to = m.employee_id);

-- 11.	List employees whose hire date is the most recent.
select concat(first_name, " ", last_name) as full_name from employees
where hire_date = (select max(hire_date) from employees);

-- 12.	Find all products supplied by suppliers located in the same city as 'Exotic Liquids'.
select product_id, product_name, supplier_id from products 
where supplier_id = (select supplier_id from suppliers 
where city = (select city from suppliers 
where company_name = "Exotic Liquids"));

-- 13.	Display the names of customers who ordered products from more than 3 categories.
select company_name from customers
where customer_id in (select o.customer_id
from orders o
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
group by o.customer_id
having count(distinct p.category_id) > 3
);

-- 14.	Retrieve names of employees who handled orders only in the year 1997.
select concat(first_name, " ", last_name) as full_name from employees
where employee_id in (select employee_id from orders 
group by employee_id
having min(year(order_date)) = 1997 and max(year(order_date)) = 1997);

-- 15.	List products with a price higher than all products from category ID 1.
select product_name, unit_price from products where unit_price > 
(select max(unit_price) from products where category_id = 1);

-- 16.	Find all orders where the freight is greater than the average freight for all orders.
select * from orders
where freight > (select avg(freight) from orders);

-- 17.	Get the product(s) that are ordered most frequently.
select product_id, product_name
from products where product_id in (
select product_id from order_details
group by product_id
having count(*) = (select max(order_count)
from (select product_id, count(*) as order_count
from order_details
group by product_id) as sub));

-- 18.	List the name of the supplier(s) who provide the most expensive product.
select supplier_id, company_name
from suppliers where supplier_id in 
(select supplier_id from products
where unit_price = (select max(unit_price) 
from products));

-- 19.	Find customers who have placed an order using every shipper available.
select customer_id, company_name from customers
where customer_id in (select customer_id from orders
group by customer_id
having count(distinct ship_via) = (
select count(*) from shippers));

-- 20.	Retrieve employees whose region is not shared by any other employee.
select employee_id, first_name, last_name, region
from employees where region is not null
and region in (select region from employees
group by region
having count(*) = 1);

-- 21.	List all products where the unit price equals the highest price in their category.
select product_id, product_name, category_id, unit_price
from products
where unit_price = (select max(unit_price)
from products as p2
where p2.category_id = products.category_id);

-- 22.	Find customers whose total order value is higher than the average customer’s total.
select customer_id, company_name from customers
where customer_id in (select customer_id from orders o
join order_details od on o.order_id = od.order_id
group by customer_id
having sum(od.unit_price * od.quantity) > (
select avg(total_value)
from (select customer_id, 
sum(od.unit_price * od.quantity) as total_value
from orders o
join order_details od on o.order_id = od.order_id
group by customer_id) as sub));

-- 23.	Show the product(s) with the minimum unit price per category.
select product_id, product_name, category_id, unit_price
from products
where unit_price = (select min(unit_price)
from products as p2
where p2.category_id = products.category_id);

-- 24.	Find all employees who have not placed any orders.
select employee_id, first_name, last_name from employees
where employee_id not in (
select distinct employee_id from orders);

-- 25.	Retrieve the orders that contain more than 2 products.
select order_id from order_details
group by order_id
having count(distinct product_id) > 2;





# Joins
-- 1.	List all orders with customer names and shipper names.
select c.company_name as customer_name, s.company_name as shipper_name
from orders o
join customers c on o.customer_id = c.customer_id
join shippers s on o.ship_via = s.shipper_id;

-- 2.	Display product names along with their category and supplier names.
select product_name, category_name, company_name from products p
join categories c on p.category_id = c.category_id
join suppliers s on p.supplier_id = s.supplier_id;

-- 3.	Get a list of all orders along with employee and customer contact names.
select concat(first_name, " ", last_name) as employee_name, contact_name 
from orders o
join employees e on o.employee_id = e.employee_id
join customers c on o.customer_id = c.customer_id;

-- 4.	List all products that belong to a category and are supplied by a supplier in the same city as customer.
select p.product_name, c.category_name, s.company_name
from products p
join categories c on p.category_id = c.category_id 
join suppliers s on p.supplier_id = s.supplier_id
join order_details od on p.product_id = od.product_id
join orders o on od.order_id = o.order_id
join customers cs on o.customer_id = cs.customer_id
where s.city = cs.city;

-- 5.	Get employee names along with the territory descriptions they manage.
select concat(first_name, " ", last_name) as full_name, territory_description 
from employees e
join employee_territories et on e.employee_id = et.employee_id
join territories t on et.territory_id = t.territory_id;

-- 6.	Retrieve order details (quantity, discount, unit price) along with product name.
select product_name, od.quantity, od.discount, od.unit_price from products p
join order_details od on p.product_id = od.product_id;

-- 7.	Find all customers with their order count.
select c.customer_id, count(*) as order_count
from customers c
join orders o on c.customer_id = o.customer_id
group by customer_id;

-- 8.	Show each employee and the name of their supervisor.
select concat(e.first_name, " ", e.last_name) as employee_name, 
concat(s.first_name, " ", s.last_name) as supervisor_name
from employees e
join employees s on e.reports_to = s.employee_id; 

-- 9.	List all orders with shipment city and the employee's city.
select order_id, ship_city, e.employee_id, e.city
from orders o
join employees e on o.employee_id = e.employee_id;

-- 10.	Show each order with the total value (unit_price * quantity).
select o.order_id, sum(unit_price*quantity) as total_value from orders o
join order_details od on o.order_id = od.order_id
group by o.order_id;

-- 11.	List suppliers and the number of products they supply.
select company_name, count(product_id) as no_of_product from suppliers s
join products p on s.supplier_id = p.supplier_id
group by company_name;

-- 12.	Show all products that have never been ordered.
select p.product_id, product_name from products p 
left join order_details od on p.product_id = od.product_id
where od.product_id is null;

-- 13.	Find all customers who have ordered products supplied by 'Tokyo Traders'.
select c.customer_id, c.company_name from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
join suppliers s on p.supplier_id = s.supplier_id
where s.company_name = "Tokyo Traders";

-- 14.	Get a list of employees and the regions they are assigned to.
select concat(first_name, " ", last_name) as full_name, region_description 
from employees e
join employee_territories et on e.employee_id = et.employee_id
join territories t on et.territory_id = t.territory_id
join region r on t.region_id = r.region_id
group by e.employee_id, region_description;

-- 15.	Retrieve products that were ordered more than 50 times.
select product_name from products p
join order_details od on p.product_id = od.product_id
group by product_name
having count(*) > 50;

-- 16.	Find all orders that contain products in the 'Confections' category.
select order_id from order_details od
join products p on od.product_id = p.product_id
join categories c on p.category_id = c.category_id
where category_name = "Confections";

-- 17.	Show customers and the total number of distinct products they ordered.
select c.customer_id, c.company_name, count(distinct product_name) as no_of_distinct_products 
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
group by c.customer_id, c.company_name;

-- 18.	Find products along with the number of times they were ordered.
select product_name, count(order_id) as no_of_times_ordered from products p
join order_details od on p.product_id = od.product_id
group by product_name;

-- 19.	List all employee names with the number of orders they handled.
select concat(first_name, " ", last_name) as full_name, count(order_id) as no_of_orders_handled 
from employees e
join orders o on e.employee_id = o.employee_id
group by e.employee_id;

-- 20.	Get all regions and the number of employees assigned there.
select r.region_id, r.region_description, count(et.employee_id) as no_of_employee
from region r
left join territories t on r.region_id = t.region_id
left join employee_territories et on t.territory_id = et.territory_id
group by r.region_id;

-- 21.	Show orders along with shipper phone numbers.
select order_id, phone from orders o
join shippers s on o.ship_via = s.shipper_id;

-- 22.	Display each customer along with their most recent order date.
select c.customer_id, c.company_name from customers c
join orders o on c.customer_id = o.customer_id
where order_date between date_sub(curdate(), interval 1 month) and curdate();

-- 23.	Get the list of all categories with the count of products in each.
select category_name, count(product_name) as count_of_product from categories c
join products p on c.category_id = p.category_id
group by category_name;

-- 24.	List territories that are shared by more than one employee.
select territory_description, count(e.employee_id) as no_of_emp
from employees e
join employee_territories et on e.employee_id = et.employee_id
join territories t on et.territory_id = t.territory_id
group by territory_description
having count(e.employee_id) > 1;

-- 25.	Get employees who share the same territory as 'Nancy Davolio'.
select concat(first_name, " ", last_name) as full_name
from employees e
join employee_territories et on e.employee_id = et.employee_id
where et.territory_id in (
select et.territory_id
from employees e
join employee_territories et on e.employee_id = et.employee_id
where e.first_name = "Nancy" and e.last_name = "Davolio")
and concat(first_name, " ", last_name) != "Nancy Davolio";





# Rank
-- 1.	Rank products within each category based on unit price (highest first).
select product_id, product_name, category_id, unit_price,
rank() over (partition by category_id order by unit_price desc) as price_rank
from products;

-- 2.	Display top 3 most expensive products per category.
select * from (select product_id, product_name, category_id, unit_price,
rank() over (partition by category_id order by unit_price desc) as rank_in_category
from products
) as ranked
where rank_in_category <= 3;

-- 3.	Show rank of each employee based on number of orders handled.
select employee_id, count(order_id) as order_count,
rank() over (order by count(order_id) desc) as order_rank
from orders
group by employee_id;

-- 4.	List orders ranked by freight within each customer.
select order_id, customer_id, freight,
rank() over (partition by customer_id order by freight desc) as freight_rank
from orders;

-- 5.	Rank suppliers based on total products they supply.
select supplier_id, count(product_id) as product_count,
rank() over (order by count(product_id) desc) as supplier_rank
from products
group by supplier_id;

-- 6.	Densely rank customers based on total order amount.
select customer_id, sum(od.unit_price * od.quantity) as total_value,
dense_rank() over (order by sum(od.unit_price * od.quantity) desc) as value_rank
from orders o
join order_details od on o.order_id = od.order_id
group by customer_id;

-- 7.	Rank employees based on their total sales value.
select employee_id, sum(od.unit_price * od.quantity) as total_sales,
rank() over (order by sum(od.unit_price * od.quantity) desc) as sales_rank
from orders o
join order_details od on o.order_id = od.order_id
group by employee_id;

-- 8.	Show customers and their order count ranking within their country.
select c.customer_id, country, count(order_id) as order_count,
rank() over (partition by country order by count(order_id) desc) as country_rank
from customers c
join orders o on c.customer_id = o.customer_id
group by customer_id, country;

-- 9.	Display orders ranked by total value (unit_price * quantity).
select o.order_id, sum(od.unit_price * od.quantity) as order_value,
rank() over (order by sum(od.unit_price * od.quantity) desc) as value_rank
from orders o
join order_details od on o.order_id = od.order_id
group by o.order_id;

-- 10.	Get the rank of each product by frequency of orders.
select product_id, count(order_id) as order_count,
rank() over (order by count(order_id) desc) as frequency_rank
from order_details
group by product_id;

-- 11.	Rank employees based on how early they joined.
select employee_id, first_name, hire_date,
rank() over (order by hire_date asc) as seniority_rank
from employees;

-- 12.	Show products with rank based on quantity in stock.
select product_id, product_name, units_in_stock,
rank() over (order by units_in_stock desc) as stock_rank
from products;

-- 13.	Display top 5 customers with highest total order values.
select * from (select customer_id, sum(od.unit_price * od.quantity) as total_value,
rank() over (order by sum(od.unit_price * od.quantity) desc) as value_rank
from orders o
join order_details od on o.order_id = od.order_id
group by customer_id) as ranked
where value_rank <= 5;

-- 14.	Get the dense rank of each category based on number of products.
select category_id, count(product_id) as product_count,
dense_rank() over (order by count(product_id) desc) as category_rank
from products
group by category_id;

-- 15.	Rank shippers by number of orders shipped.
select ship_via, count(order_id) as order_count,
rank() over (order by count(order_id) desc) as shipper_rank
from orders
group by ship_via;

-- 16.	Show the product order ranking per supplier.
select supplier_id, p.product_id, count(order_id) as order_count,
rank() over (partition by supplier_id order by count(order_id) desc) as product_rank
from products p
join order_details od on p.product_id = od.product_id
group by supplier_id, product_id;

-- 17.	Densely rank employees by number of territories they handle.
select employee_id, count(territory_id) as territory_count,
dense_rank() over (order by count(territory_id) desc) as territory_rank
from employee_territories
group by employee_id;

-- 18.	Get a rank list of orders placed per month in 1997.
select order_id, month(order_date) as month, year(order_date) as year,
rank() over (partition by month(order_date) order by order_date) as monthly_rank
from orders
where year(order_date) = 1997;

-- 19.	Rank employees based on how many categories of products they sold.
select employee_id, count(distinct p.category_id) as category_count,
rank() over (order by count(distinct p.category_id) desc) as category_rank
from orders o
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
group by employee_id;

-- 20.	Rank products based on the average discount they receive.
select product_id, avg(discount) as avg_discount,
rank() over (order by avg(discount) desc) as discount_rank
from order_details
group by product_id;

-- 21.	Rank countries based on number of customers.
select country, count(customer_id) as customer_count,
rank() over (order by count(customer_id) desc) as country_rank
from customers
group by country;

-- 22.	Rank regions based on number of territories.
select region_id, count(territory_id) as territory_count,
rank() over (order by count(territory_id) desc) as region_rank
from territories
group by region_id;

-- 23.	Rank employees within their region by order count.
select e.employee_id, e.region, count(o.order_id) as order_count,
rank() over (partition by e.region order by count(o.order_id) desc) as regional_rank
from employees e
join orders o on e.employee_id = o.employee_id
group by e.employee_id, e.region;

-- 24.	Get dense rank of products by total revenue generated.
select product_id, sum(unit_price * quantity) as revenue,
dense_rank() over (order by sum(unit_price * quantity) desc) as revenue_rank
from order_details
group by product_id;

-- 25.	Rank cities by total number of orders placed.
select ship_city, count(order_id) as order_count,
rank() over (order by count(order_id) desc) as city_rank
from orders
group by ship_city;





# CTE
-- 1.	Use a CTE to list the top 5 customers by total order value.
with top_five as
(
select c.customer_id, c.company_name, o.order_id, (unit_price*quantity) as total_value
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
order by total_value desc
limit 5
)
select * from top_five;

-- 2.	Create a CTE that calculates total revenue per product.
with total_rev as
(
select p.product_id, p.product_name, sum((1-od.discount)*(od.unit_price*od.quantity)) as total_revenue
from products p
join order_details od on p.product_id = od.product_id
group by product_id, product_name
)
select * from total_rev;

-- 3.	Find all products with stock below reorder level using a CTE.
with stock_level as
(
select product_id, product_name from products
where units_in_stock < reorder_level
)
select * from stock_level;

-- 4.	Use a CTE to list employees and number of territories.
with emp_ter as
(
select concat(first_name, " ", last_name) as emp_name, count(et.territory_id) as no_of_territory
from employees e
join employee_territories et on e.employee_id = et.employee_id
group by e.employee_id
)
select * from emp_ter;

-- 5.	Write a CTE to get orders with more than 3 products.
with more_than_3_pro as
(
select order_id, count(*) as no_of_products from order_details
group by order_id
having no_of_products > 3
)
select * from more_than_3_pro;

-- 6.	Create a recursive CTE to get employee-manager hierarchy.
with recursive emp_man as
(
select employee_id, reports_to, concat(first_name, " ", last_name) as emp_name, 1 as level
from employees
where reports_to is null

union all

select e.employee_id, e.reports_to, concat(e.first_name, " ", e.last_name) as emp_name, em.level+1
from employees e
join emp_man em on e.reports_to = em.employee_id
)
select * from emp_man;

-- 7.	Use a CTE to show customers who placed their first order in 1997.
with first_order as
(
select c.customer_id, c.company_name from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.company_name
having min(year(order_date)) = 1997
)
select * from first_order;

-- 8.	CTE that calculates average unit price per category.
with avg_price_cat as
(
select category_name, avg(unit_price) from products p
join categories c on p.category_id = c.category_id
group by category_name
)
select * from avg_price_cat;

-- 9.	Use a CTE to find orders where all products had discounts.
with ord_dis as
(
select order_id, count(*) as total_products,
sum(case when discount > 0 then 1 else 0 end) as discount_product
from order_details
group by order_id
)
select order_id from ord_dis
where total_products = discount_product;

-- 10.	Create a CTE to find the second most expensive product per category.
with exp_pro as
(
select category_name, product_id, product_name, unit_price,
dense_rank() over(partition by category_name order by unit_price desc) as exp_rank
from products p
join categories c on p.category_id = c.category_id
)
select * from exp_pro where exp_rank = 2;

-- 11.	Use a CTE to count how many products each supplier supplies.
with no_prod as
(
select supplier_id, count(product_id) as no_of_products
from products group by supplier_id
)
select * from no_prod;

-- 12.	CTE to find the order with the highest value per customer.
with order_totals as (
select o.order_id, o.customer_id, sum(od.unit_price * od.quantity) as total_value
from orders o join order_details od on o.order_id = od.order_id
group by o.order_id, o.customer_id
order by total_value desc
limit 1
)
select customer_id, order_id, total_value
from order_totals;

-- 13.	Use CTE to get top 3 highest-selling products by total sales.
with high_sell_products as
(
select product_id, sum((1-discount)*(unit_price*quantity)) as total_sales
from order_details 
group by product_id
order by total_sales desc
limit 3
)
select * from high_sell_products;

-- 14.	Use CTE to get product name and number of orders it appears in.
with product_orders as (
select product_id, count(distinct order_id) as order_count
from order_details
group by product_id
)
select p.product_name, po.order_count
from products p
join product_orders po on p.product_id = po.product_id;

-- 15.	Write a CTE to get total freight cost per month.
with monthly_freight as (
select month(order_date) as month, year(order_date) as year,
sum(freight) as total_freight
from orders
group by year(order_date), month(order_date)
)
select * from monthly_freight;

-- 16.	Use a CTE to get all employees who report directly or indirectly to someone.
with reporting_chain as (
select employee_id, reports_to
from employees
where reports_to is not null
)
select * from reporting_chain;

-- 17.	CTE to show total quantity sold per category.
with category_sales as (
select c.category_id, c.category_name, sum(od.quantity) as total_quantity
from order_details od
join products p on od.product_id = p.product_id
join categories c on p.category_id = c.category_id
group by c.category_id, c.category_name
)
select * from category_sales;

-- 18.	Create a CTE to rank customers by average freight per order.
with customer_avg_freight as (
    select customer_id, avg(freight) as avg_freight
    from orders
    group by customer_id
)
select customer_id, avg_freight,
rank() over (order by avg_freight desc) as freight_rank
from customer_avg_freight;

-- 19.	CTE to filter products that are both above average in price and below average in stock.
with stats as (
select avg(unit_price) as avg_price, avg(units_in_stock) as avg_stock
from products
)
select p.product_name, p.unit_price, p.units_in_stock
from products p, stats
where p.unit_price > stats.avg_price and p.units_in_stock < stats.avg_stock;

-- 20.	Use CTE to get average order value per shipper.
with order_totals as (
select o.order_id, o.ship_via, sum(od.unit_price * od.quantity) as order_value
from orders o
join order_details od on o.order_id = od.order_id
group by o.order_id, o.ship_via
)
select ship_via, avg(order_value) as avg_order_value
from order_totals
group by ship_via;

-- 21.	CTE to get employee count per region.
with region_emps as (
select region, count(*) as emp_count
from employees
where region is not null
group by region
)
select * from region_emps;

-- 22.	CTE to find customers with more than 2 orders in the same month.
with monthly_orders as (
select customer_id, month(order_date) as month, year(order_date) as year,
count(*) as order_count
from orders
group by customer_id, year(order_date), month(order_date)
)
select customer_id, month, year, order_count
from monthly_orders
where order_count > 2;

-- 23.	Use CTE to get categories that have never been used in any order.
with used_categories as (
select distinct p.category_id
from order_details od
join products p on od.product_id = p.product_id
),
unused_categories as (
select category_id, category_name
from categories
where category_id not in (select category_id from used_categories)
)
select * from unused_categories;

-- 24.	CTE to find customers who order every month in 1997.
with monthly_orders_1997 as (
select customer_id, month(order_date) as month
from orders
where year(order_date) = 1997
group by customer_id, month(order_date)
),
monthly_counts as (
select customer_id, count(distinct month) as active_months
from monthly_orders_1997
group by customer_id
)
select customer_id
from monthly_counts
where active_months = 12;

-- 25.	CTE to show each order ID and count of distinct categories in that order.
with order_category_count as (
select od.order_id, count(distinct p.category_id) as category_count
from order_details od
join products p on od.product_id = p.product_id
group by od.order_id
)
select * from order_category_count;
