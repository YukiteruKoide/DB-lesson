-- DBの確認、宣言、テーブルの確認
SHOW DATABASES;
USE day_10_14_db;
SHOW TABLES;


/* 
1. employeesテーブルとcustomersテーブルの両方から、それぞれidが10より小さいレコードを取り出します。
両テーブルのfirst_name, last_name, ageカラムを取り出し、行方向に連結します。
連結の際は、重複を削除するようにしてください。
*/

-- employeesテーブルの確認
DESCRIBE employees;
SELECT * FROM employees LIMIT 10;

DESCRIBE customers;
SELECT * FROM customers LIMIT 10;

-- employeesテーブルとcustomersテーブルの両方から、それぞれidが10より小さいレコードを取り出します。
-- 回答　あえてWITHを使ってみた。
WITH emp_top9 AS(
	SELECT * FROM employees 
	WHERE id < 10),
	cus_top9 AS(
	SELECT * FROM customers
	WHERE id < 10)
SELECT first_name, last_name, age
FROM emp_top9
UNION
SELECT first_name, last_name, age
FROM cus_top9
ORDER BY first_name;

-- 普通のやり方
SELECT first_name, last_name, age FROM employees WHERE id < 10
UNION 
SELECT first_name, last_name, age FROM customers WHERE id < 10
ORDER BY first_name ;


/*
2. departmentsテーブルのnameカラムが営業部の人の、月収の最大値、最小値、平均値、合計値を計算してください。
employeesテーブルのdepartment_idとdepartmentsテーブルのidが紐づけられ
salariesテーブルのemployee_idとemployeesテーブルのidが紐づけられます。
月収はsalariesテーブルのpaymentカラムに格納されています
*/

-- 前処理
DESCRIBE departments;
SELECT * FROM departments;

DESCRIBE employees;
SELECT * FROM employees; 

DESCRIBE salaries;
SELECT * FROM salaries
ORDER BY employee_id; -- 1年間の給料が入っているように見える

/* 外部キー
 * manager_id：自己結合
 * department_id：epartmentsテーブルのidと紐付けられる
 * salariesテーブルのemployee_idとemployeesテーブルのidが紐づけられる。
 */　


-- 営業部の人のみを抽出
SELECT emp.id FROM employees AS emp
INNER JOIN departments AS dep
ON emp.department_id = dep.id
WHERE emp.department_id  = 2;

-- salaryテーブルの営業部の人のみを抽出
SELECT * FROM salaries
WHERE employee_id IN(
	SELECT emp.id FROM employees AS emp
	INNER JOIN departments AS dep
	ON emp.department_id = dep.id
	WHERE emp.department_id  = 2
	)
;

-- departmentsテーブルのnameカラムが営業部の人の、月収の最大値、最小値、平均値、合計値を計算してください。
SELECT MAX(sal.payment), MIN(sal.payment),AVG(sal.payment),SUM(sal.payment) FROM salaries AS sal
WHERE employee_id IN(
	SELECT emp.id FROM employees AS emp
	INNER JOIN departments AS dep
	ON emp.department_id = dep.id
	WHERE emp.department_id  = 2
	)
;





/*
3. classesテーブルのidが、5よりも小さいレコードとそれ以外のレコードを履修している生徒の数を計算してください。
classesテーブルのidとenrollmentsテーブルのclass_id、enrollmentsテーブルのstudent_idとstudents.idが紐づく
classesにはクラス名が格納されていて、studentsと多対多で結合される
*/

-- 前処理
DESCRIBE classes;
SELECT * FROM classes;

DESCRIBE enrollments;
SELECT * FROM enrollments;

DESCRIBE students;
SELECT * FROM students;

-- 結合して見やすくする
SELECT * FROM enrollments AS enr
INNER JOIN students AS stu
ON enr.student_id = stu.id
INNER JOIN classes AS cla
ON enr.class_id = cla.id
;

-- classesテーブルのidが、5よりも小さいレコードとそれ以外のレコードを履修している生徒の数を計算
SELECT 
	CASE 
		WHEN cla.id < 5 THEN "クラス1"
		ELSE "クラス2"
	END AS "クラス分類",
	COUNT(*)
FROM enrollments AS enr
	INNER JOIN students AS stu
	ON enr.student_id = stu.id
	INNER JOIN classes AS cla
	ON enr.class_id = cla.id
GROUP BY 
	CASE 
		WHEN cla.id < 5 THEN "クラス1"
		ELSE "クラス2"
	END;




/*
4. ageが40より小さい全従業員で月収の平均値が7,000,000よりも大きい人の、月収の合計値と平均値を計算してください。
employeesテーブルのidとsalariesテーブルのemployee_idが紐づけでき、salariesテーブルのpaymentに月収が格納されています
*/

-- 前処理
DESCRIBE employees ;
SELECT * FROM employees ;

DESCRIBE salaries;
SELECT * FROM salaries 
ORDER BY employee_id ;

-- 実験
SELECT * FROM employees
WHERE age < 40 ;

SELECT employee_id ,AVG(payment) 
FROM salaries 
GROUP BY employee_id ;

-- ageが40より小さい全従業員で月収の平均値が7,000,000よりも大きい人の、月収の合計値と平均値を計算

SELECT emp.id,SUM(sal.payment),AVG(sal.payment) 
FROM employees AS emp
INNER JOIN salaries AS sal
ON emp.id = sal.employee_id
WHERE emp.age < 40
GROUP BY emp.id
HAVING AVG(sal.payment) > 7000000
;



/*
5. customer毎に、order_amountの合計値を計算してください。
customersテーブルとordersテーブルは、idカラムとcustomer_idカラムで紐づけができます
ordersテーブルのorder_amountの合計値を取得します。
SELECTの対象カラムに副問い合わせを用いて値を取得してください。
*/

-- 前処理
DESCRIBE customers;
SELECT * FROM customers;

DESCRIBE orders;
SELECT COUNT(*) FROM orders;
SELECT * FROM orders LIMIT 100;

-- customer毎に、order_amountの合計値を計算
SELECT 
	*,
	(SELECT SUM(order_amount) FROM orders AS od
	WHERE od.customer_id =cus.id ) AS sum_order_amount
FROM customers AS cus;


/*
6. customersテーブルからlast_nameに田がつくレコード、
ordersテーブルからorder_dateが2020-12-01以上のレコード、
storesテーブルからnameが山田商店のレコード同士を連結します
customersとorders, ordersとitems, itemsとstoresが紐づきます。
first_nameとlast_nameの値を連結(CONCAT)して集計(GROUP BY)し、そのレコード数をCOUNTしてください。
*/

SELECT * FROM customers AS cst
WHERE last_name LIKE "%田%";

SELECT * FROM orders AS odr
WHERE order_date >= "2020-12-01";

SELECT * FROM stores
WHERE name = "山田商店";

SELECT CONCAT(cst.first_name,cst.last_name), COUNT(*) FROM orders AS odr
INNER JOIN customers AS cst
ON odr.customer_id = cst.id
INNER JOIN items AS itm
ON odr.item_id = itm.id 
INNER JOIN stores AS str
ON itm.store_id = str.id 
WHERE cst.last_name LIKE "%田%"
AND odr.order_date >= "2020-12-01"
AND str.name = "山田商店"
GROUP BY CONCAT(cst.first_name,cst.last_name)
;



/*
7. salariesのpaymentが9,000,000よりも大きいものが存在するレコードを、employeesテーブルから取り出してください。
employeesテーブルとsalariesテーブルを紐づけます。
EXISTSとINとINNER JOIN、それぞれの方法で記載してください
*/
-- IN
SELECT * FROM employees
WHERE id IN(SELECT employee_id FROM salaries WHERE payment > 9000000);

-- INNER JOIN_1
SELECT emp.id,emp.first_name ,emp.last_name FROM employees AS emp
INNER JOIN salaries AS slr
ON emp.id = slr.employee_id
WHERE slr.payment > 9000000
GROUP BY emp.id;

-- INNER JOIN_2
SELECT DISTINCT emp.* FROM employees AS emp
INNER JOIN salaries AS slr
ON emp.id = slr.employee_id
WHERE slr.payment > 9000000;

-- EXISTS
SELECT * FROM employees AS emp
WHERE 
	EXISTS(
	SELECT 
		1
	FROM
		salaries AS sa
	WHERE emp.id = sa.employee_id AND sa.payment > 9000000	
	) 
;


/*
8. employeesテーブルから、salariesテーブルと紐づけのできないレコードを取り出してください。
EXISTSとINとLEFT JOIN、それぞれの方法で記載してください
*/
-- テーブルの定義、内容確認
DESCRIBE salaries;
SELECT * FROM salaries;


-- IN
SELECT * FROM employees AS emp
WHERE emp.id NOT IN (SELECT sa.employee_id FROM salaries AS sa);


-- LEFT JOIN
SELECT * FROM employees AS emp
LEFT JOIN salaries AS sa 
ON emp.id = sa.employee_id 
WHERE sa.id IS NULL
;


-- EXISTS
 SELECT * FROM employees AS emp
WHERE 
	NOT EXISTS(
		SELECT 
			1
		FROM
			salaries AS sa
		WHERE sa.employee_id = emp.id 
	)
; 


/*
9. employeesテーブルとcustomersテーブルのage同士を比較します
customersテーブルの最小age, 平均age, 最大ageとemployeesテーブルのageを比較して、
employeesテーブルのageが、最小age未満のものは最小未満、最小age以上で平均age未満のものは平均未満、
平均age以上で最大age未満のものは最大未満、それ以外はその他と表示します
WITH句を用いて記述します
*/

WITH customers_age AS(
	SELECT MIN(age) AS MIN_age,AVG(age) AS AVG_age,MAX(age) AS MAX_Age FROM customers
)
SELECT 
	*,
	CASE
		WHEN emp.age < ca.MIN_age THEN "最小未満"
		WHEN emp.age < ca.AVG_age THEN "平均未満"
		WHEN emp.age < ca.MAX_age THEN "最大未満"
		ELSE "その他"
	END AS "OUTPUT"	
FROM 
	employees AS emp
CROSS JOIN customers_age AS ca;


/*
10. customersテーブルからageが50よりも大きいレコードを取り出して、ordersテーブルと連結します。
customersテーブルのidに対して、ordersテーブルのorder_amount*order_priceのorder_date毎の合計値。
合計値の7日間平均値、合計値の15日平均値、合計値の30日平均値を計算します。
7日間平均、15日平均値、30日平均値が計算できない区間(対象よりも前の日付のデータが十分にない区間)は、空白を表示してください。
*/

-- 下準備
DESCRIBE orders;
SELECT COUNT(*) FROM orders;

SELECT * FROM orders
ORDER BY customer_id, order_date 
LIMIT 200;

SELECT customer_id ,COUNT(customer_id) FROM orders AS odr
GROUP BY customer_id;

-- 問題に着手
SELECT * FROM customers AS cst
WHERE age > 50;


