-- Column Attributes

-- inserting a row
use sql_store;
INSERT INTO customers
values(
		DEFAULT,
		'John',
        'Smith',
        '1990-01-01',
        NULL,
        'address',
        'city',
        'ca',
        DEFAULT);
        
        
insert into customers (
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state)
values (
	'Deepak',
    'Dev',
    '1990-01-01',
    'address',
    'city',
    'Ca');


insert into customers (
	last_name,
    first_name,
    birth_date,
    address,
    city,
    state)
values (
	'Dev',
	'Deepak',
    '1990-01-01',
    'address',
    'city',
    'Ca');
    

-- Inserting Multiple Rows

select * from customers;

select * from products;

select * from shippers;


insert into shippers (name)
values ('SHIPPER1'),
		('SHIPPER2'),
        ('SHIPPER3');

insert into products (name,quantity_in_stock,unit_price) 
    values ('product1',10,1.95),
			('Product2',12,2.96),
            ('product3',14,3.2);
            
-- inserting Hierarchical Rows
INSERT INTO orders (customer_id,order_date,status)
VALUES (1,'2019-01-02',1);
select * from customers;

 SELECT LAST_INSERT_ID() ;-- First Execute it

insert into order_items
VALUES
	(LAST_INSERT_ID(),1,1,2.95),
    (LAST_INSERT_ID(),2,1,3.95);
    
-- select * from order_items;

-- Creating a copy of a table
CREATE TABLE orders_archived AS
SELECT * FROM orders;

select * from orders_archived;        
 
-- Trancuate the orders_archived table then execute the below code

insert into orders_archived
select * 
from orders
where order_date < '2019-01-01';


select * from orders_archived;  

use sql_invoicing;
create table invoices_archived AS
select 
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
from invoices i
join clients c
	using (client_id)
where payment_date is not null;

select * from invoices_archived;


-- updating a single row

select * from invoices;


UPDATE invoices
SET payment_total =10 ,payment_date = '2019-03-01'
where invoice_id =1;


update invoices 
set payment_total = DEFAULT,payment_date = null
where invoice_id = 1;

update invoices
set
	payment_total = invoice_total * 0.5,
	payment_date= due_date
where invoice_id=3;


-- updating multple rows

update invoices
set 
	payment_total=invoices_total *0.5,
	payment_date =due_date
where client_id IN(3,4);


use sql_store;

update customers
set points=points+50
where birth_date <'1990-01-01';


-- using subqueries in updates
use sql_invoicing;
update invoices
set
	payment_total = invoices_total*0.5,
    payment_date=due_date
where client_id=
			(select client_id
			from clients
			where name = 'Myworks');


update invoices
set 
	payment_total =invoice_total * 0.5,
    payment_date =due_date
where client_id IN
		(select client_id
        from clients
        where state in ('CA','NY'));
        
update invoices
set
	payment_total =invoice_total * 0.5,
    payment_date =due_date
where payment_date is null;
 
select * 
from invoices 
where payment_date is null;

use sql_store;
update orders
set comments ='Gold Customer'
where customer_id in
			(select customer_id
			from customers
			where points> 3000); 
-- DELETE FROM invoices;
use sql_invoicing;
DELETE FROM invoices
where invoice_id =1;


delete from invoices 
where client_id=(select * 
		from clients
		where name = 'Myworks'); 

-- Restoring The databases
