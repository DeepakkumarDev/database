USE sql_store;
/*
SELECT 1,2
-- FROM customers
-- WHERE customer_id=1
-- ORDER BY first_name;


SELECT
	first_name,
    last_name,
    points,
    (points*10)+100 AS "discount factor" -- discount_factor// if you want space bwt two words write in double quote
FROM customers



SELECT state
FROM customers


SELECT * FROM sql_store.customers;

SELECT DISTINCT state 
FROM customers;



-- SELECT * FROM customers;
show tables;

select * from products;

SELECT name,
	unit_price,
	unit_price*1.1 AS "new price"
FROM products;


SELECT *
FROM customers
WHERE POINTS >3000;
>
>=
<
<=
=
!=
<>


SELECT *
FROM Customers
WHERE state='VA';



SELECT *
FROM Customers
WHERE state!='va';--instead of != we can use <>operator


SELECT *
FROM Customers
WHERE state <>'va';


SELECT *
FROM Customers
WHERE birth_date > '1990-01-01';


SHOW TABLES;

SELECT * FROM Orders;

select * from orders where order_date >='2019-01-01';



SELECT *
FROM Customers
where birth_date>'1990-01-01' AND points>100;



SELECT *
FROM Customers
where birth_date>'1990-01-01' OR points>100;

-- Date today 20/02/2024
select * from customers;


select 
	first_name,
    last_name,
    points,
    (points +10)*100 as 'discount factor'
from customers;



select state
from customers



select * from sql_store.customers;


select distinct state from customers


select * -- first_name,last_name,price
from customers;


select * from products;

select name ,unit_price, unit_price*1.1 As new_price
from products;

select *
from customers
where points>3000;

>
>=
<
==
!=
<> not eqal


select * 
from customers
where state='va';



select * 
from customers
where birth_date >'1990-01-01';


select * from orders
where order_date >='2019-01-01';


select *
from customers
where birth_date >'1990-01-01' or
 (points>1000 and state='va')
 
 
 select * from customers
 -- where not birth_date>'1990-01-01' or points>1000
 
 where birth_date<='1990-01-01' and points<=1000;
 
 
 select *
 from order_items
 where order_id =6 and unit_price*quantity>30;
 
 
 
 select *
 from customers
 -- where state='va' or state='ga' or state='fl';
 where state not in ('va','fl','ga');

 select * from products
 where quantity_in_stock in(49,38,72);
 
 
 
 select * from customers
 -- where points >=1000 and points<=3000
 where points between 1000 and 3000;
 
 
 select * from customers
 where birth_date between '1990-01-01' and '2000-01-01'
 
 
 
 select *
 from customers
 where last_name like 'b%'
 
 
 select *
 from customers
 -- where last_name like 'brush%';
 -- where last_name like '%b%'
 -- where last_name like '%y'
 -- where last_name like '_y'
 -- where last_name like '_____y'
 where last_name like 'b____y';
 -- % any number of character
 -- _single character
 
 select * from customers
 where -- address like '%trail%' or 
		-- address like  '%avenue%' 
        -- phone like '%9'
        phone not like '%9'



select *
from customers
-- where last_name like '%field%'
-- where last_name regexp 'field'
-- where last_name regexp '^field' -- ^ begning of the string 
-- where last_name regexp 'field$' -- $ end of the string
-- where last_name regexp '^field|ac|rose' -- |(pipe or vertical bar)  or both
-- where last_name regexp 'field$|mac|rose'
-- where last_name regexp '[gim]e' -- [gim]e means any character ge ie me
 -- where last_name regexp 'e[fmq]' -- means any character ef em eq
 -- where last_name regexp '[a-h]e' 
-- ^ begning
-- $ end
-- | logical or
-- [abcd]
-- [a-f]
-- where first_name regexp 'elka|ambur'
-- where last_name regexp 'ey$|on$'
-- where last_name regexp '^my' or last_name regexp '[s]e'
-- where last_name regexp '^my|se'
-- where last_name regexp 'b[ru]'



select * from customers
-- where phone is null
where phone is not null


select * from sql_store.orders
where shipper_id is null



select * from 
customers 
-- order by first_name desc
-- order by state,first_name
order by state desc,first_name desc

select first_name,last_name,10 as points
from customers
order by birth_date

select first_name,last_name ,10 as points
from customers
order by points,first_name



select first_name,last_name, 10 as points
from customers
order by 1,2



-- select * from sql_store.order_items

select * from order_items
where order_id=2 
order by unit_price*quantity desc



select * ,quantity*unit_price As total_price
from order_items
where order_id=2
order by total_price desc


select * from customers
-- limit 300
-- limit 6,3
-- page 1:1-3
-- page 2:4-6
-- page 3:7-9
*/
select * from customers
-- where 
order by points desc
limit 3