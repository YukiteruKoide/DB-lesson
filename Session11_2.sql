SHOW TABLES;

SELECT * FROM employees AS em;

-- 部署一覧
SELECT * FROM departments;

-- INで絞り込む
SELECT * FROM employees AS em WHERE department_id IN(1,2); 

-- 副問い合わせを使う
SELECT id FROM departments WHERE name IN ("経営企画部","営業部");
SELECT * FROM employees AS em WHERE department_id IN(SELECT id FROM departments WHERE name IN ("経営企画部","営業部")); 


SELECT * FROM students;
SELECT * FROM users;

-- 副問い合わせ
SELECT * FROM users 
WHERE(first_name,last_name) IN (
SELECT first_name,last_name FROM users
)

SELECT MAX(age) FROM employees;
SELECT * FROM employees WHERE age = (SELECT MAX(age) FROM employees);
