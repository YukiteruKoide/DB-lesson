SHOW TABLES;

#全レコードを表示
SELECT * FROM people;

#カラムの一部を表示
SELECT name,id,birth_day,name FROM people

SELECT id AS "番号" ,name AS "名前" FROM people;

#WHERE区
SELECT * FROM people WHERE id < 4;

#UPDATE文
UPDATE people SET birth_day="1900-01-01",name = "";

#UPDATE where
UPDATE people SET name = "Taro",birth_day="2000-01-01" WHERE id = 3;
UPDATE people SET name = "Jiro",birth_day="2000-01-01" WHERE id > 4;

#DELETE：レコード削除
DELETE FROM people WHERE id >4;

DELETE FROM people;



