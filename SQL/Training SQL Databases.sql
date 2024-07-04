/* 
Usage "Chinook.db" database
*/

-- SELECT ----------------------------------------------------------------------------------------------------------------------------------
SELECT 
    firstname, 
    lastname, 
    country,
    email,
    phone
FROM customers;
 
SELECT
    country,
    COUNT(*) AS Count_Customers
FROM customers
GROUP BY country
ORDER BY 2 DESC
LIMIT 5

SELECT 
	firstname, 
    lastname, 
    firstname || " " ||  lastname as Fullname
FROM customers;

SELECT 
	name,
   	ROUND(milliseconds/60000.0,2) as Mins,
   	ROUND(bytes/(1024*1024.0),4) as MBs
FROM tracks;

SELECT 
	*
FROM customers
WHERE LOWER(country) in ("belgium","brazil")
	AND firstname NOT like "A%"; -- if "_" match single charecter
    
SELECT name, bytes
FROM tracks
WHERE milliseconds/60000 > 3;

SELECT 
	invoicedate,
    -- CAST(col AS int)
	STRFTIME("%Y",invoicedate) as Year,
    STRFTIME("%m",invoicedate) as Month,
    STRFTIME("%Y-%m",invoicedate) as MonthID,
    STRFTIME("%d",invoicedate) as Day,
    billingaddress
FROM invoices
WHERE monthid= "2010-03";

-- AGGREGATE FUNCTIONS -----------------------------------------------------------------------------------------------------------
SELECT 
	COUNT(*) as n_tracks,
    AVG(bytes) as avg_bytes ,
    SUM(bytes) AS sum_bytes,
    MIN(bytes) as min_bytes,
    MAX(bytes) as max_bytes
FROM tracks;

SELECT 
	COUNT(*) AS TTL, 
    COUNT(company) as B2B,
    COUNT(*)-COUNT(company)  as B2C
FROM customers

SELECT
	country,
    COUNT(firstname) as "Count_N"
FROM customers
group by country
HAVING count_n >=5
ORDER by count_n DESC

SELECT *
FROM customers
WHERE company is NOT NULL

-- GROUP BY  -----------------------------------------------------------------------------------------------------------------------------
SELECT g.Name , COUNT(*) as 'Count Song'
from genres as g, tracks as t
WHERE g.genreid=t.genreid
GROUP by g.name
HAVING COUNT(*) >= 100;

-- ORDER BY  -----------------------------------------------------------------------------------------------------------------------------
SELECT * FROM customers ORDER BY country DESC;

SELECT g.Name , COUNT(*) as 'Count Song'
from genres as g, tracks as t
WHERE g.genreid=t.genreid
GROUP by g.name
ORDER BY COUNT(*) DESC limit 5;

-- JOIN TABLES  --------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM artists
JOIN albums 
on artists.ArtistId = albums.ArtistId;

SELECT 
	A.Name,
    B.Title
FROM artists as A
JOIN albums  as B
on A.ArtistId = B.ArtistId;

CREATE VIEW Artists_details as 
SELECT 
	A.ArtistId,
	A.Name,
    B.Title,
    C.Name as "Song name",
    C.Composer,
    C.Bytes/(1024*1024) as MBs
FROM artists as A
JOIN albums  as B
	on A.ArtistId = B.ArtistId
JOIN tracks as C 
	on B.AlbumId = C.AlbumId;
    
SELECT *
from Artists_details;

-- SUB QUERY  ---------------------------------------------------------------------------------------------------------------------------
SELECT firstname 
FROM
	(SELECT *
	FROM customers);
    
SELECT email 
from
    (SELECT * 
    FROM customers
    WHERE country = "USA")
	AS usa_customers
WHERE email LIKE "%gmail.com";

SELECT sub1.firstname, sub2.total
from
    (SELECT * 
    FROM customers
    WHERE country = "USA")
	AS sub1
JOIN 
	(SELECT * 
     from invoices
    WHERE invoicedate LIKE "2009%")
    AS sub2
on sub1.customerid = sub2.customerid;

-- Common table expression -> WITH  ----------------------------------------------------------------------------------------------
WITH sub1 AS (SELECT * 
    FROM customers
    WHERE country = "USA"),
    sub2  AS (SELECT * 
    from invoices
    WHERE invoicedate LIKE "2009%")
SELECT sub1.firstname, sub2.total
from sub1
JOIN sub2
on sub1.customerid = sub2.customerid;