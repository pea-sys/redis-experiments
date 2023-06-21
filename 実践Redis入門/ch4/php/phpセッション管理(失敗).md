環境:wsl2

## [phpRedis 導入]

PHP で redis を使用する場合、php-redis をインストールする。

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo apt install php8.1-cli php-redis -y
```

phpredis-client.php の作成

```php
<?php
$redis = new Redis();
$redis ->connect("127.0.0.1", 6379);

$redis->set('foo','bar');
$value = $redis->get('foo');
echo $value . "\n";
?>
```

php の実行

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ php /mnt/c/Users/user/phpredis-client.php
bar
```

## [セッション情報のキャッシュ管理]※失敗編

nginx と php を連携し、セッション情報のキャッシュ管理をします  
nginx と php を連携するために php-fpm をインストール

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo apt install nginx php8.1-fpm -y
```

www.conf の listen の設定値を確認

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ less /etc/php/8.1/fpm/pool.d/www.conf
```

```
listen = /run/php/php8.1-fpm.sock
```

nginx の設定を書き換えて、nginx と php fpm を連携するようにします。

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo vi /etc/nginx/sites-available/default
```

```
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
        #
        #       # With php-fpm (or other unix sockets):
                fastcgi_pass unix:/run/php/php8.1-fpm.sock;
        #       # With php-cgi (or other tcp sockets):
        #        fastcgi_pass 127.0.0.1:9000;
        }
```

fpm の php.ini を編集して、セッションハンドラーを redis 向けに編集します。

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo vi /etc/php/8.1/fpm/php.ini
```

php.ini

```
;session.save_path = "/var/lib/php/sessions"
session_save_path = "tcp://localhost:6379"

#session.save_handler = files
session.save_handler = redis
```

index.php

```
<?php
session_start();

echo "session_id=" , session_id(), " ";
$count = isset($_SESSION['count']) ? $_SESSION['count'] : 0;

$_SESSION['count'] = ++$count;

echo $count;
```

nginx と php fpm を再起動

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo systemctl restart nginx
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo systemctl enable nginx
Synchronizing state of nginx.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable nginx
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo systemctl restart php8.1-fpm
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo systemctl enable php8.1-fpm
Synchronizing state of php8.1-fpm.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable php8.1-fpm
```

web サーバーにアクセスすると、セッション ID が得られるはずが得られませんでした。

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ curl http://localhost/index.php
session_id= 1
```

どうも php/session フォルダからデータが読み取れない模様。

```
FastCGI sent in stderr: "PHP message: PHP Notice:  session_start(): Redis not available while creating session_id in /var/www/html/index.php on line 3PHP message: PHP Warning:  session_start(): Failed to read session data: redis (path: /var/lib/php/sessions) in /var/www/html/index.php on line 3" while reading response header from upstream, client: ::1, server: _, request: "GET /index.php HTTP/1.1", upstream: "fastcgi://unix:/run/php/php8.1-fpm.sock:", host: "localhost"
```

ここで扱っている技術全ての知識が浅く解決に時間を要しそうなので、作業中止。  
トラブルシューティングは純粋な Linux 環境が多く参考になりそうなものは見つからなかった。  
関係ないが、php の session_start();の前に改行を入れると動かなくなるという記事を複数見かけた。
