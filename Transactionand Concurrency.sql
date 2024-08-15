-- Transaction 
-- A group of SQL statements that represents a single unit of work

-- bank transaction 
-- Unit of Work
-- Debit Operation
-- Credit Operation

-- ACID Properties
-- Atomicity
-- Consistency
-- isolation 
-- Durability

-- creating Transaction

USE sql_store;

START TRANSACTION;

INSERT INTO orders (customer_id,order_date,status)
VALUES (1,'2019-01-01',1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(),1,1,1);
COMMIT; 

START TRANSACTION;

INSERT INTO orders (customer_id,order_date,status)
VALUES (1,'2019-01-01',1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(),1,1,1);
ROLLBACK; 



SELECT * FROM orders;

SHOW VARIABLES LIKE 'autocommit';

-- CONCURRENCY AND lOCKIGN

 USE sql_store;
 START TRANSACTION;
 UPDATE customers
 set points = points+10
 where customer_id =1;
 COMMIT;
 
 -- Lost updatses
 -- john ,Ny, 10
 -- Trasanction a		Transaction b
 -- john,ny,10			john,ny,10
 -- john,va,1o			john,ny,20
 
 
 -- Dirty Reads
-- A												-- B
 -- update customers 							Read Committed
 -- set points = 20 							SELECT Points
 -- ---------------
 -- -------------
 -- ROLBACK
 -- commit
 
 
 -- Non Repeating Reads

-- PHANTOM READS

-- Transaction Isolation Levels

-- 						Lost Updates 	Dirty Reads 	NON-REPEATINGREADS  	Phantom Reads
-- READ UNCOMMITED	
-- READ COMMITED						..
-- REPEATABLE READ			..			..					..
-- SERIALIZABLE				..			..					.. 						..	


SHOW VARIABLES LIKE 'transaction_isolation';

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;



-- Read UNCOMMITTED ISOLATION LEVEL
USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT points
FROM customers
WHERE customer_id =1;


-- Read Commited Isolation Level

USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT points 
FROM customers
WHERE customer_id =1;


USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT points 
FROM customers
WHERE customer_id =1;
SELECT points 
FROM customers
WHERE customer_id =1;
COMMIT;




-- Repeatable Read Isolation level
USE sql_store;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT points 
FROM customers
WHERE customer_id =1;
SELECT points 
FROM customers
WHERE customer_id =1;
COMMIT;


USE sql_store;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT * FROM customers WHERE state = 'VA';
COMMIT;




-- SERIALIZABLE ISOLATION LEVEL

USE sql_store;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT * FROM customers WHERE state = 'VA';
COMMIT;

-- DEADLOCKS

USE sql_store;
START TRANSACTION;
UPDATE customers SET state ='VA' WHERE customer_id =1;
UPDATE orders SET status = 1 WHERE order_id = 1;
COMMIT;


