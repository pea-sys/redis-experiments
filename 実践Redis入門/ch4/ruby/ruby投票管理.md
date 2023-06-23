## Ruby で投票管理アプリを作成

- アプリケーションフォルダ作成

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ mkdir SetVoting; cd $_
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/SetVoting$ vi Gemfile
```

- Gemfile 作成

```
source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'redis'
gem 'mysql2'
```

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/SetVoting$ sudo bundle install
```

- MySQL の sample データベースに vote テーブル作成

```sql
mysql> use sample
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> create table votes ( id int not null auto_increment, candidate varchar(128) not null, voter varchar(140), primary key (id) );
Query OK, 0 rows affected (0.22 sec)
mysql> exit
Bye
```

アプリケーションの作成

```
vi main.rb
#内容は同階層のファイル参照
mkdir views
vi views/index.erb
#内容は同階層のファイル参照
```

php サーバー起動

```rb
ruby main.rb -o 0.0.0.0
```

画面の確認・操作
![192 168 19 197_4567_ (1)](https://github.com/pea-sys/Til/assets/49807271/f4934443-5f49-4705-b9dd-31d16c1b0227)

DB 確認

```sql
mysql> select * from votes;
+----+-------------+-------+
| id | candidate   | voter |
+----+-------------+-------+
|  1 | candidate:2 | user  |
|  2 | candidate:1 | aa    |
|  3 | candidate:2 | bcd   |
|  4 | candidate:3 | vv    |
|  5 | candidate:3 | vv    |
|  6 | candidate:3 | vv    |
|  7 | candidate:4 | cc    |
|  8 | candidate:2 | ddd   |
|  9 | candidate:4 | ddd   |
| 10 | candidate:3 | ddd   |
+----+-------------+-------+
10 rows in set (0.00 sec)
```

redis 確認

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli
127.0.0.1:6379> smembers candidate:3
1) "ddd"
2) "vv"
127.0.0.1:6379> smembers candidate:1
1) "aa"
```
