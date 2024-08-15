-- Trigger
-- Ablock of sql code that automatically gets executed 
-- before or after an insert,update or delete statement.

USE sql_invoicing;

DELIMITER $$

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments -- BEFORE INSERT ,AFTER UPDATE,AFTER DELETE 
    FOR EACH ROW --
BEGIN
	UPDATE invoices
	SET payment_total = payment_total + NEW.amount -- OLD.amount
    WHERE invoice_id = NEW.invoice_id ;
END $$

DELIMITER ;




INSERT INTO payments
VALUES (DEFAULT, 5,3,'2019-01-01',10,1);

-- create a trigger that gets fired when we 
-- delete a payment.


DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
	FOR EACH ROW 
BEGIN
	UPDATE invoices
    SET payment_total =payment_total -OLD.amount
    WHERE invoice_id =OLD.invoice_id;
END $$
DELIMITER ;

SELECT * FROM payments;

DELETE 
FROM payments
WHERE payment_id = 10;

SHOW TRIGGERS;

SHOW TRIGGERS LIKE '%payments';

SHOW TRIGGERS LIKE 'payments%';

DROP TRIGGER IF EXISTS payments_after_insert;
DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments -- BEFORE INSERT ,AFTER UPDATE,AFTER DELETE 
    FOR EACH ROW --
BEGIN
	UPDATE invoices
	SET payment_total = payment_total + NEW.amount -- OLD.amount
    WHERE invoice_id = NEW.invoice_id ;
END $$
DELIMITER ;


USE sql_invoicing;

CREATE TABLE payments_audit
(
	client_id 		INT				NOT NULL,
    date			DATE			NOT NULL,
    amount			DECIMAL(9,2)	NOT NULL,  
    action_type		VARCHAR(50)		NOT NULL,
    action_date		DATETIME		NOT NULL
);


DROP TRIGGER IF EXISTS payments_after_insert;
DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments -- BEFORE INSERT ,AFTER UPDATE,AFTER DELETE 
    FOR EACH ROW --
BEGIN
	UPDATE invoices
	SET payment_total = payment_total + NEW.amount -- OLD.amount
    WHERE invoice_id = NEW.invoice_id ;
    
    INSERT INTO payments_audit
    VALUES (NEW.client_id,NEW.date,NEW.amount,'Insert', NOW());
END $$
DELIMITER ;



DROP TRIGGER IF EXISTS payments_after_delete;
DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
	FOR EACH ROW 
BEGIN
	UPDATE invoices
    SET payment_total =payment_total -OLD.amount
    WHERE invoice_id =OLD.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (OLD.client_id,OLD.date,OLD.amount,'Delete', NOW());    
    
END $$
DELIMITER ;


INSERT INTO payments
VALUES (DEFAULT,5,3,'2019-01-01',10,1);

DELETE FROM payments
WHERE payment_id =11;
select * from payments_audit;





-- Events
-- A task (or block of SQL code ) that gets
-- executed according to a schedule

SHOW VARIABLES;

SHOW VARIABLES LIKE 'event%';

SET GLOBAL event_scheduler = ON; -- ON, OFF

DELIMITER $$
CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
	EVERY 1 YEAR STARTS '2019-01-01' ENDS '2019-01-01'
	-- AT '2-10-05-01'
    -- EVERY 2 HOUR
    -- EVERY 2 DAY
DO  BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() -INTERVAL 1 YEAR;
    
    -- DATEADD(NOW(),INTERVAL -1 YAER)
    -- DATESUB(NOW(),INTERVAL 1 YAER)
END $$
DELIMITER ;


DELIMITER $$
CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
    EVERY 1 YEAR
    STARTS '2019-01-01 00:00:00' -- Start date and time of the event
DO
BEGIN
    DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
END $$
DELIMITER ;


SHOW EVENTS;

SHOW EVENTS LIKE 'yearly%';

DROP EVENT IF EXISTS yearly_delete_stale_audit_rows;

DELIMITER $$
ALTER EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
    EVERY 1 YEAR
    STARTS '2024-08-08 00:00:00' -- Start date and time of the event
DO
BEGIN
    DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
END $$
DELIMITER ;


ALTER EVENT yealy_delete_stale_audit_rows ENABLE;
ALTER EVENT yealy_delete_stale_audit_rows DISABLE;