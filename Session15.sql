-- DBの確認、宣言、テーブルの確認
SHOW DATABASES;
USE day_10_14_db;
SHOW TABLES;


/* 
1. employeesテーブルとcustomersテーブルの両方から、それぞれidが10より小さいレコードを取り出します。
両テーブルのfirst_name, last_name, ageカラムを取り出し、行方向に連結します。
連結の際は、重複を削除するようにしてください。
*/








/*
2. departmentsテーブルのnameカラムが営業部の人の、月収の最大値、最小値、平均値、合計値を計算してください。
employeesテーブルのdepartment_idとdepartmentsテーブルのidが紐づけられ
salariesテーブルのemployee_idとemployeesテーブルのidが紐づけられます。
月収はsalariesテーブルのpaymentカラムに格納されています
*/






/*
3. classesテーブルのidが、5よりも小さいレコードとそれ以外のレコードを履修している生徒の数を計算してください。
classesテーブルのidとenrollmentsテーブルのclass_id、enrollmentsテーブルのstudent_idとstudents.idが紐づく
classesにはクラス名が格納されていて、studentsと多対多で結合される
*/



/*
4. ageが40より小さい全従業員で月収の平均値が7,000,000よりも大きい人の、月収の合計値と平均値を計算してください。
employeesテーブルのidとsalariesテーブルのemployee_idが紐づけでき、salariesテーブルのpaymentに月収が格納されています
*/



/*
5. customer毎に、order_amountの合計値を計算してください。
customersテーブルとordersテーブルは、idカラムとcustomer_idカラムで紐づけができます
ordersテーブルのorder_amountの合計値を取得します。
SELECTの対象カラムに副問い合わせを用いて値を取得してください。
*/



/*
6. customersテーブルからlast_nameに田がつくレコード、
ordersテーブルからorder_dateが2020-12-01以上のレコード、
storesテーブルからnameが山田商店のレコード同士を連結します
customersとorders, ordersとitems, itemsとstoresが紐づきます。
first_nameとlast_nameの値を連結(CONCAT)して集計(GROUP BY)し、そのレコード数をCOUNTしてください。
*/



/*
7. salariesのpaymentが9,000,000よりも大きいものが存在するレコードを、employeesテーブルから取り出してください。
employeesテーブルとsalariesテーブルを紐づけます。
EXISTSとINとINNER JOIN、それぞれの方法で記載してください
*/



/*
8. employeesテーブルから、salariesテーブルと紐づけのできないレコードを取り出してください。
EXISTSとINとLEFT JOIN、それぞれの方法で記載してください
*/


/*
9. employeesテーブルとcustomersテーブルのage同士を比較します
customersテーブルの最小age, 平均age, 最大ageとemployeesテーブルのageを比較して、
employeesテーブルのageが、最小age未満のものは最小未満、最小age以上で平均age未満のものは平均未満、
平均age以上で最大age未満のものは最大未満、それ以外はその他と表示します
WITH句を用いて記述します
*/



/*
10. customersテーブルからageが50よりも大きいレコードを取り出して、ordersテーブルと連結します。
customersテーブルのidに対して、ordersテーブルのorder_amount*order_priceのorder_date毎の合計値。
合計値の7日間平均値、合計値の15日平均値、合計値の30日平均値を計算します。
7日間平均、15日平均値、30日平均値が計算できない区間(対象よりも前の日付のデータが十分にない区間)は、空白を表示してください。
*/

