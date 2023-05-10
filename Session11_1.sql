-- DBのリストア
SHOW DATABASES;
CREATE DATABASE day_10_14_db;
USE day_10_14_db;
SHOW TABLES;


-- テーブルに別名をつける
SELECT 
	cs.id,
	cs.name
FROM
	classes AS cs
;


-- 副問い合わせ:4　FROMで用いる

SELECT
MAX(avg_age) AS "部署ごとの平均年齢の最大"
FROM
(SELECT department_id,AVG(age) AS avg_age FROM employees GROUP BY department_id) AS tmp_emp;

-- 年代の集計
SELECT FLOOR(age/10) *10, COUNT(*) FROM employees
GROUP BY FLOOR(age/10);
