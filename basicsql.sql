-- SHOW DATABASES;
-- USE `nighwantech`;
-- SHOW TABLES;

-- CREATE DATABASE IF NOT EXISTS `DEEPAKDEVSQL`;
-- USE `DEEPAKDEVSQL`;
-- SHOW TABLES;
-- DROP DATABASE IF EXISTS `DEEPAKDEVSQL`; 
-- SHOW DATABASES;
-- USE `covid19`;
-- SHOW TABLES;
-- SELECT * FROM `covid_data`;


-- SELECT 55+11;
-- SELECT now();

-- SELECT CONCAT('hello', ' ', 'world');
-- SELECT upper('deepak') AS uppercase;

-- select lower('DEEPAK KUMAR DEV') AS lower;

-- select length('deepak') as length;

-- select trim(' hello world ') as trim;

-- select substring('Hello world' ,1,3) as substring;
-- select replace('Hello world','Hello','there') as replaced;
-- select concat('hello',' ','world') as result
-- union all
-- select upper('deepak')
-- union all
-- select lower('DEEPAK KUMAR DEV');

-- SET @concatenated_string = CONCAT('hello', ' ', 'world');
-- SET @uppercase = UPPER('deepak');
-- SET @lowercase = LOWER('DEEPAK KUMAR DEV');

-- SELECT @concatenated_string AS concatenated_string, 
--        @uppercase AS uppercase, 
--        @lowercase AS lowercase;


show databases;
use sql_store;
show tables;
-- SELECT concat(first_name,' ',last_name) as name , birth_date, 
--        FLOOR(DATEDIFF(CURDATE(), birth_date) / 365.25) AS age
-- FROM customers
-- WHERE FLOOR(DATEDIFF(CURDATE(), birth_date) / 365.25) > 18;

-- SELECT *, 
-- 	FLOOR(DATEDIFF(NOW(),birth_date)/365.25) as age
-- FROM customers
-- where FLoor(DATEDIFF(NOW(),birth_date)/365.25)>18;



-- SELECT * ,FLOOR(DATEDIFF(NOW(),birth_date)/365.25) as age
-- FROM customers 
-- where FLOOR(DATEDIFF(NOW(),birth_date)/365.25) between 0 AND 10;

-- SELECT * ,FLOOR(DATEDIFF(NOW(),birth_date)/365-- .25) as 
-- FROM customers 
-- where FLOOR(DATEDIFF(NOW(),birth_date)/365.25) <25 or
-- 	FLOOR(DATEDIFF(NOW(),birth_date)/365.25) < 35;

-- select * from customers;
-- SELECT * from customers where city in('Waltham','Hampton','Colorado Springs');





