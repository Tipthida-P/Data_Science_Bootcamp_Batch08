-- Example : select to filter and view data  ------------------------------------------------------------------------------------------
-- Show full name, customer ID, and country for all customers who are in the USA
SELECT 
    firstname,
    lastname,
    customerid, 
    country
FROM customers
WHERE country = 'USA'
ORDER BY country;

-- Show only the customers from Germany
SELECT
    customerid,
    firstname,
    lastname,
    country
FROM customers
WHERE country = 'Germany';

-- How many invoices were there in 2010?
SELECT 
    COUNT(invoiceid) AS 'Sales QTY in 2010' 
FROM invoices
WHERE invoicedate LIKE '%2010%';

-- What are the total sales for 2010?
SELECT
    ROUND(SUM(total), 2) AS 'Total sales in 2010' 
FROM invoices
WHERE invoicedate LIKE '%2010%';

-- Show the total sales by each sales agent
SELECT
    e.firstname,
    e.lastname,
    ROUND(SUM(i.total), 2) AS 'Total sales'
FROM customers AS c
JOIN employees AS e
ON c.supportrepid = e.employeeid
JOIN invoices AS i
ON c.customerid = i.customerid
GROUP BY c.supportrepid
ORDER BY 'Total sales' DESC;