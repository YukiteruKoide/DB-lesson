SHOW DATABASES;
USE day_4_9_db;

-- UNION：重複は削除される
SELECT * FROM new_students
UNION
SELECT * FROM students 
ORDER BY id;

-- UNION ALL：重複は削除されない
SELECT * FROM new_students
UNION ALL
SELECT * FROM students
ORDER BY id;

SELECT * FROM students WHERE id < 10
UNION ALL 
SELECT * FROM students WHERE id > 250;

SELECT id,name FROM students WHERE id <10
UNION 
SELECT age,name FROM users WHERE id<10
ORDER BY id;

