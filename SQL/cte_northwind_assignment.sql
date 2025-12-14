use northwind;

-- 1
with product_catalog as
(
select product_id, product_name, company_name as supplier, 
category_name, unit_price, discontinued
from products p
left join suppliers s on p.supplier_id = s.supplier_id
left join categories c on p.category_id = c.category_id
order by category_name, supplier, product_name
)
select * from product_catalog;

-- 2
with orphan_data as
(
select product_id, product_name, s.supplier_id, c.category_id
from products p
left join suppliers s on p.supplier_id = s.supplier_id
left join categories c on p.category_id = c.category_id
)
select *,
case 
when supplier_id is null then 0
else 1
end as supplier_exists_flag, 
case 
when category_id is null then 0
else 1
end as category_exists_flag
from orphan_data;

-- 3
with detail_totals as
(
select order_id, sum(unit_price*quantity*(1-discount)) as line_total
from order_details
group by order_id
)
select t.order_id, order_date, customer_id, employee_id, freight,
coalesce(line_total, 0) as merchandise_total, 
(freight+line_total) as grand_total 
from detail_totals t
join orders o on t.order_id = o.order_id;

-- 4
with prod_rev as
(
select p.category_id, od.product_id,
sum((od.unit_price*quantity)-(discount*od.unit_price*quantity))
as revenue
from order_details od
join products p on od.product_id = p.product_id
group by p.category_id, od.product_id
), 
rank_prod as
(
select c.category_name, pr.product_id, p.product_name, pr.revenue,
dense_rank() over(partition by p.category_id order by pr.revenue desc)
as rank_in_category
from prod_rev as pr
join products p on pr.product_id = p.product_id
join categories c on p.category_id = c.category_id
)
select category_name, rank_in_category, product_id, 
product_name, revenue
from rank_prod
where rank_in_category <= 3;

-- 5
with ship_lag as
(
select order_id, customer_id, ship_via, datediff(shipped_date, required_date)
as late_days from orders
where shipped_date > required_date
order by late_days desc
)
select * from ship_lag;

-- 6
with freight_ship as
(
select ship_via, company_name as shipper, sum(freight) as shipper_freight
from orders o
join shippers s on o.ship_via = s.shipper_id
group by ship_via, company_name
)
select shipper, shipper_freight,
shipper_freight*100 / sum(shipper_freight) over() as pct_of_all 
from freight_ship;


-- 7

-- 8
with emp_territories as
(
select e.employee_id, concat(first_name, " ", last_name) as employee_name,
count(t.territory_id) as territory_count, 
group_concat(territory_description order by territory_description separator ', ') as territort_list,
count(distinct region_description) as distinct_regions_covered
from employees e
left join employee_territories et on e.employee_id = et.employee_id
left join territories t on et.territory_id = t.territory_id
left join region r on t.region_id = r.region_id
group by e.employee_id
) 
select * from emp_territories;

-- 9
with us_emp as (
select e.employee_id, concat(e.first_name, ' ', e.last_name) as name,
e.city, upper(trim(e.region)) as region_code, e.postal_code
from employees e
where upper(trim(e.country)) in ('USA', 'US')
)
select *, s.state_name as matched_state_name,
case when s.state_abbr is not null then 'match' 
else 'no match' 
end as match_flag
from us_emp ue
left join us_states s on ue.region_code = upper(trim(s.state_abbr));

-- 10
with stock as (
select p.product_id, p.product_name,
coalesce(p.units_in_stock, 0) + coalesce(p.units_on_order, 0) as on_hand,
coalesce(p.reorder_level, 0) as reorder_level,
p.supplier_id, p.category_id
from products p
)
select s.company_name as supplier, c.category_name as category,
st.product_id, st.product_name,
st.on_hand, st.reorder_level
from stock st
join suppliers s on st.supplier_id = s.supplier_id
join categories c on st.category_id = c.category_id
where st.on_hand <= st.reorder_level
order by st.on_hand asc;

-- 11

-- 12
with cust_orders as (
select o.customer_id, c.company_name,
min(o.order_date) as first_order_date
from orders o
join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.company_name
),
bucketed as (
select customer_id, company_name, first_order_date,
timestampdiff(day, '1996-06-01', first_order_date) as days_since_anchor,
case 
when timestampdiff(day, '1996-06-01', first_order_date) > 0 
and timestampdiff(day, '1996-06-01', first_order_date) < 30 then '<30d'
when timestampdiff(day, '1996-06-01', first_order_date) >= 30
and timestampdiff(day, '1996-06-01', first_order_date) < 60 then '30–60d'
when timestampdiff(day, '1996-06-01', first_order_date) >= 60
and timestampdiff(day, '1996-06-01', first_order_date) < 90 then '60–90d'
else '90d+'
end as bucket
from cust_orders
)
select * from bucketed;

-- 13
with cust_rev as (
select c.country, c.customer_id,
c.company_name, sum(od.unit_price * od.quantity * (1 - od.discount)) as revenue
from orders o
join order_details od on o.order_id = od.order_id
join customers c on o.customer_id = c.customer_id
group by c.country, c.customer_id, c.company_name
),
ranked as (
select *,
dense_rank() over (partition by country order by revenue desc) as rank_in_country
from cust_rev
)
select * from ranked
where rank_in_country = 1
order by country;

-- 14
with order_revenue as (
select o.order_id,
sum(od.unit_price * od.quantity * (1 - od.discount)) as current_merch,
sum(od.unit_price * 1.05 * od.quantity * (1 - od.discount)) as what_if_merch
from orders o
join order_details od on o.order_id = od.order_id
group by o.order_id
)
select *, what_if_merch - current_merch as delta,
(what_if_merch - current_merch) * 100.0 / current_merch as pct_delta
from order_revenue
union all
select 'total', sum(current_merch),
sum(what_if_merch), sum(what_if_merch) - sum(current_merch),
(sum(what_if_merch) - sum(current_merch)) * 100.0 / sum(current_merch)
from order_revenue;

-- 15
with cat_rev as (
select c.category_name, sum(od.unit_price * od.quantity * (1 - od.discount)) as revenue
from order_details od
join products p on od.product_id = p.product_id
join categories c on p.category_id = c.category_id
group by c.category_name
),
abc_analysis as (
select category_name, revenue,
sum(revenue) over (order by revenue desc) / sum(revenue) over () as cum_share,
case 
when sum(revenue) over (order by revenue desc) / sum(revenue) over () <= 0.8 then 'a'
when sum(revenue) over (order by revenue desc) / sum(revenue) over () <= 0.95 then 'b'
else 'c'
end as class
from cat_rev
)
select * from abc_analysis
order by class, revenue desc;


-- 16
with leads as (
select s.company_name as shipper,
datediff(o.shipped_date, o.order_date) as lead_days
from orders o
join shippers s on o.ship_via = s.shipper_id
where o.order_date is not null and o.shipped_date is not null
)
select shipper, count(*) as orders_count,
avg(lead_days) as avg_lead_days
from leads
group by shipper
order by avg_lead_days;


-- 17
with cust_facts as (
select c.customer_id, c.company_name,
max(o.order_date) as last_order_date,
count(*) as order_count,
sum(od.unit_price * od.quantity * (1 - od.discount)) as total_revenue
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
group by c.customer_id, c.company_name
),
scored as (
select *,
datediff('1998-01-01', last_order_date) as recency_days,
case 
when datediff('1998-01-01', last_order_date) <= 30 then '0–30'
when datediff('1998-01-01', last_order_date) <= 90 then '31–90'
else '90+'
end as recency_bucket,
ntile(3) over (order by order_count desc) as frequency_bucket,
ntile(3) over (order by total_revenue desc) as monetary_bucket
from cust_facts
)
select customer_id, company_name, recency_bucket,
frequency_bucket, monetary_bucket
from scored;


-- 18
with emp_rev as (
select o.employee_id,
count(distinct o.order_id) as order_count,
sum(od.unit_price * od.quantity * (1 - od.discount)) as revenue
from orders o
join order_details od on o.order_id = od.order_id
group by o.employee_id
)
select e.employee_id, concat(e.first_name, ' ', e.last_name) as full_name,
e.title, er.order_count, er.revenue,
rank() over (order by er.revenue desc) as rank_by_revenue
from emp_rev er
join employees e on er.employee_id = e.employee_id;


-- 19
with sold_products as (
select distinct product_id from order_details
)
select p.product_id, p.product_name, s.company_name as supplier,
c.category_name as category, p.discontinued
from products p
left join sold_products sp on p.product_id = sp.product_id
join suppliers s on p.supplier_id = s.supplier_id
join categories c on p.category_id = c.category_id
where sp.product_id is null;


-- 20
with ccd as (
select ccd.customer_id, ccd.customer_type_id,
c.company_name, cd.customer_desc,
case when c.customer_id is not null then 1 else 0 
end as has_customer,
case when cd.customer_type_id is not null then 1 else 0 
end as has_demo
from customer_customer_demo ccd
left join customers c on ccd.customer_id = c.customer_id
left join customer_demographics cd on ccd.customer_type_id = cd.customer_type_id
)
select * from ccd
where has_customer = 0 or has_demo = 0;