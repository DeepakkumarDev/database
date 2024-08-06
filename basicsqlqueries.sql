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
where birth_date>'1990-01-01' or points>1000;
-- Get the orders placed this year

select * 
from orders
where order_date > '2019-01-01';


-- The AND,OR,NOT Operators

select * 
from customers
where birth_date >'1990-01-01' AND points>1000;


select * 
from customers 
where birth_date>'1990-01-01' or points>1000;




select * 
from customers
 where birth_date > '1990-01-01' or points >1000 and 
	state='va';
    
  -- AND
  -- OR
  
-- And opertaer has highe precedence first and will be executer no metater where is it 

select * 
from customers
where birth_date > '1990-01-01' OR
	(points >1000 AND state='VA');
    
    


select * 
from customers
where birth_date> '1990-01-01' or points>1000;



select *
from customers 
where not (birth_date> '1990-01-01' or points>1000);



select * 
from  customers
where not(birth_date <='1990-01-01' or points>1000);

select * 
from customers 
where not (birth_date <='19901-01-01' and points >1000);


select * 
from customers
where (birth_date <='1990-01-01' and points <=1000);

select * 
from order_items
where order_id=6 and (quantity*unit_price)>30;









-- In Operator

select *
from customers
where state='va' or state='ga' or state='fl';

SELECT *
FROM customers 
where state='va' or 'ga' or 'fl'; -- we cannot combinde d like this



select *
from customers
where state in ('va','fl','ga'); -- ist is hoerte an d easie r to use

select *
from customers 
where state not in ('va','fl','ga');

select *
from products
where quantity_in_stock in (49,38,72);



-- The between operators
select *
from customers
where points >= 1000 and points <=3000;


select *
from customers 
where points between 1000 and 3000;


select *
from customers 
where birth_date between '1990-01-01' and '2000-01-01';



-- like operator


select * 
from customers
where last_name like 'b%';


select *
from customers
where last_name like 'brush%';


select *
from customers
where last_name like '%b%';

select *
from customers
where last_name like '%y';



select * 
from customers
where last_name like '_y';

select * 
from customers
where last_name like '_y'; -- one underscore


select *
from customers
where last_name like '__y'; -- two underscore

select *
from customers
where last_name like '___y'; -- Three Underscore



select *
from customers
where last_name like '_____y'; -- Five Underscore


select *
from customers
where last_name like 'b____y'; -- Four Underscore




-- % any number of characters
-- _ use undersoc=re for single character


select * 
from customers
where address like '%trail%' or
	  address like '%avenue%';
      
      
select *
from customers
where phone like '%9';


select *
from customers
where phone not like '%9';



-- Regex Operator

select * 
from customers
where last_name like '%field%';

select *
from customers
where last_name regexp 'field'; 

select * 
from customers 
where last_name regexp '^field'; -- ^ carret sign for begning of the string

select * 
from customers 
where last_name regexp 'field$'; -- $ dollar sign for end of the string 


select *
from customers
where last_name regexp 'field|mac|rose'; -- | vertical bar pipe for another word 


select * 
from customers 
where last_name regexp '^field|mac|rose';

select *
from customers 
where last_name regexp 'field$|mac|rose';


select * from customers
where last_name regexp 'e';


select * 
from customers
where last_name regexp '[gim]e'; -- last name should conatined ge, ie, me


select * 
from customers
where last_name regexp 'e[fmq]';



select *
from customers 
where last_name regexp '[a-h]e';
-- ^ begning of the string
-- $ end 
-- | logical or
-- [abcd] any char listed in the bracket
-- [a-f] for range



select *
from customers
where first_name regexp 'elka|ambur';

select *
from customers
where last_name regexp 'ey$|on$';


SELECT *
from customers 
where last_name regexp '^my|^se';


SELECT *
from customers 
where last_name regexp '^my|se';


select *
from customers
where last_name regexp '[ru]b';


select * 
from customers
where last_name regexp 'br|bu'; -- lastname contain b followed by by r or u





-- The is null operator

select *
from customers
where phone is null;

select * 
from customers 
where phone is not null;


select * 
from orders
where  shipper_id is null; -- get the ordrs that are not shipped



-- The order by clause

select *
from customers
order by first_name;

select *
from customers 
order by first_name desc;

select *
from customers 
order by state desc,first_name;


select *
from customers 
order by state desc,first_name desc;


select first_name,last_name 
from customers
order by birth_date;


select first_name,last_name ,10 as points 
-- insted of 10 you can write down any mathemetivcal valid expression
from customers
order by points,first_name;


select first_name,last_name ,10 as points
from customers
order by 1,2;


select birth_date,first_name,last_name ,10 as points
from customers
order by 1,2;

select birth_date,first_name,last_name ,10 as points
from customers
order by first_name;

select *
from order_items
order by (quantity)*(unit_price) desc;


select *
from order_items
where order_id=2
order by (quantity)*(unit_price) desc;


select *, quantity * unit_price as total_price
from order_items
where order_id=2
order by (quantity)*(unit_price) desc;



select *, quantity * unit_price as total_price
from order_items
where order_id=2
order by total_price desc;




-- the limit clause

select * 
from customers
limit 3;

select * 
from customers 
limit 300; -- if customers are lecc than 300 then it retrivr all the column if it gter then till 300

select *
from customers
limit 6,3 ; -- 6 id offset it will from 6 and retreive the next three rows

select *
from customers 
order by points desc
limit 3;



-- -- order of exuection matter in sql 
-- so first we should write down 
-- select ,from,where,order by,limit