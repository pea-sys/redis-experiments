# Redis の運用管理

## ■ データの削除パターン

- エンジンの再起動
- Redis サーバー全体に障害
- コマンド実行
  - DEL/HDEL コマンド
  - FULUSHALL/FLUSHDB コマンド
  - UNLINK コマンド
- TTL
  - EXPIRE/EXPIREAT/PEXPIRE/PEXPIREAT コマンド
  - SET コマンドの EX オプション等

* 退避
* 非同期のレプリケーション
* Redis クラスターでネットワーク分断
* その他
  - キーのリネーム
  - データベースの選択ミス
  - そもそもデータが挿入されていない

# Redis アーキテクチャ

## ■ 読込みアーキテクチャ

- 遅延読込みパターン  
  ■[Redis サーバーに有効期限内のデータが存在する]

  - 1. アプリケーションは Redis サーバーにデータをリクエスト
  - 2. 応答

  ■[Redis サーバーに有効期限内のデータが存在しない]

  - 1. アプリケーションは Redis サーバーにデータをリクエスト
  - 2. アプリケーションはデータベースにデータをリクエスト
  - 3. アプリケーションはデータベースから取得したデータを Redis に登録

- 読込みスルーパターン  
  動作は遅延読込みパターンと同じ
  ただし、アプリケーション側がキャッシュヒット等意識することなく、リクエスト受付モジュールがフォールバックしてくれる。

  [メリット]

  - リクエストデータのみキャッシュするので使用メモリが少ない

  [デメリット]

  - 取得データが古い可能性
  - キャッシュミス時のオーバーヘッドが大きい

## ■ 書き込みアーキテクチャ

- 書き込みスルーパターン

  - 1.アプリケーションはデータベースに書き込み
  - 2.アプリケーションは 1 と同じデータを Redis へ書き込み

  [メリット]

  - キャッシュが最新を維持
  - 読み取りオーバーヘッドが少ない

  [デメリット]

  - 書き込みがない限りキャッシュがない
  - 不要なデータがメモリに載りがち
  - データ書き込みオーバーヘッドが大きい

- 書き込みバックパターン

  - 1.アプリケーションは Redis に書き込み
  - 2.非同期で 1 と同じデータをデータベースに書き込み

  [メリット]

  - 書き込みオーバーヘッドが少ない
  - キャッシュが最新を維持

  [デメリット]

  - データロスのリスクが大きい

* データアラウンドパターン  
  動作は書き込みスルーパターンと同じ
  ただし、アプリケーション側がキャッシュを意識することなく、リクエスト受付モジュールがレプリケーションしてくれる。

  [メリット]

  - データロスのリスクが小さい

  [デメリット]

  - 実現方法により変わる

  * 外部プログラムにより実行するのが簡単だが、負荷は大きい
  * DB プログラムを直接弄れば、負荷は軽いがスキルが必要

## ■ セキュリティ

[セキュリティ設定]

- ネットワークセキュリティ
- コマンドの制限
- 認証
- 外部クライアントからの攻撃
- コードセキュリティ

### --ACL 機能--

- ユーザーとアクセス制御の確認

```
127.0.0.1:6379> acl list
1) "user default on nopass ~* &* +@all"
```

+@all により全コマンドが使用できます。

- 制御可能なコマンドカテゴリーの確認

```
127.0.0.1:6379> acl cat
 1) "keyspace"
 2) "read"
 3) "write"
 4) "set"
 5) "sortedset"
 6) "list"
 7) "hash"
 8) "string"
 9) "bitmap"
10) "hyperloglog"
11) "geo"
12) "stream"
13) "pubsub"
14) "admin"
15) "fast"
16) "slow"
17) "blocking"
18) "dangerous"
19) "connection"
20) "transaction"
21) "scripting"
```

- 各カテゴリーに属するコマンドの確認

```
127.0.0.1:6379> acl cat geo
 1) "geopos"
 2) "georadiusbymember_ro"
 3) "georadiusbymember"
 4) "georadius_ro"
 5) "geosearchstore"
 6) "geodist"
 7) "geosearch"
 8) "geohash"
 9) "geoadd"
10) "georadius"
```

---

[ACL 設定方法]

- ACL SETUSER コマンド
- 設定ファイルで user ディレクティブを指定
- 設定でファイルで aclfile ディレクティブによって外部設定ファイルを指定

---

- acl setuser コマンド  
  全てのキーに読み取りアクセス可能なユーザーを作成

```
127.0.0.1:6379> acl setuser myuser on >P@ssw0rd ~* +@read
OK
127.0.0.1:6379> acl list
1) "user default on nopass ~* &* +@all"
2) "user myuser on #b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342 ~* resetchannels -@all +@read"
```

- 作成したユーザーの認証

```
127.0.0.1:6379> auth myuser P@ssw0rd
OK
127.0.0.1:6379> auth myuser pass
(error) WRONGPASS invalid username-password pair or user is disabled.
```

- ACL 関連のログの確認  
  コマンドの失敗ログ等が記録されます。

```
127.0.0.1:6379> acl log
1)  1) "count"
    2) (integer) 2
    3) "reason"
    4) "command"
    5) "context"
    6) "toplevel"
    7) "object"
    8) "acl|log"
    9) "username"
   10) "myuser"
   11) "age-seconds"
   12) "19.550999999999998"
   13) "client-info"
   14) "id=3 addr=127.0.0.1:46112 laddr=127.0.0.1:6379 fd=8 name= age=2337 idle=0 flags=N db=0 sub=0 psub=0 ssub=0 multi=-1 qbuf=36 qbuf-free=20438 argv-mem=14 multi-mem=0 rbs=1024 rbp=0 obl=0 oll=0 omem=0 tot-mem=22310 events=r cmd=acl|log user=myuser redir=-1 resp=2"
2)  1) "count"
    2) (integer) 1
    3) "reason"
    4) "auth"
    5) "context"
    6) "toplevel"
    7) "object"
    8) "auth"
    9) "username"
   10) "myuser"
   11) "age-seconds"
   12) "300.495"
   13) "client-info"
   14) "id=3 addr=127.0.0.1:46112 laddr=127.0.0.1:6379 fd=8 name= age=2056 idle=0 flags=N db=0 sub=0 psub=0 ssub=0 multi=-1 qbuf=36 qbuf-free=20438 argv-mem=14 multi-mem=0 rbs=1024 rbp=0 obl=0 oll=0 omem=0 tot-mem=22310 events=r cmd=auth user=myuser redir=-1 resp=2"
```

- acl log reset でログクリア

```
127.0.0.1:6379> acl log reset
OK
127.0.0.1:6379> acl log
(empty array)
```

- セレクターを使用した acl setuser

```
127.0.0.1:6379> acl setuser myuser on >P@ssw0rd (+SET ~test-*) (+SET ~sample-*) (+GET ~sample-*)
OK
127.0.0.1:6379> auth myuser P@ssw0rd
OK
127.0.0.1:6379> set test-1 value-1
OK
127.0.0.1:6379> set sample-1 value-1
OK
127.0.0.1:6379> set key-1
(error) ERR wrong number of arguments for 'set' command
```

## ■ ベンチマーク

- ベンチマーク実行例

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-benchmark -h 192.168.19.197 -P 6379 -n 100000 -r 10000 -P 10 -c 100 -d 15
WARNING: Could not fetch server CONFIG
Error from server: DENIED Redis is running in protected mode because protected mode is enabled and no password is set for the default user. In this mode connections are only accepted from the loopback interface. If you want to connect from external computers to Redis you may adopt one of the following solutions: 1) Just disable protected mode sending the command 'CONFIG SET protected-mode no' from the loopback interface by connecting to Redis from the same host the server is running, however MAKE SURE Redis is not publicly accessible from internet if you do so. Use CONFIG REWRITE to make this change permanent. 2) Alternatively you can just disable the protected mode by editing the Redis configuration file, and setting the protected mode option to 'no', and then restarting the server. 3) If you started the server manually just for testing, restart it with the '--protected-mode no' option. 4) Setup a an authentication password for the default user. NOTE: You only need to do one of the above things in order for the server to start accepting connections from the outside.
```

保護モードが有効な場合、ループバックアドレスを使わないと実行できないようです。

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-benchmark -h 127.0.0.1 -P 6379 -n 100000 -r 10000 -P 10 -c 100 -d 15
====== PING_INLINE ======
  100000 requests completed in 0.26 seconds
  100 parallel clients
  15 bytes payload
  keep alive: 1
  host configuration "save": 3600 1 300 100 60 10000
  host configuration "appendonly": no
  multi-thread: no

Latency by percentile distribution:
0.000% <= 0.495 milliseconds (cumulative count 10)
50.000% <= 1.495 milliseconds (cumulative count 50270)
・・・

Summary:
  throughput summary: 75244.55 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
       12.575     3.488     9.855    25.967    47.327    53.023
```

- -q オプションでコマンド別にベンチマークを測定

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-benchmark -h 127.0.0.1 -P 6379 -n 100000 -r 10000 -q -P 10 -c 100 -d 15
PING_INLINE: 416666.69 requests per second, p50=1.623 msec
PING_MBULK: 414937.75 requests per second, p50=1.231 msec
SET: 181488.20 requests per second, p50=4.023 msec
GET: 166389.34 requests per second, p50=4.295 msec
INCR: 192678.23 requests per second, p50=3.759 msec
LPUSH: 352112.66 requests per second, p50=2.295 msec
RPUSH: 363636.34 requests per second, p50=2.119 msec
LPOP: 333333.31 requests per second, p50=2.391 msec
RPOP: 367647.03 requests per second, p50=2.231 msec
SADD: 369003.69 requests per second, p50=2.167 msec
HSET: 173310.22 requests per second, p50=3.607 msec
SPOP: 411522.62 requests per second, p50=1.543 msec
ZADD: 193423.59 requests per second, p50=4.655 msec
ZPOPMIN: 411522.62 requests per second, p50=1.375 msec
LPUSH (needed to benchmark LRANGE): 358422.91 requests per second, p50=2.247 msec
LRANGE_100 (first 100 elements): 33523.30 requests per second, p50=14.959 msec
LRANGE_300 (first 300 elements): 6917.54 requests per second, p50=56.991 msec
LRANGE_500 (first 500 elements): 6487.19 requests per second, p50=37.407 msec
LRANGE_600 (first 600 elements): 5307.01 requests per second, p50=47.199 msec
MSET (10 keys): 105932.20 requests per second, p50=8.943 msec
```

- -t オプションでベンチマークするコマンドを指定

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-benchmark -h 127.0.0.1 -P 6379 -n 100000 -r 10000 -q -t set,get -P 10 -c
 100 -d 15
SET: 219298.25 requests per second, p50=3.799 msec
GET: 207468.88 requests per second, p50=3.319 msec
```

- csv 形式で出力

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-benchmark -h 127.0.0.1 -P 6379 -n 100000 -r 10000 -q -t set,get -P 10 -c 100 -d 15 --csv
"test","rps","avg_latency_ms","min_latency_ms","p50_latency_ms","p95_latency_ms","p99_latency_ms","max_latency_ms"
"SET","358422.91","2.415","0.984","2.295","3.591","4.511","5.991"
"GET","373134.31","2.189","0.848","2.055","3.543","4.463","5.623"
```

## ■DEBUG コマンド

DEBUG コマンドを使用するには redis.conf の設定値を変更する必要がある  
※config set コマンドでは変更できない

```
# enable-debug-command no
enable-debug-command yes
```

- redis サーバー再起動

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo redis-server /etc/redis/redis.conf
[sudo] password for masami:
```

- DEBUG コマンドは以下で実行できる

```
DEBUG サブコマンド
```

- 疑似的にサーバーのクラッシュ等できる

```
127.0.0.1:6379> debug aof-flush-sleep 1000
OK
127.0.0.1:6379> debug assert
Error: Server closed the connection
not connected> debug digest
0000000000000000000000000000000000000000
127.0.0.1:6379> debug oom
Error: Server closed the connection
not connected> debug panic
Error: Server closed the connection
```

- populate はサンプルデータを生成します。パフォーマンステスト時に便利

```
127.0.0.1:6379> debug populate 1000
OK
```
