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
)




