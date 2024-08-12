-- select * from sql_store.orders; 


show databases;
use store;
show tables;

select *
from orders
join customers
	on orders.customer_id =customers.customer_id;


select order_id,first_name,last_name
from orders
join customers
	on orders.customer_id = customers.customer_id;
    

select order_id ,orders.customer_id ,first_name,last_name
from orders
join customers
	on orders.customer_id=customers.customer_id;

select order_id ,o.customer_id ,first_name,last_name
from orders o
join customers c
	on o.customer_id=c.customer_id;

use sql_store;
select * from sql_store.order_items;
select * from sql_store.products;


select o.order_id , quantity,o.unit_price
from order_items o
join products p
	on o.product_id=p.product_id;
    
    
select *
from order_items oi 
join products p on oi.product_id = p.product_id;



select oi.order_id ,oi.product_id,quantity,oi.unit_price
from order_items oi 
join products p on oi.product_id = p.product_id;

-- Join Across Databases
use sql_store;

select *
from order_items oi 
join sql_inventory.products p
	on oi.product_id=p.product_id;

use sql_inventory;
select *
from sql_store.order_items oi
join products p
	on oi.product_id=p.product_id;
    
    
-- self joins

select * from sql_hr.employees;
use sql_hr;



select 
	e.employee_id,
    e.first_name,
    m.first_name as Manager
from employees e
join employees m
	on e.reports_to = m.employee_id;



-- Joining Multiples Tables
select *from sql_store.orders;

select * from sql_store.order_statuses;


use sql_store;
select 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
from orders o
join customers c
	on o.customer_id = c.customer_id
join order_statuses os
	on o.status=os.order_status_id;
    
select * from sql_invoicing.payments;
select * from sql_invoicing.clients;

use sql_invoicing;
select 
	p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name
from payments p
join clients c
	on p.client_id = c.client_id
join payment_methods pm
	on p.payment_method = pm.payment_method_id;


-- compound join conditions
select * from sql_store.customers;

select * from sql_store.order_items;

select * from sql_store.order_item_notes;

use sql_store;
select *
from order_items oi
join order_item_notes oin
	on oi.order_id = oin.order_id 
    AND oi.product_id = oin.product_id;
-- Implicit Join Synatx
select *
from orders o
join customers c
	on o.customer_id=c.customer_id;
    
select *
from orders o,customers c
 where o.customer_id = c.customer_id ;

select *
from orders o,customers c ; -- clustoer


-- outer Joins
select 
	c.customer_id,
    c.first_name,
    o.order_id
from customers c
left join orders o
	on c.customer_id=o.customer_id
order by c.customer_id;

select 
	c.customer_id,
    c.first_name,
    o.order_id
from customers c
left outer join orders o
	on c.customer_id=o.customer_id
order by c.customer_id;


select 
	c.customer_id,
    c.first_name,
    o.order_id
from customers c
right join orders o
	on c.customer_id=o.customer_id
order by c.customer_id;


select 
	c.customer_id,
    c.first_name,
    o.order_id
from  orders o 
right  join customers c
	on c.customer_id=o.customer_id
order by c.customer_id;



select 
	c.customer_id,
    c.first_name,
    o.order_id
from  orders o 
right outer join customers c
	on c.customer_id=o.customer_id
order by c.customer_id;



select
	p.product_id,
    p.name,
    oi.quantity
from products p
left join order_items oi 
	on p.product_id = oi.product_id;
    
    
select 
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name as Shipper
from customers c
left join orders o
	on c.customer_id = o.customer_id
left join shippers sh
	on o.shipper_id = sh.shipper_id
order by c.customer_id;


select 
	o.order_date,
    o.order_id,
    c.first_name as customer,
    sh.name as shipper,
    os.name as status
from orders o
join customers c
	on o.customer_id=c.customer_id
left join shippers sh 
	on o.shipper_id =sh.shipper_id
join order_statuses os
	on o.status =os.order_status_id;
    
    
-- self outer join

use sql_hr;

select 
	e.employee_id,
    e.first_name,
    m.first_name as manager
from employees e
join employees m
	on e.reports_to = m.employee_id;


select 
	e.employee_id,
    e.first_name,
    m.first_name as manager
from employees e
left join employees m
	on e.reports_to = m.employee_id;


-- The suing Clause
use sql_store;

select
	o.order_id,
    c.first_name,
    sh.name as shipper
from orders o
join customers c
	using (customer_id)
left join shippers sh
	using (shipper_id);
    
select *
from order_items oi
join order_item_notes oin
	on oi.order_id = oin.order_id AND
		oi.product_id = oin.product_id;
        
select *
from order_items oi
join order_item_notes oin
	using(order_id,product_id);

use sql_invoicing;

select 
	p.date,
    c.name as client,
    p.amount,
    pm.name as payment_method
from payments p
join clients c using (client_id)
join payment_methods pm        
        on p.payment_method =pm.payment_method_id;
        
        
        
-- Natural Joins
use sql_store;
select * 
from orders o
Natural Join customers c;

select 
	o.order_id,
    c.first_name
from orders o
natural join customers c;

-- cross join

select * 
from customers c
cross join products p;

select 
	c.first_name as customer,
    p.name as product
from customers c
cross join products p
order by c.first_name;


select 
	c.first_name as customer,
    p.name as product
from customers c,products p
order by c.first_name;

-- do a cross join between shippers and products
-- using the implict synatx
-- and then using the explicit synatx

select 
	sh.name as shipper,
    p.name as product
from shippers sh,products p
order by sh.name;

select 
	sh.name as shipper,
    p.name as product
from shippers sh
cross join products p
order by sh.name;

-- Unions

select 
	order_id,
    order_date,
    'Activate' as status
from orders 
where order_date >='2019-01-01'
UNION
select 
	order_id,
    order_date,
    'Archived' as status
from orders 
where order_date <'2019-01-01';


select first_name
from customers
union
select name 
from shippers;

-- select first_name,last_name -- this query will throgh an error since from customers we are taking two columns and from shippers only one column
-- from customers
-- union
-- select name 
-- from shippers;

select name as fullname -- whatever in the first query it refelct on column in result 
from shippers
union
select first_name
from customers;

select customer_id,
	first_name,
    points ,
    'Bronze' as type
from customers 
where points < 2000
union 
select customer_id,
	first_name,
    points ,
    'Silver' as type
from customers 
where points between 2000 and 3000
union
select customer_id,
	first_name,
    points ,
    'Gold' as type
from customers 
where points > 3000
order by first_name;