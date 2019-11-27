USE sakila;

-- 1. Use SQL to Report Data

SELECT first_name, last_name
FROM actor
WHERE first_name <> 'PENELOPE';

SELECT first_name, last_name
FROM actor
WHERE actor_id < 5;

SELECT * FROM actor
WHERE actor_id < 5
AND actor_id > 3;

-- Usind AND is more recommended because BETWEEN and AND is inclusive. 
-- It's better to stick with using AND like the above one because of the ambiguity.
SELECT * FROM actor
WHERE actor_id BETWEEN 	3 AND 5;

SELECT * FROM actor
WHERE actor_id < 5
OR first_name = 'PENELOPE';

SELECT * FROM actor
WHERE first_name = 'PENELOPE'
OR first_name = 'NICK'
OR first_name = 'ED';

-- This results is same as the above one. 
-- IN statement saves you more time more values you have. 
SELECT * FROM actor
WHERE first_name IN ('PENELOPE', 'NICK', 'ED');

SELECT * FROM actor
WHERE first_name  NOT IN ('PENELOPE', 'NICK', 'ED');

SELECT * FROM actor
WHERE first_name LIKE 'JOHN%';

SELECT * FROM actor
WHERE first_name LIKE 'JA_NE';

SELECT * FROM actor
WHERE first_name LIKE 'JA%NE';

-- This doesn't show anything. 
-- Using wildcard without using the LIKE keyword means that database software takes any special characters to be part of the string. 
SELECT * FROM actor
WHERE first_name IN ('JA%NE', 'JOHN%' );

SELECT * FROM address
WHERE district = 'Buenos Aires'
AND (address LIKE '%El%'
		  OR address LIKE '%Al%'); 

SELECT * FROM address
WHERE district = 'Buenos Aires'
AND address LIKE '%El%'
		  OR address LIKE '%Al%'; 

SELECT first_name, last_name FROM actor
WHERE first_name = 'PENELOPE'
ORDER BY last_name ASC;

SELECT first_name, length(first_name)
FROM actor;

SELECT CONCAT(first_name, ' ', last_name)
FROM actor;

SELECT CONCAT(first_name, ' ', last_name),
LENGTH(CONCAT(first_name, ' ', last_name))
FROM actor
ORDER BY LENGTH(CONCAT(first_name, ' ', last_name)) DESC;

SELECT CONCAT(first_name, ' ', last_name),
LENGTH(CONCAT(first_name, ' ', last_name))
FROM actor
ORDER BY CONCAT(first_name, ' ', last_name) DESC;

SELECT LOWER(first_name)
FROM actor;

SELECT LEFT(first_name, 1),
RIGHT(first_name, 7)
FROM actor;

SELECT LEFT(first_name, 1),
RIGHT(first_name, 7)
FROM actor
WHERE first_name = 'PENELOPE';

SELECT CONCAT(LEFT(first_name, 1),
RIGHT(first_name, 7))
FROM actor
WHERE first_name = 'PENELOPE';

-- This only works for 8 lengths chracters like PENELOPE. 
SELECT CONCAT(LEFT(first_name, 1),
RIGHT(first_name, 7))
FROM actor;

-- This works for any lengths characters
SELECT CONCAT(LEFT(first_name, 1),
LOWER(RIGHT(first_name, LENGTH(first_name)-1)))
FROM actor;
 
-- SUBSTRING(文字列, 開始位置) / SUBSTRING(文字列, 開始位置, 文字数) 
SELECT SUBSTRING(first_name, 1, 1), 
SUBSTRING(first_name, 2)
FROM actor;

SELECT SUBSTRING(first_name, 1, 1), 
SUBSTRING(first_name, -4)
FROM actor;

SELECT CONCAT(SUBSTRING(first_name, 1, 1), 
LOWER(SUBSTRING(first_name, 2)))
FROM actor;

SELECT * FROM film_text;

SELECT description, TRIM(LEADING 'A ' FROM description)
FROM film_text;

-- The LOCATE() function returns the position of the first occurrence of a substring in a string. 
-- If the substring is not found within the original string, this function returns 0. 
-- LOCATE(substring, string, start)
-- Note: This function is equal to the POSITION() function.
SELECT first_name, LOCATE('lope', first_name) FROM actor;

-- This query fails because it doesn't know what len is when it reasches WHERE clause.
-- However, by the time it reaches ORDER BY, it knows what len is. 
SELECT CONCAT(first_name, ' ', last_name) AS name,
LENGTH(CONCAT(first_name, ' ', last_name)) AS len
FROM actor
WHERE len > 17
ORDER BY name ASC;

-- This is tbe correct approach which means copying the original statement 
SELECT CONCAT(first_name, ' ', last_name) AS name,
LENGTH(CONCAT(first_name, ' ', last_name)) AS len
FROM actor
WHERE LENGTH(CONCAT(first_name, ' ', last_name)) > 17
ORDER BY name ASC;

DESCRIBE actor;

-- This shows 0 result because it assume that this mean midnight. 
SELECT * FROM actor
WHERE last_update = '2006-02-15';

-- This shoes all the data for the date because > mwans later than midnight on the same day.
SELECT * FROM actor
WHERE last_update > '2006-02-15';

SELECT * FROM actor
WHERE last_update = '2006-02-15 04:34:33';
 
-- This is easier way 
SELECT * FROM actor
WHERE YEAR(last_update) = 2006;

SELECT * FROM actor
WHERE DATE(last_update) = '2006-02-15';

SELECT date_format(last_update, '%m-%d-%Y')
FROM actor;

SELECT date_format(last_update, '%D %M %Y')
FROM actor;

-- 2. Group your SQL Results
SELECT count(*) FROM address;

SELECT * FROM address;

SELECT count(address2) FROM address;

SELECT district, count(*) AS ct
FROM address
GROUP BY district
ORDER BY ct  DESC;

SELECT district, count(*) AS ct
FROM address
WHERE address_id < 10
GROUP BY district
ORDER BY ct  DESC;

SELECT district, count(*) AS ct
FROM address
GROUP BY district
HAVING count(district) > 8
ORDER BY ct  DESC;

-- Able to use the alias in HAVING
SELECT district, count(*) AS ct
FROM address
GROUP BY district
HAVING ct > 8
ORDER BY ct  DESC;

SELECT * FROM film;

SELECT min(rental_duration) FROM film;

SELECT max(rental_duration) FROM film;

SELECT sum(rental_duration) FROM film;

SELECT avg(rental_duration) FROM film;

SELECT rating, avg(rental_duration) 
FROM film
GROUP BY rating;

SELECT avg(year(last_update)) FROM actor;

-- The DISTINCT clause keeps one row for each group of duplicates.
SELECT DISTINCT district
FROM address;

-- It works with or without () if only one column is selected. 
SELECT DISTINCT(district) 
FROM address;

-- This fails DISTINCT ( column1, column2) *With ()
-- This can works fine DISTINCT column1, column2
SELECT DISTINCT district, address2 
FROM address;

SELECT * FROM rental;

-- How many staff_id do we have? - 2
SELECT DISTINCT staff_id
FROM rental;

-- How many customer do we have? - 599
SELECT DISTINCT customer_id
FROM rental;

-- Which customers had been served by which staff - 1198
-- 599 * 2 = 1198
-- So it means that every customer has been served by both members of staff at some point. (It looks unlikely but this is a sample database)
SELECT DISTINCT staff_id, customer_id
FROM rental;

SELECT DISTINCT CONCAT(first_name, last_update)
FROM actor;

SELECT DISTINCT YEAR(last_update)
FROM actor;

SELECT count(DISTINCT YEAR(last_update))
FROM actor;

SELECT * FROM address;

-- group_concat() is useful when I'm trying to create a data array for another language such as Java script.
-- I can copy and paste these comma separated values into my other languages. 
SELECT distinct district, group_concat(phone)
FROM address
GROUP BY district;

-- Able to change how to separate in Group_concat by using SEPARATOR ''
SELECT distinct district, group_concat(phone ORDER BY phone SEPARATOR ';')
FROM address
GROUP BY district;

-- 3. Merge Data from Multiple Tables 

-- Speed up SQL queries by limiting report size. 
SELECT * FROM payment
LIMIT 25;

DESCRIBE rental;

DESCRIBE inventory;

DESCRIBE customer;

DESCRIBE staff; 			

DESCRIBE store; 

DESCRIBE address;

-- Report of all customers who are living Buenos Aires. 
-- We can't return that data just from the customer table because the customer table doesm't store the address. 
SELECT *
FROM customer 
JOIN address 
ON customer.address_id = address.address_id;

SELECT *
FROM customer c
JOIN address a
ON c.address_id = a.address_id
WHERE district = 'Buenos Aires';

SELECT c.first_name, c.last_name, a.address
FROM customer c
JOIN address a
ON c.address_id = a.address_id
WHERE district = 'Buenos Aires';

SELECT date(last_update) FROM actor;

SELECT date(last_update) FROM address;

-- By default UNION performs a select distinct that it only gives us unique values 
SELECT date(last_update) FROM actor
UNION
SELECT date(last_update) FROM address;

-- If we want to see all values, use UNION ALL instead. 
SELECT date(last_update) FROM actor
UNION ALL
SELECT date(last_update) FROM address;

-- It's clearer now which dates correspond to which tables
SELECT 'actor' as tbl, date(last_update) FROM actor
UNION ALL
SELECT 'address' as tbl, date(last_update) FROM address;

-- Tale care with UNION and  UNION ALL because it tends to mask the true identity of the second set of data. 
-- We can also filter with WHERE clause. 
SELECT 'actor' as tbl, date(last_update) 
FROM actor
UNION 
SELECT 'address' as tbl, city_id 
FROM address
WHERE city_id < 5;

SELECT * FROM actor
WHERE first_name IN ('PENELOPE', 'NICK', 'ED');

-- We can filter from more different tables although it can be slow. 
-- What we can't in this statement is showing results from multiple tables. This one only shows results from rental table.
SELECT * FROM rental
WHERE customer_id IN (
SELECT customer_id FROM customer WHERE  
first_name = 'Jennifer');

-- Subquery 
SELECT f.first_name FROM
(SELECT first_name from actor) AS f;

SELECT f.fn FROM
(SELECT first_name  as fn from actor) AS f;
alter

-- 4. Advanced features 

-- View
SELECT * FROM actor_info;

SHOW CREATE VIEW actor_info;

-- Function
SHOW CREATE FUNCTION inventory_held_by_customer;

SELECT inventory_held_by_customer(2047);

-- This returns null. See inventory_held_by_customer function. 
SELECT inventory_held_by_customer(367);

SELECT email FROM customer
WHERE inventory_held_by_customer(2047) = customer_id;

-- Procedures
SELECT * FROM inventory
WHERE film_id= 2
AND store_id = 2;

-- It's able to use functions within stored procedures, but unable to do the opposite. 
-- We use the call keyword to run a stored procedure.
CALL film_not_in_stock(2, 2, @count);

CALL film_in_stock(2, 2, @count);

