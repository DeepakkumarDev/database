use sql_invoicing;
CREATE VIEW sales_by_client AS
SELECT 	
	c.client_id,
    c.name,
    sum(invoice_total) as total_sales
FROM clients c
join invoices i using (client_id)
group by client_id,name;

select *
from sales_by_client
order by total_sales desc;

SELECT *
FROM sales_by_client
WHERE total_sales > 500;


SELECT *
FROM sales_by_client
JOIN clients USING(client_id);



show tables;
-- create a view to see the balance
-- for each client
-- 
-- clients_balance
-- client_id
-- name
-- balance

CREATE VIEW clients_balance AS
SELECT 
	c.client_id,
    c.name,
    sum(invoice_total-payment_total) as balance
FROM clients c
JOIN invoices i USING(client_id)
GROUP BY client_id,name;


select *
from clients_balance;


DROP VIEW sales_by_client;


select * from sales_by_client;



CREATE OR REPLACE VIEW sales_by_client AS
SELECT 	
	c.client_id,
    c.name,
    sum(invoice_total) as total_sales
FROM clients c
join invoices i using (client_id)
group by client_id,name;



CREATE OR REPLACE VIEW sales_by_client AS
SELECT 	
	c.client_id,
    c.name,
    sum(invoice_total) as total_sales
FROM clients c
join invoices i using (client_id)
group by client_id,name
ORDER BY total_sales DESC;



SELECT * 
FROM sales_by_client;

-- updatable views

CREATE OR REPLACE VIEW invoices_with_balance as
SELECT
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total-payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total-payment_total) >0;


DELETE FROM invoices_with_balance
WHERE invoice_id=1invoices_with_balance;


UPDATE 	invoices_with_balance
SET due_date = DATE_ADD(due_date,INTERVAL 2 DAY)
WHERE invoice_id = 2;

-- The with option check clause

UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 2;


CREATE OR REPLACE VIEW invoices_with_balance as
SELECT
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total-payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total-payment_total) >0
WITH CHECK OPTION;

UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 3;

-- IMPORTANCE OF VIEWS
-- SIMPLIFY QUERIES
-- REDUCE THE IMPACT OF CHANGES
--  VIES PROVIDE ABSTRACTION OVER THE DATABASES 
-- RESTRICT ACCESS TO TH DATA FRO EXAMPLE
-- 