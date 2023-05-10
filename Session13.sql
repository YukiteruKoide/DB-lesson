-- お決まり
SHOW DATABASES;
USE day_10_14_db;
SHOW TABLES;

-- テーブル結合：employeeとdepartmentを結合する
SELECT * FROM employees AS emp;
SELECT * FROM departments AS dep;

-- 全カラム
SELECT *
FROM employees AS emp
INNER JOIN departments AS dep
ON emp.department_id = dep.id ;

-- 特定のカラム
SELECT emp.id,emp.first_name,emp.last_name,emp.age,emp.manager_id,dep.name
FROM employees AS emp
INNER JOIN departments AS dep
ON emp.department_id = dep.id ;

-- 複数のレコードで紐付ける
SELECT * FROM students AS st
INNER JOIN users AS us
ON st.first_name = us.first_name AND st.last_name =us.last_name ;

-- =以外で紐づける
SELECT * FROM employees AS emp
INNER JOIN 
	students as std 
ON emp.id < std.id ;

-- LEFT(OOUTER)JOINについて
SELECT emp.id,emp.first_name,emp.last_name,emp.age,emp.manager_id,COALESCE(dep.name,"該当なし")
FROM employees AS emp
LEFT JOIN departments AS dep
ON emp.department_id = dep.id;

-- RIGHT JOIN 
SELECT * FROM enrollments;
SELECT * FROM classes;
SELECT * FROM students AS std;



SELECT * FROM students AS std
LEFT JOIN enrollments AS enr
ON std.id = enr.student_id
LEFT JOIN classes AS cla
ON enr.class_id = cla.id;


SELECT * FROM students AS std
RIGHT JOIN enrollments AS enr
ON std.id = enr.student_id
RIGHT JOIN classes AS cla
ON enr.class_id = cla.id
ORDER BY std.id ;

-- FRLL JOIN
SELECT * FROM students AS std
LEFT JOIN enrollments AS enr
ON std.id = enr.student_id
LEFT JOIN classes AS cla
ON enr.class_id = cla.id
UNION
SELECT * FROM students AS std
RIGHT JOIN enrollments AS enr
ON std.id = enr.student_id
RIGHT JOIN classes AS cla
ON enr.class_id = cla.id;

-- 複雑なJOIN
-- 問い：customers,orders,items,storesを紐づける
SELECT * FROM customers; 
SELECT * FROM orders; -- PK:id, FK:customer_id,item_id
SELECT * FROM items; --  PK:id, FK:store_id
SELECT * FROM stores; -- PK:id, FKはなし

SELECT * FROM customers AS cus
INNER JOIN orders AS ord 
ON cus.id = ord.customer_id
INNER JOIN items AS itm
ON ord.item_id = itm.id
INNER JOIN stores AS sto
ON itm.store_id = sto.id
ORDER BY cus.id;

-- 複雑なJOIN
-- 問い：customers,orders,items,storesを紐づける
-- customerd.id が10でorders.order_date が2020-08-01よりあとい絞り込む

