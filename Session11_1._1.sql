-- お決まりのおまじない
SHOW DATABASES;
USE day_10_14_db;
SHOW TABLES;

-- テーブル別名をつける
SELECT cs.name FROM classes AS cs;

-- 副問い合わせ
SELECT dep.id FROM departments AS dep
WHERE dep.id IN (1,2);

SELECT * FROM employees 
WHERE department_id 
IN (SELECT dep.id FROM departments AS dep WHERE dep.id IN (1,2));

-- NOT INでも同じようにできる
SELECT 
	* 
FROM 
	employees AS emp
WHERE 
	emp.department_id NOT IN(SELECT dep.id FROM departments AS dep WHERE name NOT IN ("経営企画部"));


SELECT department_id , COUNT(department_id) FROM employees
GROUP BY department_id;


-- 副問い合わせの構文3
SELECT MAX(age) FROM employees;

SELECT * FROM employees WHERE age = (SELECT MAX(age) FROM employees);

-- 副問い合わせの構文4
SELECT 
	MAX(avg_age) AS "部署ごとの平均年齢の最大",
	MIN(avg_age) 
FROM (SELECT department_id, AVG(age) AS avg_age FROM employees GROUP BY department_id) AS tmp_emp;

-- 副問い合わせの構文5
SELECT * FROM  customers;
SELECT * FROM orders;


SELECT 
cs.id,
cs.first_name,
cs.last_name,
(SELECT MAX(order_date) FROM orders AS order_max WHERE cs.id = order_max.customer_id) AS "最近の注文日"
FROM customers AS cs
WHERE cs.id < 10;


-- 副問い合わせ構文6
SELECT * FROM departments WHERE name = "経営企画部";


-- CREATE SELECT INSERT 
SHOW tables;
SELECT * FROM students;

CREATE TABLE tmp_students
SELECT * FROM students;

SELECT * FROM tmp_students;
DESCRIBE tmp_students;

DESCRIBE students ;

DROP TABLE tmp_students;
CREATE TABLE tmp_students
SELECT * FROM students WHERE id< 10;

CREATE TABLE names
SELECT first_name ,last_name FROM students
UNION 
SELECT first_name ,last_name FROM employees
UNION
SELECT first_name ,last_name FROM customers;


SELECT * FROM names;