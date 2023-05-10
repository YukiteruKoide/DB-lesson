SHOW TABLES;

DESCRIBE people;

ALTER TABLE people ADD age INT AFTER name;

INSERT INTO people VALUES(1,"John",18,"2001-01-01");
INSERT INTO people VALUES(2,"Alice",15,"2003-01-01");
INSERT INTO people VALUES(3,"Paul",19,"2000-01-01");
INSERT INTO people VALUES(4,"Chris",17,"2001-01-01");
INSERT INTO people VALUES(5,"Vette",20,"2001-01-01");
INSERT INTO people VALUES(6,"Tuyoshi",21,"2001-01-01");

SELECT * from people;

#ageで並び替え
SELECT * FROM people ORDER BY age;
SELECT * FROM people ORDER BY age ASC;
SELECT * FROM people ORDER BY age DESC;

#nameで並び替え
SELECT * FROM people ORDER BY name;
SELECT * FROM people ORDER BY name DESC;

#誕生日で並び替え
SELECT * FROM people ORDER BY birth_day,name;
SELECT * FROM people ORDER BY birth_day,name DESC,age;

#DISTINCT
SELECT DISTINCT birth_day FROM people ORDER BY birth_day;

#DISTINCT　nameとbirth_dayが一緒の人は削除される
SELECT DISTINCT name,birth_day FROM people;

#LIMITは最初の行だけ表示
SELECT id,name,age FROM people LIMIT 2;

#飛ばして表示(3飛ばして2表示)
SELECT * FROM people LIMIT 3,2;
SELECT * FROM people LIMIT 2 OFFSET 3;




