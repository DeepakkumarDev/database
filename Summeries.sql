-- max()
-- min()
-- avg()
-- sum()
-- count()
show databases;
use invoicing;
show tables;
SELECT 
	MAX(invoice_total) as highest,
    MIN(invoice_total) as lowest,
    AVG(invoice_total) as average,
    COUNT(invoice_total) as total_number_invoices,
    SUM(invoice_total*1.1) as total,
    --COUNT(payment_date) as count_of_payments,
    count(distinct client_id) as total_records
FROM invoices
where invoice_date>'2019-07-01';

-- it will not execur if there is null values in the dataset 


select 
	'first half of 2019' as date_range,
    SUM(invoice_total) as total_sales,
    SUM(payment_total) as total_payments,
    sum(invoice_total-payment_total) as what_we_except
From invoices
Where invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 
	'second half of 2019' AS date_range,
    SUM(invoice_total) as total_sales,
    SUM(payment_total) as total_payments,
    SUM(invoice_total-payment_total) as what_we_expect
FROM invoices
where invoice_date
    between '2019-07-01' AND '2019-12-01'
UNION
SELECT 
	'total' AS date_range,
    SUM(invoice_total) as total_sales,
    SUM(payment_total) as total_payments,
    SUM(invoice_total-payment_total) as what_we_expect
FROM invoices
	where invoice_date
    Between '2019-01-01' AND '2019-12-01';




select
	client_id,
    sum(invoice_total) as total_sales
From invoices
where invoice_date>='2019-07-01'
Group by client_id
order by total_sales desc;

-- select 
-- 	state,
--     city,
--     sum(invoice_total) as total_sales
-- from invoices i
-- join cllients using (client_id)
-- where invoice_date>='2019-07-01'
-- group by state,city
-- order by total_sales desc;



SELECT 
    state,
    city,
    SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c ON i.client_id = c.client_id
-- WHERE invoice_date >= '2019-07-01'
GROUP BY state, city;
-- ORDER BY total_sales DESC;


select 
	client_id,
	sum(invoice_total) as total_sales,
    count(*) as numbers_of_invoices
from invoices 
group by client_id
having total_sales>500;

select 
	client_id,
    sum(invoice_total) as total_sales
from invoices i
join clients c using(client_id)
group by client_id with ROLLUP;



select 
	state,city,
    sum(invoice_total) as total_sales
from invoices i
join clients c using(client_id)
group by state,city with ROLLUP;