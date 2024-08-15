-- string types
-- Numeric Types
-- Date and Time Types
-- Blob Types
-- Spatial Types


-- String Types

-- CHAR(X) --FIRSD LENGTH
-- VARCHAR(X) ZIPOCDE /PHONENUBER

-- VARCHAR -- FRO SHORT STING
--  VARCHAR(X) MAX : 65,535 CHARACTER 
-- MEDIUMTEXT MAX 16MB
-- LONGTEXT MAX 4GB

-- TINYTEXT MAX : 255 BYTES
-- TEXT 64KB

-- ENGLISH TAKE 1 BYTES
-- EUROPEAN MIDDLE EASTR=ERN TAKE 2 BYTES
-- ASIAN 3 BYTES


-- INTEGER TYPES
-- TINYINT 1B [-128,127]
-- UNSIGNED TINYINT [0,255]
-- SMALL INT 2B [-32K,32K]
-- MEDIUMINT 3B [-8M,8M]
-- INT 4B [-2B,2B]
-- BIGINT 8B [-9Z,9Z]
-- ZEROFILL
-- INT(4) => 0001

-- RATIONALS
-- DECIMAL(p,s)
-- decimal(9,2) => 1234567.89
-- DEC
-- NUMERIC
-- FIXED

-- FLOAT 4b
-- DOUBLE 8b

-- BOOLEAN TYPES
-- BOOL
-- BOOLEAN

-- UPDATE posts
-- SET is_published =TRUE # FALSE
-- SET is_published =1
-- SET is_published =0


-- ENUM AND SET TYPES

-- ENUM('small','medium','large')

USE sql_store;
SELECT * FROM products;
-- set(..) data types
-- DATE AND TIME TYPES
-- DATE
-- TIME
-- DATETIME 8B
-- TIMESTAMP 4B (UPT TO 2038)
-- YEAR

-- BLOB TYPES FOR BINARY TYPES FORS STONING IMAGES VIDEO
-- TINYBLOB 255B
-- BLOB 65KB
-- MEDIUMBLOB 16MB
-- LONGBLOB 4GB
-- PROBLEMS WITH STORING FILES IN A DATABSE 
	-- INCREASED DATABASE SIZE
    -- SLOWER BACKUPS
    -- PERFORMANCE PROBLEMS
    -- MORE CODE TO READ /WRITE IMAGES
    
-- JSON TYPES
-- LIGHWEIGHT FORMAT FOR STORING AND TRANSFERRING DATA OVER THE INTERNET

-- JSON { "KEY":VALUE}

USE sql_store;
UPDATE products
SET properties= '{
	"dimensions" : [1,2,3],
    "weight" : 10,
    "manufacturer" : {"name" : "sony"}
}'
WHERE product_id =1 ;

SELECT * FROM products;

UPDATE products
SET properties = JSON_OBJECT(
	'weight',10,
    'dimensions',JSON_ARRAY(1,2,3),
    'manufacturer',JSON_OBJECT('name','sony')
)
WHERE product_id =1;

SELECT product_id,JSON_EXTRACT(properties,'$.weight')
FROM products
WHERE product_id =1;

select product_id,properties -> '$.weight'
from products
where product_id =1;


select product_id,properties -> '$.dimensions'
from products
where product_id =1;

select product_id,properties -> '$.dimensions[0]'
from products
where product_id =1;




select product_id,properties -> '$.manufacturer'
from products
where product_id =1;

select product_id,properties -> '$.manufacturer.name'
from products
where product_id =1;


select product_id,properties ->>  '$.manufacturer.name' -- result without quorte ->>
from products
where product_id =1;



select product_id,properties ->>  '$.manufacturer.name' 
from products
where properties ->> '$.manufacturer.name'  = 'sony';



SELECT product_id, properties ->> '$.manufacturer.name' 
FROM products
WHERE properties ->> '$.manufacturer.name' = 'sony';


update products
set properties = JSON_SET(
	properties,
    '$.weight',20,
    '$.age',10
)
WHERE product_id =1 ;


SELECT product_id, properties 
FROM products
WHERE properties ->> '$.manufacturer.name' = 'sony';




update products
set properties = JSON_REMOVE(
	properties,
    '$.age'
)
WHERE product_id =1 ;
