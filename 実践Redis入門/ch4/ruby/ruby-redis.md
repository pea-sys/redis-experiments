# Ruby で Redis を操作

- Ruby と redis のインストール
  - build-essential:標準開発ツール一式
  - libssl-dev:SSL/TLS 通信機能を提供する
  - libreadline-dev:コマンド実行履歴を保存・検索するための ReadLine ライブラリ
  - libgdbm-compat-dev:データベース関数ライブラリ
  - libmysqlclient-dev:MySQL クライアントライブラリ

```
sudo apt install build-essential libssl-dev libreadline-dev libgdbm-compat-dev libmysqlclient-dev ruby ruby-bundler ruby-dev -y
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ ruby -v
ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux-gnu]
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo gem install redis
```

Ruby クライアントの作成

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ vi redis-rb-client.rb
```

redis-rb-client.rb

```rb
require 'redis'

redis = Redis.new

redis.set('foo','bar');
value = redis.get('foo');
puts value
```

Redis サーバー起動

````
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-server
1041:C 30 May 2023 07:14:00.404 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
1041:C 30 May 2023 07:14:00.405 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1041, just started
1041:C 30 May 2023 07:14:00.405 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
1041:M 30 May 2023 07:14:00.406 * Increased maximum number of open files to 10032 (it was originally set to 1024).
1041:M 30 May 2023 07:14:00.406 * monotonic clock: POSIX clock_gettime
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 7.0.11 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 1041
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

1041:M 30 May 2023 07:14:00.410 # Server initialized
1041:M 30 May 2023 07:14:00.410 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
1041:M 30 May 2023 07:14:00.457 * Loading RDB produced by version 7.0.11
1041:M 30 May 2023 07:14:00.457 * RDB age 163306 seconds
1041:M 30 May 2023 07:14:00.457 * RDB memory usage when created 0.87 Mb
1041:M 30 May 2023 07:14:00.457 * Done loading RDB, keys loaded: 7, keys expired: 0.
1041:M 30 May 2023 07:14:00.459 * DB loaded from disk: 0.047 seconds
1041:M 30 May 2023 07:14:00.460 * Ready to accept connections
````

Ruby クライアント実行

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ ruby redis-rb-client.rb
bar
```
