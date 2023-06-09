SHOW DATABASES;
USE day_4_9_db;

START TRANSACTION;
SHOW TABLES;

SELECT * FROM customers;

-- 主キーでUPDATE(行ロック)
UPDATE customers SET age = 43 WHERE id =1;

ROLLBACK;

-- テーブル全体のロック
START TRANSACTION;
UPDATE customers SET age = 42
WHERE id = 1;
-- WHERE name = "河野 文典;"

ROLLBACK;

-- DELETE 
START TRANSACTION;

-- 行ロック
DELETE FROM customers WHERE id = 1;
ROLLBACK;
COMMIT;

-- INSERT 
START TRANSACTION;
INSERT INTO customers VALUES(1,"田中 一郎",21,"1990-10-11");
SELECT * FROM customers;
COMMIT;

-- SELECTのロック
-- FOR SHARE(共有ロック)
-- FOR UPDATE(排他ロック)
START TRANSACTION;
SELECT * FROM customers WHERE id = 1 FOR SHARE;
ROLLBACK;


START TRANSACTION;
SELECT * FROM customers WHERE id = 1 FOR UPDATE;
ROLLBACK;

-- LOCK YABLE READ
LOCK TABLE customers READ;
SELECT * FROM customers;
UNLOCK TABLES;

-- LOCK YABLE WRITE
LOCK TABLE customers WRITE;
SELECT * FROM customers;
UPDATE customers SET age =42 WHERE id =1;
UNLOCK TABLES;

-- DEAD LOCK
START TRANSACTION;
-- customres → users
UPDATE customers SET age = 42 WHERE id = 1;
UPDATE users SET age = 12 WHERE id = 1;
