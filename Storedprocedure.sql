-- what are stored Procedures
-- stored procedure to store and organize sql
-- faster execution
-- data security
USE sql_invoicing;

DELIMITER $$
CREATE PROCEDURE  get_clients()
BEGIN 
	select * from clients;
END $$
DELIMITER ;

CALL get_clients();


-- create a stored procedure called 
-- get_invoices_with_balance
-- to return all the invoices with a balance >0
DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
	SELECT *
	FROM invoices_with_balance
	WHERE balance > 0;
END $$
DELIMITER ;


CALL get_invoices_with_balance();

USE `sql_invoicing`;
DROP procedure IF EXISTS `get_payments`;

DELIMITER $$
USE `sql_invoicing`$$
CREATE PROCEDURE `get_payments` ()
BEGIN
	SELECT * FROM payments;
END$$

DELIMITER ;

CALL get_payments();

DROP PROCEDURE IF EXISTS get_clients;


DELIMITER $$
CREATE PROCEDURE  get_clients()
BEGIN 
	select * from clients;
END $$
DELIMITER ;

CALL get_clients();


-- PARAMETER
DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE  get_clients_by_state(state CHAR(2))
BEGIN 
	select * from clients c
    WHERE c.state = state;
END $$
DELIMITER ;


CALL get_clients_by_state('CA')
-- CALL get_clients_by_state(); -- it will throgh an error


DELIMITER $$
CREATE PROCEDURE get_invoices_by_client(client_id INT)
BEGIN
	SELECT *
	FROM invoices i
	WHERE i.client_id = client_id 0;
END $$
DELIMITER ;


