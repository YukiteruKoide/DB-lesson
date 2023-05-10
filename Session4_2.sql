SELECT DATABASE();

DESCRIBE customers;

-- NULLの抽出
SELECT * FROM customers WHERE name is NULL;	
SELECT * FROM customers WHERE name IS NOT NULL;

-- 空白の抽出
SELECT * FROM prefectures;
SELECT * FROM prefectures WHERE name = "";


-- BETWEEN
SELECT * FROM users WHERE age BETWEEN 5 AND 10;
SELECT * FROM users WHERE age NOT BETWEEN 5 AND 10;

-- LIKE, NOT LIKE
SELECT * FROM users WHERE name LIKE "村%"; -- 前方一致
SELECT * FROM users WHERE name LIKE "%郎"; -- 後方一致
SELECT * FROM users WHERE name LIKE "%a%"; -- 中間一致
SELECT * FROM prefectures WHERE name LIKE "福_県"; -- _は任意の一文字




