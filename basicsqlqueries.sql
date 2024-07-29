show databases;
use sql_store;
show tables;
-- select statement 

select * from customers;

select * from customers
where customer_id=1;

select * from customers 
-- where customer_id=1
order by first_name;


select 1,2;

-- select clause

select first_name ,last_name
from customers;




select first_name,last_name ,points,points+10 -- +/-*10 we can add multiply deivde subtarct
from customers;

select first_name,last_name,points,points*10+100  -- foolow order of precedend or poperation to change order use bracket
from customers;

select first_name,last_name,points,(points+10)*100 as discount_factor
from customers;


select first_name,last_name ,points,(points+10)*100 as "discount factor"
from customers;

select * from sql_store.customers;
select state from customers;
SELECT * FROM sql_store.customers;

select Distinct state from customers;

select name,unit_price ,(unit_price*1.1) as "new price"
from products;

-- where Clause

select * 
from customers 
where points>300;

-- operator >,>=,<,<=,=,(!=,<> both are not eqal operators)

select * 
from customers
where state='VA';


select * from customers
where state!='va';

select * from customers
where state <> 'va';


select * 
from customers 
where birth_date >'1990-01-01';


select * from orders;

select * from orders 
where order_date >='2019-01-01';

-- and or not operators


select * 
from customers 
where birth_date>'1990-01-01' AND points>1000;

select * 
from customers
where birth_date>'1990-01-01' or points>1000