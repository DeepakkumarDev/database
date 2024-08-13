-- Aggregate Functions
-- max()
-- min()
-- avg()
-- sum()
-- count()

use sql_invoicing;
select
	MAX(invoice_total) as highest,
    MIN(invoice_total) as lowest,
    AVG(invoice_total) as average
from invoices;

select
	MAX(payment_date) as highest,
    MIN(invoice_total) as lowest,
    AVG(invoice_total) as average
from invoices;


select
	MAX(invoice_total) as highest,
    MIN(invoice_total) as lowest,
    AVG(invoice_total) as average,
    SUM(invoice_total) as total,
    SUM(invoice_total*1.1) as totalby,
    COUNT(invoice_total) as number_of_invoices,
    count(payment_date) as count_of_payments,
    -- count(*) as total_records,
    count( DISTINCT client_id) as total_records
from invoices
where invoice_date > '2019-07-01';


select
	'First half of 2019' as date_range,
    sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total -payment_total) as what_we_expect
from invoices
where invoice_date
	between '2019-01-01' and '2019-06-30'
union
select 
'Second half of 2019' as date_range,
sum(invoice_total) as total_sales,
sum(payment_total) as total_payments,
sum(invoice_total-payment_total) As what_we_expect
from invoices
where invoice_date
	between '2019-07-01' and '2019-12-31'
union
select 
	'toatal' as date_range,
    sum(invoice_total) as toale_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total-payment_total) as what_we_expect
from invoices
where invoice_date
	between '2019-01-01' and '2019-12-31';
    

select client_id,
	sum(invoice_total) as total_sales
from invoices
group by client_id
order by total_sales desc;

select 
	client_id,
    sum(invoice_total) as total_sales
from invoices 
where invoice_date >= '2019-07-01'
group by client_id
order by total_sales desc;
 -- select from the where Optional and gorup by and then order by
 
 
 select 
	client_id,
    sum(invoice_total) as total_sales
from invoices i
join clients using (client_id)
where invoice_date >= '2019-07-01'
group by client_id
order by total_sales desc;




 select 
	state,
    city,
    sum(invoice_total) as total_sales
from invoices i
join clients using (client_id)
where invoice_date >= '2019-07-01'
group by state,city;

select * from invoices;

select * from payment_methods;
select * from payments;

select 
	date,
    pm.name as payment_method,
    sum(amount) as total_payments
from payments p
join payment_methods pm
	on p.payment_method = pm.payment_method_id
group by date,payment_method
order by date;



-- the having clause

select 
client_id,
	sum(invoice_total) AS total_sales
from invoices
where total_sales>500 -- problem 
group by client_id;


select 
client_id,
	sum(invoice_total) AS total_sales,
    count(*) as number_of_invoices
from invoices
group by client_id
having total_sales>500; 
--  therse is some differenc between having and where clauses
select 
client_id,
	sum(invoice_total) AS total_sales,
    count(*) as number_of_invoices
from invoices
group by client_id
having total_sales>500 and number_of_invoices > 5;



use sql_store;



select 
	c.customer_id,
    c.first_name,
    c.last_name,
    sum(oi.quantity* oi.unit_price) as total_sales
from customers c 
join orders o using (customer_id)
join order_items oi using (order_id)
where state='va'
group by 
	c.customer_id,
	c.first_name,
    c.last_name
having total_sales >100;

-- rollup operator

use sql_invoicing;

select 
    state,
    city,
	sum(invoice_total) as total_sales
from invoices
join clients c using (client_id)
group by state,city with rollup;


select 
	pm.name as payment_method,
    sum(amount) as total
from payments p
join payment_methods pm
	on p.payment_method =pm.payment_method_id
group by payment_method with rollup; -- when we use rollup operator we can not use alies with group by claue



select 
	pm.name as payment_method,
    sum(amount) as total
from payments p
join payment_methods pm
	on p.payment_method =pm.payment_method_id
group by pm.name with rollup;