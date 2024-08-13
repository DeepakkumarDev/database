-- Numeric Functions

SELECT ROUND(5.73);
SELECT ROUND(5.73,1);
select round(5.7345,2);
select truncate(5.7345,2);
select ceiling(5.7);
select ceiling(5.2);
select floor(5.2);


select abs(5.2);
select abs(-5.2);
select rand();

 -- string function
 
select length('sky');
select upper('sky');
select lower('Sky');

select ltrim('    sky');
select rtrim('sky             ');

select trim('   sky   ');

select left('Kindergarten',4);

select right('kindgarten' ,6);


select substring('kindergarten',3,5);

select substring('kindergarten',3);
select locate('n','kindergarten');
select locate('q','kindergarten');
select locate('garten','kindergarten');

select replace('kindergarten','garten','garden');

select concat('first','last');

use sql_store;
select concat(first_name,' ',last_name) as fullname
from customers;



-- Date function

select now();

select curdate();
select curtime();

select year(now());


select month(now());

select day(now());

select hour(now());

select minute(now());

select second(now());


select dayname(now());

select monthname(now());


select extract(day from now());

select extract(year from now());


select *
from orders 
where order_date >= curdate();


select *
from orders 
where year(order_date) = year(now());

-- formating date and time
-- '2019-03-11'

SELECT DATE_FORMAT(NOW(),'%y');
SELECT DATE_FORMAT(NOW(),'%Y');
SELECT DATE_FORMAT(NOW(),'%m %Y');
SELECT DATE_FORMAT(NOW(),'%M %Y');
SELECT DATE_FORMAT(NOW(),'%M %d %Y');
SELECT DATE_FORMAT(NOW(),'%M %D %Y');


select TIME_FORMAT(NOW(),'%H:%i %p');

SELECT DATE_ADD(NOW(),INTERVAL 1 DAY);

SELECT DATE_ADD(NOW(),INTERVAL 1 YEAR);
SELECT DATE_ADD(NOW(),INTERVAL -1 YEAR);
SELECT DATE_SUB(NOW(),INTERVAL 1 YEAR);


SELECT DATEDIFF('2019-01-05','2019-01-01');

SELECT DATEDIFF('2019-01-05 09:00','2019-01-01 17:00');

SELECT DATEDIFF('2019-01-01 17:00','2019-01-05 09:00');

SELECT TIME_TO_SEC('09:00');

SELECT TIME_TO_SEC('09:00')-TIME_TO_SEC('09:02');

-- IFNULL AND COALESCE FUNCTIONS
USE sql_store;

SELECT 
	order_id,
	IFNULL(shipper_id,'Not assigned') AS shipper
FROM orders;


SELECT 
	order_id,
	COALESCE(shipper_id,comments,'Not assigned') AS shipper
FROM orders;

select 
	concat(first_name,' ' ,last_name) as fullname,
    ifnull(phone,'unknown') as phone
from customers;



select 
	concat(first_name,' ' ,last_name) as fullname,
    COALESCE(phone,'unknown') as phone
from customers;



-- if function

-- if(expression,first,second,....)

select 
	order_id,
	order_date,
    IF(
		YEAR(order_date) = YEAR(NOW()),
        'Active',
        'Archived') as  category
from orders;


select 
	product_id,
    name,
    count(*) as orders,
    if (
		count(*)>1,
        'many times',
        'once') as frequency
from products
join order_items using (product_id)
group by product_id ,name;

SELECT
	order_id,
    CASE
		WHEN YEAR(order_date) = Year(NOW()) THEN 'ACTIVE'
        WHEN YEAR(order_date) = YEAR(NOW()) - 1 THEN 'LAST YEAR'
        WHEN YEAR(ORDER_DATE) < YEAR(NOW()) -1 THEN 'ARCHIVED'
        ELSE 'FUTURE'
	END AS category
from orders;

SELECT 
	CONCAT(first_name,'',last_name) as customer,
    points,
    CASE
    WHEN points > 3000 THEN 'GOLD'
    WHEN points >= 2000 THEN 'SILVER'
    ELSE 'bronze'
    END as category
FROM customers;
    
