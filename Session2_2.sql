USE my_db;

SELECT DATABASE ();

CREATE TABLE users(
	id INT, #idカラムINT型
	name VARCHAR(10), #名前、可変長文字
	age int,
	phone_number char(13),#固定長
	message text
)

#テーブル一覧の表示
SHOW TABLES;

#テーブルの定義確認
describe users;

#テーブルの削除
DROP TABLE users;

SHOW TABLES;

#主キーを追加
CREATE TABLE users(
	id INT Primary key, #idカラムINT型
	name VARCHAR(10), #名前、可変長文字
	age int,
	phone_number char(13),#固定長
	message text
)

