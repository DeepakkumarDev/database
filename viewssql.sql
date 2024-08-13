use sql_invoicing;

-- select
-- 	c.client_id,
--     c.name,
--     sum(invoice_total) as total_sales
-- from clients c
-- join invoices i using (client_id)
-- group by cleint_id,name;

create view sales_by_client as 
SELECT
    c.client_id,
    c.name,
    SUM(i.invoice_total) AS total_sales
FROM clients c
JOIN invoices i ON c.client_id = i.client_id
GROUP BY c.client_id, c.name;

select *
from sales_by_client
order by total_sales desc; -- sales_by_clientsales_by_client