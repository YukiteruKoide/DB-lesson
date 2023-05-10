-- お決まり
SHOW DATABASES;
USE day_4_9_db;
SHOW TABLES;

-- 算術演算子
# +,-,*,/,%
# 足し算
SELECT 1+1;
SELECT name, age+3 AS age_3 FROM users LIMIT 10;

# 引き算
SELECT 10-5;
SELECT name, age-1 AS age_1 FROM users LIMIT 10;
# 日付もたし引きできる
SELECT birth_day,birth_day+3 FROM users;

#掛け算、割り算
SELECT 3*5;
SELECT * FROM employees;
#掛け算
SELECT department,name,salary,salary*1.1 AS salary_next_year FROM employees;
SELECT department,name,salary,salary*0.9 AS salary_next_year FROM employees;

#割り算
SELECT 10/3;
SELECT salary/10 FROM employees;

#mode
SELECT 10 % 3;
SELECT age % 3 FROM users;


-- CONCAT(文字の連結)||
SELECT CONCAT(department, ":",name) AS "部署：名前" FROM employees;
SELECT CONCAT(name,"(",age,")") AS "名前（年齢）" FROM users;

-- NOW,CURDATE,DATE_FORMATS
SELECT NOW(); -- 現在時刻
SELECT NOW(), name,age FROM users;

SELECT CURDATE(); -- 日付

SELECT DATE_FORMAT(NOW(),"%Y/%m/%d %H") 

