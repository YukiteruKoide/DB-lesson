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
SELECT * FROM customers AS cus
INNER JOIN orders AS ord 
ON cus.id = ord.customer_id
INNER JOIN items AS itm
ON ord.item_id = itm.id
INNER JOIN stores AS sto
ON itm.store_id = sto.id
WHERE cus.id = 10 AND ord.order_date > "2020-08-01"
ORDER BY cus.id;

-- GROUP BYの紐付け
SELECT * FROM orders;
SELECT * FROM customers AS ct
INNER JOIN 
	(SELECT customer_id,SUM(order_amount*order_price) 
	FROM orders
	GROUP BY customer_id) AS order_summary
ON ct.id = order_summary.customer_id
ORDER BY ct.age
;


-- SELF JOIN(自己結合)
DESCRIBE employees;

SELECT
	emp1.id,
	emp1.first_name,
	emp1.last_name,
	emp1.age,
	emp1.manager_id,
	COALESCE(CONCAT(emp1.last_name,emp1.first_name), "該当なし") AS "部下の名前",
	COALESCE(CONCAT(emp2.last_name,emp2.first_name), "該当なし") AS "上司の名前", 
	emp1.department_id
FROM employees AS emp1
LEFT JOIN employees AS emp2
ON emp1.manager_id = emp2.id;




-- 交差結合(CROSS JOIN)
SELECT * FROM employees AS emp1, employees AS emp2
WHERE emp1.id = 1;

SELECT * FROM employees AS emp1
CROSS JOIN employees AS emp2
ON emp1.id < emp2.id
;


-- 計算結果とCASEで紐付け
SELECT 
* ,
CASE 
	WHEN cs.age > summary_customers.avg_age THEN "◯"
	ELSE "×"
END AS "平均年齢よりも年齢が高いか"
FROM customers AS cs
CROSS JOIN(
SELECT AVG(age) AS avg_age FROM customers
) AS summary_customers;


-- WITH
-- departmentsから営業部の人を取り出して、employeesと結合する

-- 元のテーブルの確認
SELECT * FROM departments;
SELECT * FROM employees;

SELECT * FROM employees as em
INNER JOIN departments as dp
ON em.department_id = dp.id
WHERE dp.name = "営業部"
;

 WITH tmp_departments AS(
	SELECT * FROM departments WHERE name = "営業部"
)
SELECT * FROM employees AS em
INNER JOIN tmp_departments
ON em.department_id = tmp_departments.id
;

-- storesテーブルからid 1,2,3のものを取り出す
-- itemsテーブルと紐付け、itemsテーブルとordersテーブルを紐づける
-- ordersテーブルのorder_amount*order_priceの合計値をstoresテーブルのstore_name毎に集計する

-- 下準備：データの中身の確認
SELECT * FROM stores;
SELECT * FROM items;
SELECT * FROM orders;

WITH tmp_stores AS(
SELECT * FROM stores WHERE id IN (1,2,3)
), tmp_items_orders AS(
	SELECT
		items.id AS item_id,
		tmp_stores.id AS store_id,
		orders.id AS order_id,
		orders.order_amount AS orders_amount,
		orders.order_price AS orders_price,
		tmp_stores.name AS store_name
	FROM tmp_stores
	INNER JOIN items
	ON tmp_stores.id = items.store_id 
	INNER JOIN orders
	ON items.id = orders.item_id
)
SELECT * FROM tmp_items_orders;



-- ORDER BY 
SELECT 
*,
COUNT(*) OVER( ORDER BY age) AS tmp_count
FROM 
employees;

SELECT *, SUM(order_price) OVER(ORDER BY order_date) FROM orders;