## ■ パイプライン

前のリクエストへのレスポンスを待たずに、新しいリクエストを送ることを可能にする機能　　
他のクライアントの処理が割り込む可能性がある

netcat で Redis サーバにアクセス

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ echo -e "TIME\n\nPING\r\nECHO \"test\"\r\n" | nc localhost 6379
*2
$10
1685097205
$6
875761
+PONG
$4
test
```

## ■ エフェメラルスクリプト

Lua を使用することで Redis 組み込みスクリプトが作成できる。  
パイプラインと異なり、アトミックな操作が可能。パイプラインと異なり、条件分岐等可能。

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo snap install ruby --classic
ruby 3.2.2 from Ruby core team (rubylang✓) installed
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ gem install redis
Fetching connection_pool-2.4.1.gem
Fetching redis-5.0.6.gem
Fetching redis-client-0.14.1.gem
Successfully installed connection_pool-2.4.1
Successfully installed redis-client-0.14.1
Successfully installed redis-5.0.6
Parsing documentation for connection_pool-2.4.1
Installing ri documentation for connection_pool-2.4.1
Parsing documentation for redis-client-0.14.1
Installing ri documentation for redis-client-0.14.1
Parsing documentation for redis-5.0.6
Installing ri documentation for redis-5.0.6
Done installing documentation for connection_pool, redis-client, redis after 1 seconds
3 gems installed

A new release of RubyGems is available: 3.4.10 → 3.4.13!
Run `gem update --system 3.4.13` to update your installation.

masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ ruby sample.rb

```

- eval コマンドによる生スクリプト

```
127.0.0.1:6379> eval "local val = 0; for i = 1, ARGV[1] do val = val + i; end; return val" 0 10
(integer) 55
127.0.0.1:6379> eval "return {KEYS[1],KEYS[2],ARGV[1],ARGV[2],ARGV[3]}" 2 key1 key2 value1 value2 value3
1) "key1"
2) "key2"
3) "value1"
4) "value2"
5) "value3"
```

- evalsha によるスクリプトのロード実行

```
127.0.0.1:6379> evalsha "5b62720354d3ac0755d47fe9d802b4be77bbecdc" 2 key1 key2 value1 value2 value3
1) "key1"
2) "key2"
3) "value1"
4) "value2"
5) "value3"
```

- キャッシュ済みスクリプトか確認

```
127.0.0.1:6379> script exists "5b62720354d3ac0755d47fe9d802b4be77bbecdc"
1) (integer) 1
```

- スクリプトの停止

#無限ループスクリプト

```
127.0.0.1:6379> eval 'redis.call("SET",KEYS[1],"bar");while 1 do redis.debug("infinite loop") end' 1 foo
```

無限ループ中は SHUTDOWN Nosave しか受け付けない

```
127.0.0.1:6379> ping
(error) BUSY Redis is busy running a script. You can only call SCRIPT KILL or SHUTDOWN NOSAVE.
```

Redis サーバーにログが書き出される

```
775:M 26 May 2023 22:59:21.867 # Slow script detected: still in execution after 5001 milliseconds. You can try killing the script using the SCRIPT KILL command. Script name is: 9ea8f8d471472f538655b61ee817caec10060768.
```

shutdown nosave 以外受け付けない

```
127.0.0.1:6379> script kill
(error) UNKILLABLE Sorry the script already executed write commands against the dataset. You can either wait the script termination or kill the server in a hard way using the SHUTDOWN NOSAVE command.
127.0.0.1:6379> shutdown nosave
not connected>
```

- redis-cli からの実行

test.lua

```lua
return {KEYS[1],KEYS[2],ARGV[1],ARGV[2],ARGV[3]}
```

ターミナル

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli --eval test.lua key1 key2 , values1 value2 value3
1) "key1"
2) "key2"
3) "values1"
4) "value2"
5) "value3"
```

test2.lua(フラグ付き)

```lua
#!lua flags=no-writes,allow-stale
local result = redis.call('get','x')
return result
```

フラグの種類

| フラグ                | 説明                                                   |
| --------------------- | ------------------------------------------------------ |
| no-writes             | データの読み込みのみを行う                             |
| allow-oom             | Redis サーバが OOM の状況でも実行可能                  |
| allow-stale           | Redis クラスター内で実行不可                           |
| allow-cross-slot-keys | Redis クラスターで複数のスロットからキーにアクセスする |

ターミナル

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli
127.0.0.1:6379> set x value
OK
127.0.0.1:6379> quit
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli --eval test2.lua
"value"
```

- lua のデバッグ

debug-sample.lua

```
local key  = 'test'

redis.call('SET',key, 10)
local result = redis.call('incr', key)

return result
```

ターミナル

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli --ldb --eval debug-sample.lua
Lua debugging session started, please use:
quit    -- End the session.
restart -- Restart the script in debug mode again.
help    -- Show Lua script debugging commands.

* Stopped at 1, stop reason = step over
-> 1   local key  = 'test'
lua debugger> help
Redis Lua debugger help:
[h]elp               Show this help.
[s]tep               Run current line and stop again.
[n]ext               Alias for step.
[c]ontinue           Run till next breakpoint.
[l]ist               List source code around current line.
[l]ist [line]        List source code around [line].
                     line = 0 means: current position.
[l]ist [line] [ctx]  In this form [ctx] specifies how many lines
                     to show before/after [line].
[w]hole              List all source code. Alias for 'list 1 1000000'.
[p]rint              Show all the local variables.
[p]rint <var>        Show the value of the specified variable.
                     Can also show global vars KEYS and ARGV.
[b]reak              Show all breakpoints.
[b]reak <line>       Add a breakpoint to the specified line.
[b]reak -<line>      Remove breakpoint from the specified line.
[b]reak 0            Remove all breakpoints.
[t]race              Show a backtrace.
[e]val <code>        Execute some Lua code (in a different callframe).
[r]edis <cmd>        Execute a Redis command.
[m]axlen [len]       Trim logged Redis replies and Lua var dumps to len.
                     Specifying zero as <len> means unlimited.
[a]bort              Stop the execution of the script. In sync
                     mode dataset changes will be retained.

Debugger functions you can call from Lua scripts:
redis.debug()        Produce logs in the debugger console.
redis.breakpoint()   Stop execution like if there was a breakpoint in the
                     next line of code.
lua debugger> l
-> 1   local key  = 'test'
   2
   3   redis.call('SET',key, 10)
   4   local result = redis.call('incr', key)
   5
   6   return result
lua debugger> b 4
   3   redis.call('SET',key, 10)
  #4   local result = redis.call('incr', key)
   5
lua debugger> c
* Stopped at 4, stop reason = break point
->#4   local result = redis.call('incr', key)
lua debugger> s
<redis> incr test
<reply> 11
* Stopped at 6, stop reason = step over
-> 6   return result
lua debugger> p result
<value> 11
lua debugger> c

(integer) 11

(Lua debugging session ended -- dataset changes rolled back)
```

## ■ Redis ファンクション

```
127.0.0.1:6379> function load "#!lua name=mylib\nredis.register_function('calculator', function(keys,args) local val = 0; for i = 1, args[1] do val = val + i; end; return val end)"
"mylib"
127.0.0.1:6379> fcall calculator 0  10
(integer) 55
127.0.0.1:6379> function delete mylib
OK
127.0.0.1:6379> fcall calculator 0  10
(error) ERR Function not found
```

ファイルから redis ファンクションに登録する

- mylib.lua

```lua
#!lua name=mylib

local function sum(keys, args)
    local val = 0
    for i = 1, args[1] do
        val = val + i
    end

    return val
end

redis.register_function('calculator', sum)
```

- ターミナル

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ cat mylib.lua | redis-cli -x function load replace
"mylib"
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli
127.0.0.1:6379> fcall calculator 0  10
(integer) 55
```

Redis ファンクションのダンプと restore

```
127.0.0.1:6379> function dump
"\xf5\xc3@\xa2@\xc5\x1f#!lua name=mylib\r\n\r\nlocal functi\x14on sum(keys, args)\r\n  \x00\x80#\x00v '\x02= 0\x80\x12\x04for i \x0e\x001\x80(\x05[1] do\x80\x1a@\x00\x80+@\x05\x02+ i\x80\x16\x02end@o@\x1d\x05return@\x1e\x01\r\n\xa0\x16\x0eredis.register_\xc0\x8f\x01(' \x9d\bculator', \x9d\x01m)\n\x00\xbc[N\x9a\xb0\xb0\x0b\x17"
127.0.0.1:6379> function flush
OK
127.0.0.1:6379> function restore "\xf5\xc3@\xa2@\xc5\x1f#!lua name=mylib\r\n\r\nlocal functi\x14on sum(keys, args)\r\n  \x00\x80#\x00v '\x02= 0\x80\x12\x04for i \x0e\x001\x80(\x05[1] do\x80\x1a@\x00\x80+@\x05\x02+ i\x80\x16\x02end@o@\x1d\x05return@\x1e\x01\r\n\xa0\x16\x0eredis.register_\xc0\x8f\x01(' \x9d\bculator', \x9d\x01m)\n\x00\xbc[N\x9a\xb0\xb0\x0b\x17"
OK
127.0.0.1:6379> function list
1) 1) "library_name"
   2) "mylib"
   3) "engine"
   4) "LUA"
   5) "functions"
   6) 1) 1) "name"
         2) "calculator"
         3) "description"
         4) (nil)
         5) "flags"
         6) (empty array)
```

Redis ファンクションの Call 回数

```
127.0.0.1:6379> function stats
1) "running_script"
2) (nil)
3) "engines"
4) 1) "LUA"
   2) 1) "libraries_count"
      2) (integer) 1
      3) "functions_count"
      4) (integer) 1
```

Redis ファンクションのフラグ

```
127.0.0.1:6379> fcall_ro calculator 0 10
(error) ERR Can not execute a script with write flag using *_ro command.
```

スクリプト登録時にフラグをセットする必要がある

- mylib-ro.lua

```lua
local function sum(keys, args)
    local val = 0
    for i = 1, args[1] do
        val = val + i
    end

    return val
end

redis.register_function{
                        function_name = 'calculator',
                        callback = sum,
                        flags = { 'no-writes' }}
```

- ターミナル

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ cat mylib-ro.lua | redis-cli -x function load replace
"mylib"
fcall_ro: command not found
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli
127.0.0.1:6379> fcall_ro calculator 0 10
(integer) 55
```

- redis.pcall は redis.call と異なり、例外が出ても次の処理に進む

```
# call
127.0.0.1:6379> eval "redis.call('set',KEYS[1],ARGV[1]); redis.call('incr',KEYS[1]);redis.call('set',KEYS[2],ARGV[2]);return 1;" 2 key1 key2 value1 value2
(error) ERR value is not an integer or out of range script: 2246a3e5152e239878c654f19ad8df80fd8222ed, on @user_script:1.
127.0.0.1:6379> et key1
(error) ERR unknown command 'et', with args beginning with: 'key1'
127.0.0.1:6379> get key1
"value1"
127.0.0.1:6379> get key2
(nil)
# pcall
127.0.0.1:6379> eval "redis.call('set',KEYS[1],ARGV[1]); local result = redis.pcall('incr',KEYS[1]);redis.call('set',KEYS[2],ARGV[2]);return result;" 2 key3 key4 value3 value4
(error) ERR value is not an integer or out of range
127.0.0.1:6379> get key3
"value3"
127.0.0.1:6379> get key4
"value4"
```

## トランザクション

- 正常系

```
127.0.0.1:6379> multi
OK
127.0.0.1:6379(TX)> set foo 10
QUEUED
127.0.0.1:6379(TX)> incr foo
QUEUED
127.0.0.1:6379(TX)> incr foo
QUEUED
127.0.0.1:6379(TX)>  get foo
QUEUED
127.0.0.1:6379(TX)> exec
1) OK
2) (integer) 11
3) (integer) 12
4) "12"
```

- 異常系(コマンドのキューイング失敗)※実行されない

```
127.0.0.1:6379> multi
OK
127.0.0.1:6379(TX)> set foo 10
QUEUED
127.0.0.1:6379(TX)> incr foo
QUEUED
127.0.0.1:6379(TX)> incr foo
QUEUED
127.0.0.1:6379(TX)> get foo
QUEUED
127.0.0.1:6379(TX)> set foo "bar"
QUEUED
127.0.0.1:6379(TX)> nosuchacommand foo
(error) ERR unknown command 'nosuchacommand', with args beginning with: 'foo'
127.0.0.1:6379(TX)> incr foo
QUEUED
127.0.0.1:6379(TX)> get foo
QUEUED
127.0.0.1:6379(TX)> exec
(error) EXECABORT Transaction discarded because of previous errors.
```

- 異常系(コマンドの失敗)※ロールバックしない

```
127.0.0.1:6379> multi
OK
127.0.0.1:6379(TX)> set foo 10
QUEUED
127.0.0.1:6379(TX)> incr foo
QUEUED
127.0.0.1:6379(TX)> incr foo
QUEUED
127.0.0.1:6379(TX)> get foo
QUEUED
127.0.0.1:6379(TX)> set foo "bar"
QUEUED
127.0.0.1:6379(TX)> incr foo
QUEUED
127.0.0.1:6379(TX)> incr foo
QUEUED
127.0.0.1:6379(TX)> get foo
QUEUED
127.0.0.1:6379(TX)> exec
1) OK
2) (integer) 11
3) (integer) 12
4) "12"
5) OK
6) (error) ERR value is not an integer or out of range
7) (error) ERR value is not an integer or out of range
8) "bar"
127.0.0.1:6379> get foo
"bar"
```

## ■ モジュール

- モジュールのコンパイル

```
gcc -shared -o mymodule.so -fPIC /mnt/c/Users/user/redis/src/modules/mymodule.c
```

- モジュールをロードしようとすると失敗する

```
127.0.0.1:6379> module load mymodule.so
(error) ERR MODULE command not allowed. If the enable-module-command option is set to "local", you can run it from a local connection, otherwise you need to set this option in the configuration file, and then restart the server.
```

- redis.conf を書き換えて Redis サーバー再起動
  ※redis.conf は以下からダウンロードできる  
  https://redis.io/docs/management/config/

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-server /mnt/c/Users/user/redis.conf
```

- redis-cli でモジュールのロードと確認・実行

```
127.0.0.1:6379> module load /mnt/c/Users/user/mymodule.so
OK
127.0.0.1:6379> module list
1) 1) "name"
   2) "mymodule"
   3) "ver"
   4) (integer) 1
   5) "path"
   6) "/mnt/c/Users/user/mymodule.so"
   7) "args"
   8) (empty array)
127.0.0.1:6379> mymodule.hello Taro
"Welcom, Taro!"
127.0.0.1:6379> module unload mymodule
OK
127.0.0.1:6379> mymodule.hello Taro
(error) ERR unknown command 'mymodule.hello', with args beginning with: 'Taro'
```

ロードが成功するとサーバにログ出力される

```
488:M 27 May 2023 18:29:20.739 * Module 'mymodule' loaded from /mnt/c/Users/user/mymodule.so
```

## ■ キー空間通知

設定の有効化

```
127.0.0.1:6379> config set 'notify-keyspace-events' AKE
OK
```

クライアントで購読開始

```
127.0.0.1:6379> psubscribe *
Reading messages... (press Ctrl-C to quit)
1) "psubscribe"
2) "*"
3) (integer) 1
```

試しに RedisInsight でキーを削除や追加をするとクライアントに通知が来ます。

```
1) "pmessage"
2) "*"
3) "__keyspace@0__:key1"
4) "del"
1) "pmessage"
2) "*"
3) "__keyevent@0__:del"
4) "key1"
1) "pmessage"
2) "*"
3) "__keyspace@0__:aiueo"
4) "hset"
1) "pmessage"
2) "*"
3) "__keyevent@0__:hset"
4) "aiueo"
```

## ■ クライアントサイドキャッシュ

クライアントサイドキャッシュを利用することで、redis サーバとのやり取りを減らします。サーバからの通知によってキャッシュは無効化します。  
ここでは通知を確認します。

クライアント ID の確認

```
127.0.0.1:6379> CLIENT ID
(integer) 12
```

通知クライアントの設定

```
127.0.0.1:6379> subscribe __redis__:invalidate
Reading messages... (press Ctrl-C to quit)
1) "subscribe"
2) "__redis__:invalidate"
3) (integer) 1
```

別のクライアントを立ち上げて、無効化メッセージを最初のクライアントの ID に送るようにします。
データが変更されるたびに、サーバーはリスニングしているクライアントに無効化メッセージを送信します。

```
127.0.0.1:6379> CLIENT TRACKING on REDIRECT 12
OK
```

データを登録し、一度取得しクライアントキャッシュに載せます。

```
127.0.0.1:6379> set cat_one:key_one "Anapest"
OK
127.0.0.1:6379> GET cat_one:key_one
"Anaphora"
```

その後、データをセットします。

```
127.0.0.1:6379> SET cat_one:key_one "Anapest"
OK
```

そうすると、通知クライアントには以下のように出力されます。

```
1) "message"
2) "__redis__:invalidate"
3) 1) "cat_one:key_one"
```

どうも、get した後に set をすると値が変化していなくても通知がいくようです。
