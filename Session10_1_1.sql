-- お決まりのおまじない
SHOW DATABASES;
USE day_4_9_db;

-- テーブルの確認
SHOW TABLES;

-- UNION：重複は削除される
SELECT * FROM new_students
UNION
SELECT * FROM students
ORDER BY id DESC
;

-- UNION ALL：重複は削除されない
SELECT * FROM new_students
UNION ALL
SELECT * FROM students
ORDER BY id
;

-- 絞り込んでくっつける
SELECT * FROM students WHERE id < 10
UNION ALL
SELECT * FROM students WHERE id> 250;

SELECT id,name FROM students WHERE id <10
UNION
SELECT age,name FROM users WHERE id <10
ORDER BY id;




/*SUM,AVERAGE,etc.*/
SELECT * FROM customers WHERE name IS NULL;

-- COUNT
SELECT COUNT(*) FROM customers; -- 何行データが入っているか
SELECT COUNT(name) FROM customers; -- 列指定（この列に何行入っているか(NULLはカウントしない)）

-- MAX
SELECT MAX(age),MIN(age) FROM users WHERE birth_place = "日本";
SELECT MAX(birth_day),MIN(birth_day) FROM users WHERE birth_place = "日本";

-- SUM
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees; 

-- AVG NULLの場合が面倒
CREATE TABLE tmp_count_20230510(
 num INT
);

INSERT INTO tmp_count_20230510 VALUES(1);
INSERT INTO tmp_count_20230510 VALUES(2);
INSERT INTO tmp_count_20230510 VALUES(3);
INSERT INTO tmp_count_20230510 VALUES(NULL);

SELECT * FROM tmp_count_20230510;

-- NULLは飛ばされる
SELECT AVG(num) FROM tmp_count_20230510;

-- NULLも数える場合は以下
SELECT AVG(COALESCE(num,0)) FROM tmp_count_20230510;



-- GROUP BY
SELECT birth_place,AVG(age) FROM users
GROUP BY birth_place;

SELECT age,COUNT(age),MAX(birth_day),MIN(birth_day) FROM users
WHERE birth_place = "日本"
GROUP BY age
ORDER BY age;

SELECT department,COUNT(*),ROUND(AVG(salary))  FROM employees
WHERE age > 40
GROUP BY department
;

SELECT
	CASE
		WHEN birth_place = "日本" THEN "日本人"
		ELSE "その他"
	END AS "国籍",
	COUNT(*)
FROM users
GROUP BY 
	CASE
		WHEN birth_place = "日本" THEN "日本人"
		ELSE "その他"
	END;

SELECT 	CASE
		WHEN name IN("愛媛県","香川県","徳島県","高知県") THEN "四国"
		ELSE "その他"
	END AS "地域",
	COUNT(*) AS "県数"
FROM prefectures
GROUP BY 
	CASE
		WHEN name IN("愛媛県","香川県","徳島県","高知県") THEN "四国"
		ELSE "その他"
	END
;

SELECT
	CASE 
		WHEN age>=20 THEN "成人"
		ELSE "未成年"
	END AS "成人か否か",
	COUNT(*) 
FROM users
GROUP BY
	CASE 
		WHEN age>=20 THEN "成人"
		ELSE "未成年"
	END
;



-- HAVING
SELECT department,AVG(salary) FROM employees
GROUP BY department
HAVING AVG(salary)>3980000;

SELECT birth_place ,age ,COUNT(*) FROM users
GROUP BY birth_place ,age
HAVING COUNT(*)>2 
ORDER BY birth_place, age 
;
