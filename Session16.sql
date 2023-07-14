SHOW DATABASES;
USE day_10_14_db;

SELECT * FROM employees AS emp; 

-- UPDATE　更新したいテーブル　SET　更新したい列　＝　更新する値
UPDATE employees SET age = age+1 WHERE id = 1;

SELECT *FROM employees AS emp
WHERE department_id = 
(SELECT id FROM departments AS dpt WHERE name = "営業部");


UPDATE employees AS emp
SET emp.age = emp.age + 2
WHERE department_id = 
(SELECT id FROM departments AS dpt WHERE name = "営業部");


-- INNER JOIN
SELECT * FROM employees;

ALTER TABLE employees 
ADD department_name VARCHAR(255);

-- LEFT JOIN
SELECT emp.*,COALESCE(dt.name,"不明")  FROM employees AS emp
LEFT JOIN departments AS dt
ON emp.department_id = dt.id ;

UPDATE 
employees AS emp
LEFT JOIN departments AS dt
ON emp.department_id = dt.id
SET emp.department_name = COALESCE(dt.name,"不明")


 -- WITHを使ったUPDATE
SELECT * FROM stores;

ALTER TABLE stores 
ADD all_sales INT;

SELECT * FROM stores;
SELECT * FROM items;
SELECT * FROM orders;

WITH tmp_sales AS (
	SELECT 
		it.store_id ,
		SUM(od.order_amount * od.order_price) AS summary
	FROM items AS it
	INNER JOIN orders AS od 
	ON it.store_id = od.item_id
	GROUP BY it.store_id 
	ORDER BY it.store_id
)
UPDATE stores as st
-- SELECT * FROM stores as st
INNER JOIN tmp_sales AS ts 
ON st.id = ts.store_id
SET st.all_sales = ts.summary
;

-- DELETE 
DELETE FROM employees
WHERE department_id IN(
	SELECT id FROM departments WHERE name = "開発部"
);

SELECT * FROM employees;


-- INSERT

CREATE TABLE customer_orders(
	name VARCHAR(255),
	order_date DATE,
	sales INT,
	total_sales INT
);



INSERT INTO customer_orders
	SELECT 
	 	CONCAT(cst.first_name,cst.last_name) AS name , 
	 	od.order_date,
	 	od.order_amount * od.order_price,
	 	SUM(od.order_amount*od.order_price) OVER(PARTITION BY CONCAT(cst.first_name,cst.last_name) ORDER BY od.order_date)
	 FROM customers AS cst
	 INNER JOIN orders AS od 
	 ON cst.id = od.customer_id 
;

SELECT * FROM customer_orders;


-- NOT NULL制約
SHOW DATABASES;
CREATE DATABASE day_15_18_db;
USE day_15_18_db;

SHOW TABLES;
CREATE TABLE users(
	id INT PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255) DEFAULT '' NOT NULL
);

INSERT INTO users(id) VALUES(1);
SELECT * FROM users;


-- UNIQUE
CREATE TABLE login_users(
	id INT PRIMARY KEY,	
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO login_users VALUES(1,"Shingo","abc@mail.com");
INSERT INTO login_users VALUES(2,"Shingo","abc@mail.com");

CREATE TABLE tmp_names(
	name VARCHAR(255) UNIQUE
);

INSERT INTO tmp_names VALUES(NULL);
SELECT * FROM tmp_names;


-- CHECK制約
CREATE TABLE customers(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	age INT CHECK(age >= 20)
);

INSERT INTO customers VALUES(1,"Taro",21);
INSERT INTO customers VALUES(2,"Taro",19);

-- 複数のカラムに関するCHECK制約
CREATE TABLE students(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	age INT ,
	gender CHAR(1),
	CONSTRAINT chk_students CHECK((age >= 15 AND age <= 20) AND (gender = "F" OR gender = "M"))
);

INSERT INTO students VALUES(1,"Taro",18,"M");
INSERT INTO students VALUES(3,"Taro",14,"M");
INSERT INTO students VALUES(NULL,"Taro",14,"M");

CREATE TABLE employee(
	company_id INT,
	employee_code CHAR(8),
	name VARCHAR(255),
	age INT,
	PRIMARY KEY(company_id,employee_code)
)
;

INSERT INTO employee VALUES
(NULL,"00000001","Taro",19);