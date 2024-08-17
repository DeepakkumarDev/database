-- index speed up our queries

-- index are data structure in databse
-- customers
	-- id 	firstname 	last_name 	state  
    
-- index on state column 

-- cost of indexes
	-- Increase the databse
	-- slow down thw writes

-- Reserve indexes for performance critical quries
-- Design indexes based on your queries not your tables
-- index often store as binary tree

-- creating Indexes



USE sql_store;
SELECT customer_id FROM customers WHERE state ='CA';

Explain SELECT customer_id FROM customers WHERE state ='CA';

SELECT COUNT(*) FROM customers;



CREATE INDEX idx_state ON customers (state);


EXPLAIN SELECT customer_id FROM customers WHERE points > 1000;

CREATE INDEX idx_points ON customers (points);



SHOW INDEXES IN customers;
-- primary key is also called as clustered Index

ANALYZE TABLE customers;

SHOW INDEXES IN orders;

-- Prefix Indexes
-- string columns
-- CHAR
-- VARCHAR
-- TEXT
-- BLOB



CREATE INDEX idx_lastname ON customers (last_name(20));

SELECT COUNT(*) FROM customers;


SELECT COUNT(LEFT(last_name,1)) FROM customers;

SELECT COUNT(DISTINCT LEFT(last_name,1)) FROM customers;

SELECT
	COUNT(DISTINCT LEFT(last_name,1)),
    COUNT(DISTINCT LEFT(last_name,5)),
    COUNT(DISTINCT LEFT(last_name,15)) 
FROM customers;



-- FULL TEXT INDEXES

USE sql_blog;

SHOW TABLES;

SELECT * FROM posts;


SELECT * 
FROM posts
WHERE title LIKE '%react redux%' OR 
		body LIKE '%react redux%';

CREATE FULLTEXT INDEX idx_title_body ON posts(title,body);


SELECT *
FROM posts
WHERE MATCH(title,body) AGAINST('react redux');

SELECT *,MATCH(title,body) AGAINST('react redux')
FROM posts
WHERE MATCH(title,body) AGAINST('react redux');


SELECT *,MATCH(title,body) AGAINST('react redux')
FROM posts
WHERE MATCH(title,body) AGAINST('react redux' IN BOOLEAN MODE);


SELECT *,MATCH(title,body) AGAINST('react redux')
FROM posts
WHERE MATCH(title,body) AGAINST('react -redux' IN BOOLEAN MODE);


SELECT *,MATCH(title,body) AGAINST('react redux')
FROM posts
WHERE MATCH(title,body) AGAINST('react -redux+form' IN BOOLEAN MODE);

SELECT *,MATCH(title,body) AGAINST('react redux')
FROM posts
WHERE MATCH(title,body) AGAINST('"handling a form"' IN BOOLEAN MODE);


-- Composite Indexes
USE sql_store;
SHOW INDEXES IN customers;

SELECT customer_id FROM customers
WHERE state ='CA' AND points > 1000;


EXPLAIN SELECT customer_id FROM customers
WHERE state ='CA' AND points > 1000;


USE sql_store;
CREATE INDEX idx_state_points ON customers (state,points);
EXPLAIN SELECT customer_id FROM customers
WHERE state ='CA' AND points > 1000;

DROP INDEX idx_state ON customers;
DROP INDEX idx_points ON customers;

-- order of columns in composite index
	-- order of columns -put the most frequently used columns first
	-- put the columns with a higher cardinility first


-- gender M F 
-- STATE cs 
SELECT customer_id
FROM customers
WHERE state ='CA' AND last_name LIKE 'A%';

SELECT 
	COUNT(DISTINCT state),
    COUNT(DISTINCT last_name)
FROM
customers;

CREATE INDEX idx_lastname_state ON customers
(last_name,state);

EXPLAIN SELECT customer_id
FROM customers
WHERE state ='CA' AND last_name LIKE 'A%';



CREATE INDEX idx_state_lastname ON customers
(state,last_name);


EXPLAIN SELECT customer_id
FROM customers
WHERE state ='CA' AND last_name LIKE 'A%';

EXPLAIN SELECT customer_id
FROM customers
WHERE state ='NY' AND last_name LIKE 'A%';


EXPLAIN SELECT customer_id
FROM customers
USE INDEX (idx_lastname_state)
WHERE state ='NY' AND last_name LIKE 'A%';


EXPLAIN SELECT customer_id
FROM customers
USE INDEX (idx_lastname_state)
WHERE state LIKE '%A' AND last_name LIKE 'A%';


EXPLAIN SELECT customer_id
FROM customers
USE INDEX (idx_state_lastname)
WHERE state LIKE '%A' AND last_name LIKE 'A%';

EXPLAIN SELECT customer_id
FROM customers
USE INDEX (idx_state_lastname)
WHERE last_name LIKE 'A%';

DROP INDEX idx_lastname_state ON customers;


-- order of columns 
-- Frequently used columns
-- high cardinality columns
-- take your queries into account

-- when index are ignored

EXPLAIN SELECT customer_id FROM customers 
WHERE state = 'CA' OR points > 1000;


EXPLAIN
	SELECT customer_id FROM customers
    WHERE state ='CA'
    UNION
    SELECT customer_id FROM customers
    WHERE points > 1000;

CREATE INDEX idx_points ON customers (points);


EXPLAIN SELECT customer_id FROM customers
WHERE points+10 > 2010;

EXPLAIN SELECT customer_id FROM customers
WHERE points > 2000;




SHOW INDEXES IN customers;


EXPLAIN SELECT customer_id FROM customers ORDER BY state;

EXPLAIN SELECT customer_id FROM customers 
ORDER BY first_name;

EXPLAIN SELECT customer_id FROM customers 
ORDER BY state, first_name,points;

EXPLAIN SELECT customer_id FROM customers 
ORDER BY state,points DESC;

EXPLAIN SELECT customer_id FROM customers 
WHERE state ='CA'
ORDER BY points DESC;

SHOW STATUS;

SHOW STATUS LIKE 'last_query_cost';



-- covering Indexes

EXPLAIN SELECT * FROM customers ORDER BY state; 

EXPLAIN SELECT customer_id,state FROM customers 
ORDER BY state; 


SHOW STATUS LIKE 'last_query_cost';

-- index Maintenance


