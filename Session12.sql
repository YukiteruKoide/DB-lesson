-- お決まり
USE day_10_14_db;
SHOW TABLES;

-- データの中身の確認
SELECT * FROM departments;
SELECT * FROM employees;

-- EXISTS
SELECT * FROM employees AS em
WHERE EXISTS(
SELECT * FROM departments AS dt WHERE em.department_id = dt.id
);

