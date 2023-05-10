
SHOW DATABASES;
USE day_4_9_db;


SELECT * FROM customers WHERE name IS NULL;

-- COUNT
SELECT COUNT(*) FROM customers; -- 何行データが入っているか？
SELECT COUNT(name) FROM customers; -- 列指定（この列に何行入っているか？（NULLはカウントしない））

SELECT COUNT(name) FROM customers WHERE id > 80;


-- MAX,MIN
SELECT MAX(age),MIN(age) FROM users WHERE birth_place ="日本";

SELECT MAX(birth_day),MIN(birth_day) FROM users u ;

SELECT SUM(salary) FROM employees e ;

-- AVG NULLの場合が面倒
CREATE TABLE tmp_count(
 num INT
);


INSERT INTO tmp_count VALUES(1);
INSERT INTO tmp_count VALUES(2);
INSERT INTO tmp_count VALUES(3);
INSERT INTO tmp_count VALUES(NULL);

SELECT * FROM tmp_count;
-- AVGはNULLがスキップされる
SELECT AVG(num) FROM tmp_count;

-- AVGでNULLをカウントする場合は、下記のようにする
SELECT AVG(COALESCE (num,0)) FROM tmp_count;

