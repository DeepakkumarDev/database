-- subqueries
use sql_store;
select * 
from products 
where unit_price >( -- frist it will evulate subqurires then it will pass the result to outer queries
	select unit_price
    from products
    where product_id =3);
    
use sql_hr;
show tables;

select * from employees;

select first_name ,
	last_name,
    salary
from employees
where salary >(
	select avg(salary) 
    from employees
);

select first_name ,
	last_name,
    salary
from employees
where salary >(
	select sum(salary)/count(salary) 
    from employees
);


-- subquries using in operator
use sql_store;

select * from sql_store.order_items;
 -- find the products that have never been ordered
 
select distinct product_id
from order_items;

select * 
from products
where product_id not in (
	select distinct product_id
	from order_items
);

use sql_invoicing;
select *
from clients 
where client_id not in( 
	select distinct client_id
	from payments
);

select *
from clients 
where client_id not in( 
	select distinct client_id
	from invoices
);



select * 
from clients
left join invoices using (client_id)
where invoice_id is null;

-- subqueries  vs joins
use sql_store;

show tables;

select * from customers;
select * from order_items;
select * from products;

select customer_id,first_name,last_name
from customers
where customer_id in (
	select o.customer_id
    from order_items oi
    join orders o using(order_id)
    where product_id =3
);

select distinct customer_id,first_name,last_name
from customers c
join orders o using(customer_id)
join order_items oi using (order_id)
where oi.product_id = 3;

-- ALl keyword
use sql_invoicing;

select *
from invoices
where client_id = 3;

select max(invoice_total)
from invoices
where client_id = 3;


select *
from invoices
where invoice_total > (
	select max(invoice_total)
    from invoices
  where client_id =3
);

 -- select invoices larger than all invoices of
 -- client 3
 
select *
from invoices
where invoice_total > all (
	select invoice_total
    from invoices
    where client_id =3 
);

select *
from invoices
where invoice_total >  (
	select max(invoice_total)
    from invoices
    where client_id =3 
);




-- ANy and some keyboard

use sql_invoicing;

select *
from invoices
where invoice_total > some (
	select invoice_total
    from invoices
    where client_id = 3
);

select *
from invoices
where invoice_total > any (
	select invoice_total
    from invoices
    where client_id=3
);

select *
from clients
where client_id in(
	select client_id
	from invoices
	group by client_id
	having count(*) >=2
);

select *
from clients
where client_id=any(
	select client_id
	from invoices
	group by client_id
	having count(*) >=2
);

-- select employees whose salary is
-- above the average in their office


-- fro each employee
-- 	calcualte the avg salary for employee.office
-- 	return the employee if salary > avg


use sql_hr;

select *
from employees e
where salary >(
	select avg(salary) 
	from employees
    where office_id = e.office_id
);



use sql_invoicing;

show tables;


-- Get invoices that are larger than the 
-- client's average amount
select *
from invoices i
where invoice_total >(
	select avg(invoice_total)
    from invoices
    where client_id = i.client_id

);

-- select clients that have an invoice

select *
from clients
where client_id in (
	select distinct client_id
    from invoices
);

select *
from clients c
where exists (
	select client_id
    from invoices
    where client_id = c.client_id
);

select *
from clients
where client_id in( -- it is good to use exist opertor for efficient result
	select distinct client_id
    from invoices
);


use sql_store;
-- find the products that have never been ordered
select *
from products p
where product_id not in (
	select product_id
    from order_items
    where product_id =p.product_id
);


select *
from products p
where  not exists (
	select product_id
    from order_items
    where product_id =p.product_id
);

-- subqueries in the select clause
use sql_invoicing;

select 
	invoice_id,
    invoice_total,
    (select avg(invoice_total)
		from invoices) as invoice_average,
        invoice_total - (select invoice_average)  as difference
from invoices;

select 
	client_id,
    name,
    (select sum(invoice_total)
		from invoices
        where client_id = c.client_id) as total_sales,
        (select avg(invoice_total) from invoices) as average,
        (select total_sales -average) as difference
        
from clients c;



-- subqueries in the from clause

select * 
from (
		select 
		client_id,
		name,
		(select sum(invoice_total)
			from invoices
			where client_id = c.client_id) as total_sales,
			(select avg(invoice_total) from invoices) as average,
			(select total_sales -average) as difference
	from clients c


) as sales_summary
where total_sales is not null;