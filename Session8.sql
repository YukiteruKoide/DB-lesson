-- 演習前準備
SHOW DATABASES;
USE day_4_9_db;
SHOW TABLES;


/* 1. customersテーブルから、ageが28以上40以下でなおかつ、nameの末尾が「子」の人だけに絞り込んでください。
 そして、年齢で降順に並び替え、検索して先頭の5件の人のnameとageだけを表示してください。*/

-- cuttomersテーブルの中身確認
-- 定義確認
DESCRIBE customers;

-- データの中身確認
SELECT * FROM customers; -- LIMIT 10;

-- 演習
SELECT name,age FROM customers
WHERE 
	age BETWEEN 28 AND 40
AND 
	name LIKE "%子"
ORDER BY age DESC
LIMIT 5;




/*
2. receiptsテーブルに、「customer_idが100」「 store_nameがStore X」「priceが10000」のレコードを挿入してください。
*/

-- receiptsテーブルの詳細
DESCRIBE receipts;

SELECT * FROM receipts 
ORDER BY id ;

-- INSERTの実施
INSERT INTO receipts(id, customer_id, store_name,price) VALUES(301,100,"storeb X",1000)

SELECT * FROM receipts 
ORDER BY id ;



/*
3. 2で挿入してレコードを削除してください
*/
DELETE FROM receipts 
WHERE id = 301;

SELECT * FROM receipts 
ORDER BY id DESC ;

/*
4. prefecturesテーブルから、nameが「空白もしくはNULL」のレコードを削除してください
*/
-- テーブル情報の確認
DESCRIBE prefectures ;

-- テーブルの中身を確認（上位10件）
SELECT * FROM prefectures 
ORDER BY id 
LIMIT 10;

-- NULL、空白の確認
SELECT * FROM prefectures 
WHERE name IS NULL 
OR 
name = "";

-- nameが「空白もしくはNULL」のレコードを削除
DELETE FROM prefectures 
WHERE name IS NULL 
OR 
name = "";

-- NULL、空白の確認
SELECT * FROM prefectures 
WHERE name IS NULL 
OR 
name = "";



/*
5. customersテーブルのidが20以上50以下の人に対して、年齢を+1してレコードを更新してください
(ただし、BETWEENを使うこと)
*/

-- cuttomersテーブルの中身確認
-- 定義確認
DESCRIBE customers;

-- データの中身確認
SELECT * FROM customers
WHERE id BETWEEN 20 AND 50;

-- UPDATEの実施
UPDATE customers SET age = age+1
WHERE id BETWEEN 20 AND 50;

/*
6. studentsテーブルのclass_noが6の人すべてに対して、1～5のランダムな値でclass_noを更新してください
*/

-- studentsテーブルの確認
DESCRIBE students;

-- 対象（class_no=6）の確認
SELECT * , CEILING(RAND()*5) FROM students
WHERE class_no = 6;

-- UPDATEの実行
UPDATE students SET class_no = CEILING(RAND()*5)
WHERE class_no = 6;

-- 確認
SELECT * FROM students
WHERE class_no = 6;


/*
7. class_noが3または4の人をstudentsテーブルから取り出します。取り出した人のheightに10を加算して、その加算した全値よりも、heightの値が小さくてclass_noが1の人をstudentsテーブルから取り出してください
(ただし、IN, ALLを使うこと)
*/

-- 対象の確認
SELECT * FROM students
WHERE height < ALL(SELECT height+10 FROM students
WHERE class_no IN (3,4))
AND class_no = 1
;	


/*
8. employeesテーブルのdepartmentカラムには、「 営業部 」のような形で部署名の前後に空白が入っています。この空白を除いた形にテーブルを更新してください
*/

-- テーブル定義の確認
DESCRIBE employees ;

-- テーブルの行数の確認
SELECT COUNT(id) FROM employees;

-- テーブルのサンプルの確認
SELECT * FROM employees LIMIT 10;

-- NULL、スペースの確認
 -- NULLはなし
 -- 前方スペース
SELECT * FROM employees 
WHERE department LIKE " %";

 -- 後方スペース
SELECT * FROM employees
WHERE department LIKE "% "

/*結論：前方、後方にスペースがある*/
-- TRIMの実施
SELECT * , TRIM(department) FROM employees;
UPDATE employees SET department = TRIM(department);


/*
9. employeesテーブルからsalaryが5000000以上の人のsalaryは0.9倍して、5000000未満の人のsalaryは1.1倍して下さい。
(ただし、小数点以下は四捨五入します)
*/

-- 対象の確認
SELECT *, ROUND(salary*0.9) AS new_salary FROM employees
WHERE salary >= 5000000
;

SELECT *, ROUND(salary*1.1) AS new_salary FROM employees
WHERE salary < 5000000
;

UPDATE employees 
SET salary = CASE
		WHEN salary >= 5000000 THEN ROUND(salary*0.9)
		WHEN salary < 5000000 THEN ROUND(salary*1.1)
	END
;
	



/*
10. customersテーブルにnameが「名無権兵衛」、ageが0、birth_dayが本日日付の人を挿入してください。
（ただし、日付関数を使うこと）
*/

-- テーブルの定義確認
DESCRIBE customers;

-- サンプルの表示（上位10件）
SELECT * FROM customers LIMIT 10;
SELECT COUNT(id) FROM customers; 

-- INSERTの実施
INSERT INTO customers(id, name ,age ,birth_day ) VALUES(101,"名無権兵衛",0,CURDATE());
SELECT * FROM customers;


/*
11. customersテーブルに新たなカラムとして、「name_length INT」を作成します
name_lengthカラムをcustomersテーブルの各行の名前の文字数でアップデートしてください
*/
-- テーブルの確認
SELECT * FROM customers;

-- name_length列の追加及び型の指定
ALTER TABLE customers ADD name_length INT;

-- アップデート文の実施
UPDATE customers SET name_length = CHAR_LENGTH(name);
SELECT * FROM customers;



/*
12. tests_scoreテーブルに新たなカラムとして、「score INT」を作成します
scoreカラムに、testsテーブルの各行のtest_score_1, test_score_2, test_score_3から、取り出したNULLでない最初の値で更新します。
ただし取り出したtest_score_〇が、900以上の人は1.2倍して小数点以下を切り捨てて、600以下の人は0.8倍して小数点以下を切り上げてください。
*/

-- tests_scoreテーブルの確認
DESCRIBE tests_score;

-- 件数の確認
SELECT COUNT(id) FROM tests_score;

-- 中身の確認
SELECT * FROM tests_score;

-- scoreカラムの追加






/*
13. employeesテーブルを、 departmentが、マーケティング部 、研究部、開発部、総務部、営業部、経理部の順になるように並び替えて表示してください。
*/