SELECT DATABASE();
USE my_db;

#studentsテーブルの作成
CREATE table students(
	id int primary key,
	name char(10)
)

#レコードの追加
insert into students values(1,"ABCDEF");
insert into students values(2,"ABCDEF   ");

#char型は末尾のスペースが削除される
SELECT * from students;

#char > varcharに変換
alter table students modify name varchar(10);

#レコードを再度追加。後ろにスペースを付けて
insert into students values(3,"ABCDEF   ");

#insert結果の確認
SELECT * from students;

#長さの確認
SELECT name, CHAR_LENGTH(name) FROM students; 

