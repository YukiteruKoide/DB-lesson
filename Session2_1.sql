SHOW DATABASES;

#DBの作成
CREATE DATABASE my_db;

SHOW DATABASES; #DBの一覧を表示します

#DBの削除
DROP Database my_db;

#performance_schemaを利用
USE performance_schema;

/* 
performance_schemaはMySQLデータベースサーバーの内部動作に関する情報を提供するMySQLシステムスキーマの1つです。これは、MySQLサーバーのパフォーマンスの分析、チューニング、および監視を可能にするために設計されています。
performance_schemaには、次のような情報が含まれます。
1. クエリの実行に関する情報（例：クエリの実行時間、クエリに使用されたリソース、クエリの実行に関連するスレッドと接続など）
2. テーブル、インデックス、および他のオブジェクトに関する情報（例：使用されたストレージエンジン、オブジェクトのサイズ、アクセスパターンなど）
3. ユーザーアカウントおよび接続に関する情報（例：アクティブな接続数、接続されたユーザー名、接続元IPアドレスなど）
performance_schemaは、MySQLサーバーが実行されている間に、動的に更新されます。これにより、リアルタイムでMySQLサーバーのパフォーマンスに関する情報を取得できます。ただし、performance_schemaは非常に多くの情報を含むため、情報の取得には多少のオーバーヘッドがかかる場合があります。
 */

#利用中のDBの表示
SELECT DATABASE();

USE my_db;


