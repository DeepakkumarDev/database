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
	WHERE i.client_id = client_id ;
END $$
DELIMITER ;

CALL get_invoices_by_client(1);

-- PARAMETERS WITH DEFAULT values


DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE  get_clients_by_state(state CHAR(2))
BEGIN 
	IF state IS NULL THEN
		set state = 'CA';
	END IF;
	select * from clients c
    WHERE c.state = state;
END $$
DELIMITER ;


CALL get_clients_by_state(NULL);





DROP PROCEDURE IF EXISTS get_clients_by_state;
DELIMITER $$
CREATE PROCEDURE  get_clients_by_state(state CHAR(2))
BEGIN 
	IF state IS NULL THEN
		SELECT * FROM clients;
	ELSE 
		select * from clients c
		WHERE c.state = state;
	END IF;
END $$
DELIMITER ;


CALL get_clients_by_state(NULL);





DROP PROCEDURE IF EXISTS get_clients_by_state;
DELIMITER $$
CREATE PROCEDURE  get_clients_by_state(state CHAR(2))
BEGIN 
	select * from clients c
	WHERE c.state = IFNULL(state,c.state);
END $$
DELIMITER ;

CALL get_clients_by_state(NULL);


-- write a stored procedure called get_payments
-- with two parameters
--
-- client_id =>INT (4)
-- payment_method_id => TINYINT(1) 0-255


DROP PROCEDURE IF EXISTS get_payments;
DELIMITER $$
CREATE PROCEDURE  get_payments
(
	client_id INT,
    payment_method_id TINYINT
)
BEGIN 
	SELECT *
    FROM payments p
	WHERE p.client_id = IFNULL(client_id,p.client_id) AND
    p.payment_method =
		IFNULL(payment_method_id,p.payment_method);
END $$
DELIMITER ;

CALL get_payments(NULL,NULL);
CALL get_payments(1,NULL);
CALL get_payments(5,NULL);


DROP PROCEDURE IF EXISTS make_payment;
DELIMITER $$
CREATE PROCEDURE make_payment
(
	invoice_id INT,
    payment_amount DECIMAL(9,2),
    payment_date date
)
BEGIN
	UPDATE invoices i
    SET 
		i.payment_total = payment_amount,
        i.payment_date =payment_date
        WHERE i.invoice_id = invoice_id;
        
END $$
DELIMITER ;

CALL make_payment(2, 100, '2019-01-01');
CALL make_payment(2, -100, '2019-01-01');



DROP PROCEDURE IF EXISTS make_payment;
DELIMITER $$
CREATE PROCEDURE make_payment
(
	invoice_id INT,
    payment_amount DECIMAL(9,2),
    payment_date date
)
BEGIN
	IF payment_amount <= 0 THEN
		SIGNAL SQLSTATE '22003'
         SET MESSAGE_TEXT = 'iNVALID PAYMENT AMOUNT';
	END IF;

	UPDATE invoices i
    SET 
		i.payment_total = payment_amount,
        i.payment_date =payment_date
        WHERE i.invoice_id = invoice_id;
        
END $$
DELIMITER ;

CALL make_payment(2, 100, '2019-01-01');
CALL make_payment(2, -100, '2019-01-01');




DROP PROCEDURE IF EXISTS get_unpaid_invoices_for_client;
DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices_for_client
(
	client_id INT
)
BEGIN
	SELECT COUNT(*) ,SUM(INVOICE_TOTAL)
    FROM invoices i
    WHERE i.client_id = client_id
		AND payment_total = 0;

        
END $$
DELIMITER ;

CALL get_unpaid_invoices_for_client(2);




DROP PROCEDURE IF EXISTS get_unpaid_invoices_for_client;
DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices_for_client
(
	client_id INT,
    OUT invoices_count INT,
    OUT invoices_total DECIMAL(9,2)
)
BEGIN
	SELECT COUNT(*) ,SUM(INVOICE_TOTAL)
    INTO invoices_count,invoices_total
    FROM invoices i
    WHERE i.client_id = client_id
		AND payment_total = 0;

        
END $$
DELIMITER ;

set @invoices_count = 0;
set @invoices_total = 0;
call sql_invoicing.get_unpaid_invoices_for_client
(2, @invoices_count, @invoices_total);
select @invoices_count, @invoices_total;




-- User or session variable 
SET @invoices_count = 0;
-- Local variable



DROP PROCEDURE IF EXISTS get_risk_factor;
DELIMITER $$
CREATE PROCEDURE get_risk_factor()
BEGIN
    DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoice_total DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_count INT DEFAULT 0;

    -- Retrieve the count of invoices and the sum of their totals
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoice_total
    FROM invoices;
    -- Retrieve the count of invoices and the sum of their totals
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoice_total
    FROM invoices;
	SET risk_factor = invoice_total / invoices_count * 5;
	SELECT risk_factor;
END $$
DELIMITER ;

CALL get_risk_factor();



DROP PROCEDURE IF EXISTS get_risk_factor;
DELIMITER $$
CREATE PROCEDURE get_risk_factor()
BEGIN
    DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoice_total DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_count INT DEFAULT 0;

    -- Retrieve the count of invoices and the sum of their totals
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoice_total
    FROM invoices;
    
    -- Check to avoid division by zero
    IF invoices_count > 0 THEN
        SET risk_factor = invoice_total / invoices_count * 5;
    ELSE
        SET risk_factor = 0;
    END IF;

    -- Return the calculated risk factor
    SELECT risk_factor;
END $$
DELIMITER ;

CALL get_risk_factor();

-- Functions can return a single value

DROP FUNCTION IF EXISTS get_risk_factor_for_client;
DELIMITER $$
CREATE FUNCTION get_risk_factor_for_client
(
    client_id INT
)
RETURNS DECIMAL(9,2)
READS SQL DATA
BEGIN
    DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoice_total DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_count INT DEFAULT 0;

    -- Retrieve the count of invoices and the sum of their totals for the specified client
    SELECT COUNT(*), SUM(COALESCE(i.invoice_total, 0))
    INTO invoices_count, invoice_total
    FROM invoices i
    WHERE i.client_id = client_id;

    -- Check to avoid division by zero
    IF invoices_count > 0 THEN
        SET risk_factor = invoice_total / invoices_count * 5;
    ELSE
        SET risk_factor = 0;
    END IF;

    RETURN risk_factor;
END;
$$
DELIMITER $$;
