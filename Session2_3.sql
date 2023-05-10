USE my_db;

SELECT DATABASE();

#テーブル一覧
SHOW tables;

#テーブル名の変更
ALTER table users rename to users_table;

describe users_table;

#カラムの削除
ALTER TABLE users_table drop column message; 

#カラムの追加(ADD)
ALTER TABLE users_table
ADD post_code CHAR(8);

#カラムの追加(ADD)
ALTER TABLE users_table
ADD gender CHAR(1) AFTER age;

#一番最初のカラム
ALTER TABLE users_table
add new_id int first;

ALTER table users_table
drop column new_id;

#カラムの定義変更
alter table users_table modify name varchar(50);

#カラムの名前変更
ALTER table users_table change column 名前 name varchar(50);

alter table users_table change column gender gender char(1) after post_code;

#主キーの削除
alter table users_table drop primary key;