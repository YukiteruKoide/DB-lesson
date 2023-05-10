SHOW DATABASES;
USE day_4_9_db;

UPDATE customers SET age = 44 WHERE id = 2;


UPDATE customers SET age = 44 WHERE id = 1;

SELECT * FROM customers WHERE id = 1 FOR SHARE;


SELECT * FROM customers;

UPDATE customers SET age =42 WHERE id =1; 

-- DEAD LOCK
START TRANSACTION;

-- users → customres  
UPDATE users SET age = 12 WHERE id = 1;
UPDATE customers SET age = 40 WHERE id = 1;
