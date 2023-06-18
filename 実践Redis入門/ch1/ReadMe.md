## Redis のインストールと動作確認

PPA からインストールする

```
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ sudo add-apt-repository ppa:redislabs/redis
[sudo] password for masami:
Repository: 'deb https://ppa.launchpadcontent.net/redislabs/redis/ubuntu/ jammy main'
Description:
** NOTICE **

Redis now has an official APT repository. We urge users to use the APT repository, as described here:
https://redis.io/docs/getting-started/installation/install-redis-on-linux/

This PPA is still maintained but bugfix releases of older versions cannot be distributed here.

* * *

Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

It supports data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs, geospatial indexes with radius queries and streams.

Redis has built-in replication, Lua scripting, LRU eviction, transactions and different levels of on-disk persistence, and provides high availability via Redis Sentinel and automatic partitioning with Redis Cluster.
More info: https://launchpad.net/~redislabs/+archive/ubuntu/redis
Adding repository.
Press [ENTER] to continue or Ctrl-c to cancel.
Adding deb entry to /etc/apt/sources.list.d/redislabs-ubuntu-redis-jammy.list
Adding disabled deb-src entry to /etc/apt/sources.list.d/redislabs-ubuntu-redis-jammy.list
Adding key to /etc/apt/trusted.gpg.d/redislabs-ubuntu-redis.gpg with fingerprint 60A0586666DE0BA4B481628ACC59E6B43FA6E3CA
Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
Hit:2 http://archive.ubuntu.com/ubuntu jammy InRelease
Get:3 http://archive.ubuntu.com/ubuntu jammy-updates InRelease [119 kB]
Get:4 http://security.ubuntu.com/ubuntu jammy-security/main amd64 Packages [385 kB]
Get:5 https://ppa.launchpadcontent.net/redislabs/redis/ubuntu jammy InRelease [18.0 kB]
Get:6 http://security.ubuntu.com/ubuntu jammy-security/main Translation-en [111 kB]
Get:7 http://archive.ubuntu.com/ubuntu jammy-backports InRelease [108 kB]
Get:8 http://security.ubuntu.com/ubuntu jammy-security/main amd64 c-n-f Metadata [9812 B]
Get:9 http://security.ubuntu.com/ubuntu jammy-security/restricted amd64 Packages [250 kB]
Get:10 http://security.ubuntu.com/ubuntu jammy-security/restricted Translation-en [36.6 kB]
Get:11 http://security.ubuntu.com/ubuntu jammy-security/restricted amd64 c-n-f Metadata [604 B]
Get:12 http://security.ubuntu.com/ubuntu jammy-security/universe amd64 Packages [726 kB]
Get:13 http://archive.ubuntu.com/ubuntu jammy/universe amd64 Packages [14.1 MB]
Get:14 http://security.ubuntu.com/ubuntu jammy-security/universe Translation-en [126 kB]
Get:15 http://security.ubuntu.com/ubuntu jammy-security/universe amd64 c-n-f Metadata [14.6 kB]
Get:16 http://security.ubuntu.com/ubuntu jammy-security/multiverse amd64 Packages [30.2 kB]
Get:17 http://security.ubuntu.com/ubuntu jammy-security/multiverse Translation-en [5828 B]
Get:18 https://ppa.launchpadcontent.net/redislabs/redis/ubuntu jammy/main amd64 Packages [1024 B]
Get:19 http://security.ubuntu.com/ubuntu jammy-security/multiverse amd64 c-n-f Metadata [252 B]
Get:20 https://ppa.launchpadcontent.net/redislabs/redis/ubuntu jammy/main Translation-en [584 B]
Get:21 http://archive.ubuntu.com/ubuntu jammy/universe Translation-en [5652 kB]
Get:22 http://archive.ubuntu.com/ubuntu jammy/universe amd64 c-n-f Metadata [286 kB]
Get:23 http://archive.ubuntu.com/ubuntu jammy/multiverse amd64 Packages [217 kB]
Get:24 http://archive.ubuntu.com/ubuntu jammy/multiverse Translation-en [112 kB]
Get:25 http://archive.ubuntu.com/ubuntu jammy/multiverse amd64 c-n-f Metadata [8372 B]
Get:26 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [601 kB]
Get:27 http://archive.ubuntu.com/ubuntu jammy-updates/main Translation-en [170 kB]
Get:28 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 c-n-f Metadata [14.5 kB]
Get:29 http://archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 Packages [251 kB]
Get:30 http://archive.ubuntu.com/ubuntu jammy-updates/restricted Translation-en [36.9 kB]
Get:31 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [906 kB]
Get:32 http://archive.ubuntu.com/ubuntu jammy-updates/universe Translation-en [186 kB]
Get:33 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 c-n-f Metadata [18.9 kB]
Get:34 http://archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 Packages [35.3 kB]
Get:35 http://archive.ubuntu.com/ubuntu jammy-updates/multiverse Translation-en [8452 B]
Get:36 http://archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 c-n-f Metadata [468 B]
Get:37 http://archive.ubuntu.com/ubuntu jammy-backports/main amd64 Packages [40.9 kB]
Get:38 http://archive.ubuntu.com/ubuntu jammy-backports/main Translation-en [10.2 kB]
Get:39 http://archive.ubuntu.com/ubuntu jammy-backports/main amd64 c-n-f Metadata [388 B]
Get:40 http://archive.ubuntu.com/ubuntu jammy-backports/restricted amd64 c-n-f Metadata [116 B]
Get:41 http://archive.ubuntu.com/ubuntu jammy-backports/universe amd64 Packages [22.2 kB]
Get:42 http://archive.ubuntu.com/ubuntu jammy-backports/universe Translation-en [15.0 kB]
Get:43 http://archive.ubuntu.com/ubuntu jammy-backports/universe amd64 c-n-f Metadata [548 B]
Get:44 http://archive.ubuntu.com/ubuntu jammy-backports/multiverse amd64 c-n-f Metadata [116 B]
Fetched 24.7 MB in 28s (880 kB/s)
Reading package lists... Done

masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ sudo apt update
Hit:1 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:2 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:3 http://security.ubuntu.com/ubuntu jammy-security InRelease
Hit:4 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Hit:5 https://ppa.launchpadcontent.net/redislabs/redis/ubuntu jammy InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
23 packages can be upgraded. Run 'apt list --upgradable' to see them.

masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ sudo apt install redis -y
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  redis-server redis-tools
Suggested packages:
  ruby-redis
The following NEW packages will be installed:
  redis redis-server redis-tools
0 upgraded, 3 newly installed, 0 to remove and 23 not upgraded.
Need to get 1654 kB of archives.
After this operation, 9464 kB of additional disk space will be used.
Get:1 https://ppa.launchpadcontent.net/redislabs/redis/ubuntu jammy/main amd64 redis-tools amd64 6:7.0.11-1rl1~jammy1 [1521 kB]
Get:2 https://ppa.launchpadcontent.net/redislabs/redis/ubuntu jammy/main amd64 redis-server amd64 6:7.0.11-1rl1~jammy1 [90.3 kB]
Get:3 https://ppa.launchpadcontent.net/redislabs/redis/ubuntu jammy/main amd64 redis all 6:7.0.11-1rl1~jammy1 [42.1 kB]
Fetched 1654 kB in 7s (250 kB/s)
Selecting previously unselected package redis-tools.
(Reading database ... 24125 files and directories currently installed.)
Preparing to unpack .../redis-tools_6%3a7.0.11-1rl1~jammy1_amd64.deb ...
Unpacking redis-tools (6:7.0.11-1rl1~jammy1) ...
Selecting previously unselected package redis-server.
Preparing to unpack .../redis-server_6%3a7.0.11-1rl1~jammy1_amd64.deb ...
Unpacking redis-server (6:7.0.11-1rl1~jammy1) ...
Selecting previously unselected package redis.
Preparing to unpack .../redis_6%3a7.0.11-1rl1~jammy1_all.deb ...
Unpacking redis (6:7.0.11-1rl1~jammy1) ...
Setting up redis-tools (6:7.0.11-1rl1~jammy1) ...
Setting up redis-server (6:7.0.11-1rl1~jammy1) ...
Setting up redis (6:7.0.11-1rl1~jammy1) ...
Processing triggers for man-db (2.10.2-1) ...

masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ redis-server --version
Redis server v=7.0.11 sha=00000000:0 malloc=jemalloc-5.2.1 bits=64 build=450be55a432c4eba
```

## Redis サーバーの起動

■ サーバー

```
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ redis-server
2289:C 20 May 2023 15:03:07.075 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
2289:C 20 May 2023 15:03:07.075 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=2289, just started
2289:C 20 May 2023 15:03:07.075 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
2289:M 20 May 2023 15:03:07.076 * Increased maximum number of open files to 10032 (it was originally set to 1024).
2289:M 20 May 2023 15:03:07.076 * monotonic clock: POSIX clock_gettime
2289:M 20 May 2023 15:03:07.076 # Warning: Could not create server TCP listening socket *:6379: bind: Address already in use
2289:M 20 May 2023 15:03:07.076 # Failed listening on port 6379 (TCP), aborting.
```

既に開始されているよと怒られました。  
一応確認してみます。

■ クライアント

```
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ redis-cli ping
PONG
```

どうやらインストールした時点で Redis サーバーは起動しているようです。
なので一回停止してから、起動してみます。
■ サーバー

````
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$  sudo /etc/init.d/redis-server stop
Stopping redis-server (via systemctl): redis-server.service.
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ redis-cli ping
Could not connect to Redis at 127.0.0.1:6379: Connection refused
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ redis-server
2412:C 20 May 2023 15:20:55.770 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
2412:C 20 May 2023 15:20:55.770 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=2412, just started
2412:C 20 May 2023 15:20:55.770 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
2412:M 20 May 2023 15:20:55.771 * Increased maximum number of open files to 10032 (it was originally set to 1024).
2412:M 20 May 2023 15:20:55.771 * monotonic clock: POSIX clock_gettime
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 7.0.11 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 2412
  `-._    `-._  `-./  _.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |           https://redis.io
  `-._    `-._`-.__.-'_.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |
  `-._    `-._`-.__.-'_.-'    _.-'
      `-._    `-.__.-'    _.-'
          `-._        _.-'
              `-.__.-'

2412:M 20 May 2023 15:20:55.773 # Server initialized
2412:M 20 May 2023 15:20:55.773 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
2412:M 20 May 2023 15:20:55.776 * Ready to accept connections
````

Redis サーバーの起動に成功したのでクライアントからアクセスします。
■ クライアント

```
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ redis-cli
127.0.0.1:6379> set foo bar
OK
127.0.0.1:6379> get foo
"bar"
127.0.0.1:6379> shutdown
(error) ERR Errors trying to SHUTDOWN. Check logs.
```

shutdown がこけてしまいました。
サーバーコンソールログを確認します。
■ サーバー

```
2412:M 20 May 2023 16:07:02.458 # User requested shutdown...
2412:M 20 May 2023 16:07:02.458 * Saving the final RDB snapshot before exiting.
2412:M 20 May 2023 16:07:02.462 # Failed opening the temp RDB file temp-2412.rdb (in server root dir /mnt/c/Windows/system32) for saving: Permission denied
2412:M 20 May 2023 16:07:02.462 # Error trying to save the DB, can't exit.
2412:M 20 May 2023 16:07:02.462 # Errors trying to shut down the server. Check the logs for more information.
```

どうもアクセス権限が少し調べた感じでは、redis.conf のアクセス権限がないため、終了時のスナップショット保存ができなくてこけているようです。
アクセス権限を設定します。
■ サーバー

```
$ sudo mkdir /etc/redis /var/run/redis /var/log/redis
$ sudo chmod 755 /etc/redis /var/run/redis /var/log/redis
$ sudo chown redis:redis /etc/redis /var/run/redis /var/log/redis
```

一度、wsl を再起動後に redis-cli かシャットダウンできるようになりました。
■ クライアント

```
127.0.0.1:6379> shutdown
not connected>
```

■ サーバー

```
533:M 20 May 2023 17:25:51.495 # User requested shutdown...
533:M 20 May 2023 17:25:51.495 * Saving the final RDB snapshot before exiting.
533:M 20 May 2023 17:25:51.524 * DB saved on disk
533:M 20 May 2023 17:25:51.524 # Redis is now ready to exit, bye bye...
```

byebye してますね。ばいばい～。  
shutdown エラーの解決にはこちらが参考になりました。  
https://qiita.com/KurosawaTsuyoshi/items/f8719bf7c3a10d22a921

■ クライアント  
対話モード以外もおまけで動作確認

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli set mykey "foo"
OK
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli get mykey
"foo"
```
