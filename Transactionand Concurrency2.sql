SHOW DATABASES;
USE `nighwantech`;
 USE sql_store;
 START TRANSACTION;
 UPDATE customers
 set points = points+10
 where customer_id =1;
 COMMIT;
 
 
USE sql_store;
START TRANSACTION;
UPDATE customers
SET points =40
WHERE customer_id =1;
-- ROLLBACK;
COMMIT;


SELECT * FROM customers;

USE sql_store;
START TRANSACTION;
UPDATE customers
SET state ='VA'
WHERE customer_id =1;
-- ROLLBACK;
COMMIT;



USE sql_store;
START TRANSACTION;
UPDATE customers
SET state ='VA'
WHERE customer_id =3;
-- ROLLBACK;
COMMIT;




USE sql_store;
START TRANSACTION;
UPDATE orders SET status = 1 WHERE order_id = 1;
UPDATE customers SET state ='VA' WHERE customer_id =1;
COMMIT;