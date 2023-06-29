# Redis クラスター

### Redis 導入(docker)

- redis クラスター用に conf を編集

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo cp /etc/redis/redis.conf .
[sudo] password for masami:
```

- redis.conf の中身

```
cluster-enabled yes
requirepass foobared
masterauth foobared
enable-debug-command yes
```

- docker と docker-compore のインストール

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo apt install docker docker-compose -y
```

- docker-compose.yaml の定義  
  ※同フォルダ参照

- docker-compose の実行

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo docker-compose up --build --scale node=6
WARNING: The PWD variable is not set. Defaulting to a blank string.
WARNING: Found orphan containers (f725e5a5164b_user_master_1, 3d30150a4ca7_user_replica_1) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up.
Recreating user_node_1 ... done
Recreating user_node_2 ... done
Recreating user_node_3 ... done
Recreating user_node_4 ... done
Recreating user_node_5 ... done
Recreating user_node_6 ... done
Attaching to user_node_4, user_node_3, user_node_6, user_node_2, user_node_1, user_node_5
node_1  | 1:C 06 Jun 2023 12:04:22.461 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
node_1  | 1:C 06 Jun 2023 12:04:22.461 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
node_1  | 1:C 06 Jun 2023 12:04:22.461 # Configuration loaded
node_2  | 1:C 06 Jun 2023 12:04:22.165 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
node_2  | 1:C 06 Jun 2023 12:04:22.165 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
node_2  | 1:C 06 Jun 2023 12:04:22.165 # Configuration loaded
node_1  | 1:M 06 Jun 2023 12:04:22.463 * monotonic clock: POSIX clock_gettime
node_1  | 1:M 06 Jun 2023 12:04:22.465 * Running mode=standalone, port=6379.
node_1  | 1:M 06 Jun 2023 12:04:22.466 # Server initialized
node_1  | 1:M 06 Jun 2023 12:04:22.466 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
node_1  | 1:M 06 Jun 2023 12:04:22.466 * Ready to accept connections
node_4  | 1:C 06 Jun 2023 12:04:21.455 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
node_4  | 1:C 06 Jun 2023 12:04:21.455 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
node_4  | 1:C 06 Jun 2023 12:04:21.455 # Configuration loaded
node_4  | 1:M 06 Jun 2023 12:04:21.457 * monotonic clock: POSIX clock_gettime
node_2  | 1:M 06 Jun 2023 12:04:22.166 * monotonic clock: POSIX clock_gettime
node_3  | 1:C 06 Jun 2023 12:04:21.877 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
node_3  | 1:C 06 Jun 2023 12:04:21.877 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
node_3  | 1:C 06 Jun 2023 12:04:21.877 # Configuration loaded
node_3  | 1:M 06 Jun 2023 12:04:21.878 * monotonic clock: POSIX clock_gettime
node_3  | 1:M 06 Jun 2023 12:04:21.880 * Running mode=standalone, port=6379.
node_3  | 1:M 06 Jun 2023 12:04:21.880 # Server initialized
node_3  | 1:M 06 Jun 2023 12:04:21.880 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
node_3  | 1:M 06 Jun 2023 12:04:21.880 * Ready to accept connections
node_5  | 1:C 06 Jun 2023 12:04:22.460 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
node_5  | 1:C 06 Jun 2023 12:04:22.460 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
node_5  | 1:C 06 Jun 2023 12:04:22.460 # Configuration loaded
node_5  | 1:M 06 Jun 2023 12:04:22.461 * monotonic clock: POSIX clock_gettime
node_2  | 1:M 06 Jun 2023 12:04:22.167 * Running mode=standalone, port=6379.
node_2  | 1:M 06 Jun 2023 12:04:22.167 # Server initialized
node_2  | 1:M 06 Jun 2023 12:04:22.168 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
node_5  | 1:M 06 Jun 2023 12:04:22.462 * Running mode=standalone, port=6379.
node_5  | 1:M 06 Jun 2023 12:04:22.463 # Server initialized
node_5  | 1:M 06 Jun 2023 12:04:22.463 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
node_5  | 1:M 06 Jun 2023 12:04:22.463 * Ready to accept connections
node_2  | 1:M 06 Jun 2023 12:04:22.168 * Ready to accept connections
node_4  | 1:M 06 Jun 2023 12:04:21.473 * Running mode=standalone, port=6379.
node_4  | 1:M 06 Jun 2023 12:04:21.473 # Server initialized
node_4  | 1:M 06 Jun 2023 12:04:21.473 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
node_4  | 1:M 06 Jun 2023 12:04:21.476 * Ready to accept connections
node_6  | 1:C 06 Jun 2023 12:04:21.965 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
node_6  | 1:C 06 Jun 2023 12:04:21.965 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
node_6  | 1:C 06 Jun 2023 12:04:21.965 # Configuration loaded
node_6  | 1:M 06 Jun 2023 12:04:21.966 * monotonic clock: POSIX clock_gettime
node_6  | 1:M 06 Jun 2023 12:04:21.968 * Running mode=standalone, port=6379.
node_6  | 1:M 06 Jun 2023 12:04:21.968 # Server initialized
node_6  | 1:M 06 Jun 2023 12:04:21.968 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
node_6  | 1:M 06 Jun 2023 12:04:21.969 * Ready to accept connections
```

- コンテナーの状況確認

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo docker-compose ps
[sudo] password for masami:
   Name                  Command               State                     Ports
-------------------------------------------------------------------------------------------------
user_node_1   docker-entrypoint.sh redis ...   Up      0.0.0.0:49170->6379/tcp,:::49170->6379/tcp
user_node_2   docker-entrypoint.sh redis ...   Up      0.0.0.0:49168->6379/tcp,:::49168->6379/tcp
user_node_3   docker-entrypoint.sh redis ...   Up      0.0.0.0:49166->6379/tcp,:::49166->6379/tcp
user_node_4   docker-entrypoint.sh redis ...   Up      0.0.0.0:49165->6379/tcp,:::49165->6379/tcp
user_node_5   docker-entrypoint.sh redis ...   Up      0.0.0.0:49169->6379/tcp,:::49169->6379/tcp
user_node_6   docker-entrypoint.sh redis ...   Up      0.0.0.0:49167->6379/tcp,:::49167->6379/tcp
```

- コンテナ ID の確認

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo docker container ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS
            NAMES
a01c8edced91   redis:latest   "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:49170->6379/tcp, :::49170->6379/tcp   user_node_1
5610b8c72bc5   redis:latest   "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:49169->6379/tcp, :::49169->6379/tcp   user_node_5
29c56f082a95   redis:latest   "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:49168->6379/tcp, :::49168->6379/tcp   user_node_2
2d65c1520812   redis:latest   "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:49167->6379/tcp, :::49167->6379/tcp   user_node_6
acda4d201d96   redis:latest   "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:49166->6379/tcp, :::49166->6379/tcp   user_node_3
9cbcd24ecaad   redis:latest   "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:49165->6379/tcp, :::49165->6379/tcp   user_node_4
```

- コンテナの IP アドレス確認

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user# docker inspect a01c8edced91 | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "",
                    "IPAddress": "172.19.0.7",
root@DESKTOP-L18OTEK:/mnt/c/Users/user# docker inspect 5610b8c72bc5 | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "",
                    "IPAddress": "172.19.0.6",
root@DESKTOP-L18OTEK:/mnt/c/Users/user# docker inspect 29c56f082a95 | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "",
                    "IPAddress": "172.19.0.5",
root@DESKTOP-L18OTEK:/mnt/c/Users/user# docker inspect 2d65c1520812 | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "",
                    "IPAddress": "172.19.0.4",
root@DESKTOP-L18OTEK:/mnt/c/Users/user# docker inspect acda4d201d96 | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "",
                    "IPAddress": "172.19.0.3",
root@DESKTOP-L18OTEK:/mnt/c/Users/user# docker inspect 9cbcd24ecaad | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "",
                    "IPAddress": "172.19.0.2",
```

- コンテナにログインしてクラスターを作成

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user# docker-compose exec node bash -c "redis-cli --cluster create 172.19.0.7:6379 172.19.0.6:6379 172.19.0.5:6379 172.19.0.4:6379 172.19.0.3:6379 172.19.0.2:6379 --cluster-replicas 1 --pass foobared"
```

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user# docker-compose exec node bash -c "redis-cli --cluster create 172.19.0.7:6379 172.19.0.6:6379 172.19.0.5:6379 172.19.0.4:6379 172.19.0.3:6379 172.19.0.2:6379 --cluster-replicas 1"
[ERR] Node 172.19.0.7:6379 is not configured as a cluster node.
```

・・・うまくいかない。redis.conf がうまく参照できていない気がする。

### Redis 導入(Local)

ローカルでポートをノードのポートを変更して構成した場合にはうまく動作した。

https://www.sraoss.co.jp/tech-blog/redis/redis-cluster/

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user# mkdir cluster-test
root@DESKTOP-L18OTEK:/mnt/c/Users/user# cd cluster-test/
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# mkdir 7000 7001 7002 7003 7004 7005
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# cp /etc/redis.conf 7000
cp: cannot stat '/etc/redis.conf': No such file or directory
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# cp /etc/redis/redis.conf 7000
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# cp /etc/redis/redis.conf 7001
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# cp /etc/redis/redis.conf 7002
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# cp /etc/redis/redis.conf 7003
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# cp /etc/redis/redis.conf 7004
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# cp /etc/redis/redis.conf 7005
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# vi 7000/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# vi 7001/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# vi 7002/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# vi 7003/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# vi 7004/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# vi 7005/redis.conf
```

- redis.conf の変更点

```
port 7000
pidfile "/var/run/redis_{port}.pid"
logfile "/root/cluster-test/{port}/redis.log"
dbfilename "dump-{port}.rdb"
appendonly yes
appendfilename "appendonly-{port}.aof"
cluster-enabled yes
cluster-config-file nodes-{port}.conf
```

- ノード起動+クラスター構成

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# redis-server ./7001/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# redis-server ./7002/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# redis-server ./7003/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# redis-server ./7004/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# redis-server ./7005/redis.conf
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# ps auxww|grep redis
root       10167  0.3  0.2  61308 11756 ?        Ssl  20:19   0:00 redis-server 127.0.0.1:7000 [cluster]
root       10179  0.3  0.2  61308 11560 ?        Ssl  20:22   0:00 redis-server 127.0.0.1:7001 [cluster]
root       10185  0.3  0.2  61308 11476 ?        Ssl  20:22   0:00 redis-server 127.0.0.1:7002 [cluster]
root       10191  0.4  0.2  61308 11272 ?        Ssl  20:22   0:00 redis-server 127.0.0.1:7003 [cluster]
root       10197  0.4  0.2  61308 11464 ?        Ssl  20:22   0:00 redis-server 127.0.0.1:7004 [cluster]
root       10203  0.4  0.2  61308 11556 ?        Ssl  20:22   0:00 redis-server 127.0.0.1:7005 [cluster]
root       10209  0.0  0.0   4028  1960 pts/0    S+   20:22   0:00 grep --color=auto redis

root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# ls -l /var/lib/redis/
total 32
drwxr-xr-x 2 root  root  4096 Jun  7 20:22 appendonlydir
-rw-rw---- 1 redis redis   89 May 20 15:18 dump.rdb
-rw-r--r-- 1 root  root   114 Jun  7 20:19 nodes-7000.conf
-rw-r--r-- 1 root  root   114 Jun  7 20:22 nodes-7001.conf
-rw-r--r-- 1 root  root   114 Jun  7 20:22 nodes-7002.conf
-rw-r--r-- 1 root  root   114 Jun  7 20:22 nodes-7003.conf
-rw-r--r-- 1 root  root   114 Jun  7 20:22 nodes-7004.conf
-rw-r--r-- 1 root  root   114 Jun  7 20:22 nodes-7005.conf

root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 --cluster-replicas 1
```

- 動作確認

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user# redis-cli -p 7000 cluster nodes
4a2b75bef2700c78f359d5cdc465ccb613086a92 127.0.0.1:7001@17001 master - 0 1686138755000 2 connected 5461-10922
000c1fd5041e58ac69382331326a85a0a0f5743b 127.0.0.1:7005@17005 slave 23e05b09ae3107ddb01cb3979bd20659745e2737 0 1686138754861 1 connected
b4d6b9bec54a2dde2190abfb8bd208e5e64b66af 127.0.0.1:7004@17004 slave 7c1a25f20405837dff68412121ed6911df7a8045 0 1686138753000 3 connected
23e05b09ae3107ddb01cb3979bd20659745e2737 127.0.0.1:7000@17000 myself,master - 0 1686138754000 1 connected 0-5460
7c1a25f20405837dff68412121ed6911df7a8045 127.0.0.1:7002@17002 master - 0 1686138756874 3 connected 10923-16383
7f2f6004a92d28f676fdb7f4184b4bc9a93a1d4d 127.0.0.1:7003@17003 slave 4a2b75bef2700c78f359d5cdc465ccb613086a92 0 1686138755868 2 connected

root@DESKTOP-L18OTEK:/mnt/c/Users/user# redis-cli -c -p 7000
127.0.0.1:7000> set foo 1
-> Redirected to slot [12182] located at 127.0.0.1:7002
OK
127.0.0.1:7002> get foo
"1"
127.0.0.1:7002> set bar 2
-> Redirected to slot [5061] located at 127.0.0.1:7000
OK
127.0.0.1:7000> get bar
"2"
127.0.0.1:7000> get hoge
(nil)
127.0.0.1:7000> incr foo
-> Redirected to slot [12182] located at 127.0.0.1:7002
(integer) 2
127.0.0.1:7002> get foo
"2"
```

- ファイルオーバー

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user# ps auxww|grep redis
root       10167  0.3  0.3 137088 12448 ?        Ssl  20:19   0:07 redis-server 127.0.0.1:7000 [cluster]
root       10179  0.3  0.3  61308 12056 ?        Ssl  20:22   0:06 redis-server 127.0.0.1:7001 [cluster]
root       10185  0.3  0.3 137088 12156 ?        Ssl  20:22   0:06 redis-server 127.0.0.1:7002 [cluster]
root       10191  0.3  0.3 137088 12100 ?        Ssl  20:22   0:06 redis-server 127.0.0.1:7003 [cluster]
root       10197  0.3  0.3 147332 12136 ?        Ssl  20:22   0:06 redis-server 127.0.0.1:7004 [cluster]
root       10203  0.3  0.3 147332 12016 ?        Ssl  20:22   0:06 redis-server 127.0.0.1:7005 [cluster]
root       10346  0.0  0.0   4028  2096 pts/0    S+   20:55   0:00 grep --color=auto redis
root@DESKTOP-L18OTEK:/mnt/c/Users/user# kill 10167
```

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user# redis-cli -p 7001 cluster nodes
23e05b09ae3107ddb01cb3979bd20659745e2737 127.0.0.1:7000@17000 master,fail - 1686138924627 1686138922000 1 disconnected
7c1a25f20405837dff68412121ed6911df7a8045 127.0.0.1:7002@17002 master - 0 1686138987312 3 connected 10923-16383
7f2f6004a92d28f676fdb7f4184b4bc9a93a1d4d 127.0.0.1:7003@17003 slave 4a2b75bef2700c78f359d5cdc465ccb613086a92 0 1686138987000 2 connected
000c1fd5041e58ac69382331326a85a0a0f5743b 127.0.0.1:7005@17005 master - 0 1686138986000 4 connected 0-5460
b4d6b9bec54a2dde2190abfb8bd208e5e64b66af 127.0.0.1:7004@17004 slave 7c1a25f20405837dff68412121ed6911df7a8045 0 1686138988320 3 connected
4a2b75bef2700c78f359d5cdc465ccb613086a92 127.0.0.1:7001@17001 myself,master - 0 1686138986000 2 connected 5461-10922
```

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# redis-cli -p 7001 cluster nodes
23e05b09ae3107ddb01cb3979bd20659745e2737 127.0.0.1:7000@17000 slave 000c1fd5041e58ac69382331326a85a0a0f5743b 0 1686139074000 4 connected
7c1a25f20405837dff68412121ed6911df7a8045 127.0.0.1:7002@17002 master - 0 1686139077138 3 connected 10923-16383
7f2f6004a92d28f676fdb7f4184b4bc9a93a1d4d 127.0.0.1:7003@17003 slave 4a2b75bef2700c78f359d5cdc465ccb613086a92 0 1686139076000 2 connected
000c1fd5041e58ac69382331326a85a0a0f5743b 127.0.0.1:7005@17005 master - 0 1686139076130 4 connected 0-5460
b4d6b9bec54a2dde2190abfb8bd208e5e64b66af 127.0.0.1:7004@17004 slave 7c1a25f20405837dff68412121ed6911df7a8045 0 1686139078145 3 connected
4a2b75bef2700c78f359d5cdc465ccb613086a92 127.0.0.1:7001@17001 myself,master - 0 1686139077000 2 connected 5461-10922
```

```
127.0.0.1:7001> info replication
# Replication
role:master
connected_slaves:1
slave0:ip=127.0.0.1,port=7003,state=online,offset=6062,lag=1
master_failover_state:no-failover
master_replid:3f58c68230969f45dd6c91a5d8e1cdf4b4a44da4
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:6062
second_repl_offset:-1
repl_backlog_active:1
repl_backlog_size:1048576
repl_backlog_first_byte_offset:1
repl_backlog_histlen:6062
127.0.0.1:7001> cluster shade
(error) ERR unknown subcommand 'shade'. Try CLUSTER HELP.
127.0.0.1:7001> cluster shards
1) 1) "slots"
   2) 1) (integer) 10923
      2) (integer) 16383
   3) "nodes"
   4) 1)  1) "id"
          2) "7c1a25f20405837dff68412121ed6911df7a8045"
          3) "port"
          4) (integer) 7002
          5) "ip"
          6) "127.0.0.1"
          7) "endpoint"
          8) "127.0.0.1"
          9) "role"
         10) "master"
         11) "replication-offset"
         12) (integer) 6207
         13) "health"
         14) "online"
      2)  1) "id"
          2) "b4d6b9bec54a2dde2190abfb8bd208e5e64b66af"
          3) "port"
          4) (integer) 7004
          5) "ip"
          6) "127.0.0.1"
          7) "endpoint"
          8) "127.0.0.1"
          9) "role"
         10) "replica"
         11) "replication-offset"
         12) (integer) 6221
         13) "health"
         14) "online"
2) 1) "slots"
   2) 1) (integer) 0
      2) (integer) 5460
   3) "nodes"
   4) 1)  1) "id"
          2) "000c1fd5041e58ac69382331326a85a0a0f5743b"
          3) "port"
          4) (integer) 7005
          5) "ip"
          6) "127.0.0.1"
          7) "endpoint"
          8) "127.0.0.1"
          9) "role"
         10) "master"
         11) "replication-offset"
         12) (integer) 5946
         13) "health"
         14) "online"
      2)  1) "id"
          2) "23e05b09ae3107ddb01cb3979bd20659745e2737"
          3) "port"
          4) (integer) 7000
          5) "ip"
          6) "127.0.0.1"
          7) "endpoint"
          8) "127.0.0.1"
          9) "role"
         10) "replica"
         11) "replication-offset"
         12) (integer) 5946
         13) "health"
         14) "online"
3) 1) "slots"
   2) 1) (integer) 5461
      2) (integer) 10922
   3) "nodes"
   4) 1)  1) "id"
          2) "4a2b75bef2700c78f359d5cdc465ccb613086a92"
          3) "port"
          4) (integer) 7001
          5) "ip"
          6) "127.0.0.1"
          7) "endpoint"
          8) "127.0.0.1"
          9) "role"
         10) "master"
         11) "replication-offset"
         12) (integer) 6188
         13) "health"
         14) "online"
      2)  1) "id"
          2) "7f2f6004a92d28f676fdb7f4184b4bc9a93a1d4d"
          3) "port"
          4) (integer) 7003
          5) "ip"
          6) "127.0.0.1"
          7) "endpoint"
          8) "127.0.0.1"
          9) "role"
         10) "replica"
         11) "replication-offset"
         12) (integer) 6188
         13) "health"
         14) "online"
```

- マスターノードのデータを一括して操作する場合、--cluster-only-masters が使用できる。指定ノードはクラスター内のものであればレプリカでも ok

```
root@DESKTOP-L18OTEK:/mnt/c/Users/user/cluster-test# redis-cli --cluster call 127.0.0.1:7000 flushall --cluster-only-mas
ters
>>> Calling flushall
127.0.0.1:7001: OK
127.0.0.1:7002: OK
127.0.0.1:7005: OK
```

レプリカのみ対象にする場合は--cluster-only-replicas を指定する。
