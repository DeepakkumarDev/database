-- creating a user
-- application database server
--  webserver <-> database server

CREATE USER deepak@127.0.0.1;

CREATE USER deepak@deepakdev.com;

CREATE USER deepak@'%.deepakdev.com';

CREATE USER deepak@localhost;

CREATE USER john IDENTIFIED BY '1234';




-- VIEWING USER 
SELECT * FROM mysql.user;

-- droping user
CREATE USER bob@codewithmosh.com IDENTIFIED BY '1234';
DROP USER bob@codewithmosh.com;


-- changing password

SET PASSWORD FOR john = '1234';

SET PASSWORD = '0072';


-- Grating Privaleges

-- web /desktop application

CREATE USER moon_app IDENTIFIED BY '1234';
GRANT SELECT ,INSERT,UPDATE,DELETE,EXECUTE
ON sql_store.* -- sql_store.customers
TO moon_app;

-- admin
GRANT ALL
ON sql_store.*
TO john;

GRANT ALL
ON *.* -- All tables in all databases
To john;

-- Viewing Privileges

SHOW GRANTS FOR john;

SHOW GRANTS;

-- rEVOKING pRIVILEGES / dROP pRIVILIGES

GRANT CREATE VIEW
ON sql_store.*
TO moon_app;

REVOKE CREATE VIEW
ON sql_store.*
FROM moon_app;


