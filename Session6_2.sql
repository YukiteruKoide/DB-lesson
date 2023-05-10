-- お決まり
SHOW DATABASES;
USE day_4_9_db;
SHOW TABLES;

-- LENGTH,CHAR_LENGTH
SELECT LENGTH("ABC");
SELECT LENGTH("あいうえお"); -- 一文字、３バイト
SELECT LENGTH(name) FROM users; 

SELECT CHAR_LENGTH("ABC");
SELECT CHAR_LENGTH("あいうえお") AS length ; -- 文字数
SELECT name,CHAR_LENGTH(name) FROM users; 


-- TRIM,LTRIM,RTRIM　空白削除
SELECT LTRIM("   ABC   ");
SELECT RTRIM("   ABC   ") AS a;
SELECT TRIM("   ABC   ") AS a;

SELECT name,CHAR_LENGTH(name) AS name_length 
FROM employees 
WHERE CHAR_LENGTH(name) <> CHAR_LENGTH(TRIM(name));

-- UPDATEして空白を削除したものにする
UPDATE employees 
SET name = TRIM(name)
WHERE CHAR_LENGTH(name)<>CHAR_LENGTH(TRIM(name)) 

-- REGEXP_REPLACE
SELECT REPLACE("I like an apple","apple","lemon");

SELECT * FROM users;
SELECT REPLACE(name,"Mrs","Ms") FROM users WHERE name LIKE "Mrs%";
UPDATE users SET name = REPLACE(name,"Mrs","Ms") WHERE name LIKE "Mrs%";

-- UPPER LOWER(大文字、小文字)
SELECT UPPER("apple");
SELECT LOWER("APPLE");
SELECT name,UPPER(name),LOWER(name) FROM users;

-- SUBSTRING　一部の取り出し
SELECT SUBSTRING(name,2,3) ,name FROM employees; 
SELECT * FROM employees WHERE SUBSTR(name,2,1)="田"; 

-- REVERSE：逆順
SELECT REVERSE(name),name FROM employees;


