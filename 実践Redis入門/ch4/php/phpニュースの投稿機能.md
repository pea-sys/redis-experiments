## ニュースの投稿機能

- アプリ用のディレクトリの作成

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ mkdir ListTimeline; cd $_
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$
```

- Composer を利用し、Slim3 をインストール
  - Composer:php の pkg 管理ツール
  - Slim:php の軽量なフレームワーク

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$ curl -sS https://getcomposer.org/installer | php
All settings correct for using Composer
Downloading...

Composer (version 2.5.7) successfully installed to: /mnt/c/Users/user/ListTimeline/composer.phar
Use it: php composer.phar

masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$ sudo mv composer.phar /usr/local/bin/composer
[sudo] password for masami:
```

- php から mysql を使用する環境の作成

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$ sudo apt install mysql-server php8.1-mysql -y
Reading package lists... Done
・・・
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$ sudo systemctl start mysql
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$ sudo systemctl enable mysql
Synchronizing state of mysql.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable mysql
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$ mysql --version
mysql  Ver 8.0.33-0ubuntu0.22.04.2 for Linux on x86_64 ((Ubuntu))
```

- アプリケーション用の mysql ユーザー作成

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 18
Server version: 8.0.33-0ubuntu0.22.04.2 (Ubuntu)

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create user app@`%` identified by 'P@ssw0rd';
Query OK, 0 rows affected (0.07 sec)

mysql> grant all privileges on sample.* to app@'%';
Query OK, 0 rows affected (0.02 sec)
```

- データベースとテーブルの作成

```sql
mysql> create database sample default character set utf8mb4;
Query OK, 1 row affected (0.03 sec)

mysql> use sample
Database changed
mysql> create table timeline (id int not null auto_increment,
    -> name varchar(128) not null,
    -> message varchar(140),
    -> primary key (id));
Query OK, 0 rows affected (0.13 sec)

```

- アプリユーザーでログインできることを確認

```sql
mysql> exit
Bye
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ mysql -u app -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 19
Server version: 8.0.33-0ubuntu0.22.04.2 (Ubuntu)

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

- フレームワークの導入
  - twig:Web アプリテンプレートエンジン

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$ composer require slim/slim:3.*
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$ composer require slim/twig-view:2.*
```

- php スクリプトと、スクリプトから呼び出す html ファイルを作成

- サーバーを起動

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/ListTimeline$ $ php -S 0.0.0.0:8888  /mnt/c/Users/user/ListTimeline/public/inde
x.php
```

サーバーにはアクセスできるものの、html が開けていない  
サーバーでは特にエラーのログが出ていない。  
前項に続き断念。。。
