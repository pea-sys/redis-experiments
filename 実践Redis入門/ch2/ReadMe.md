## データ型と機能

### String 型

```
127.0.0.1:6379> set user_x 100
OK
127.0.0.1:6379> get user_x
"100"
```

### String 型の数値

```
127.0.0.1:6379> set hit_count 100
OK
127.0.0.1:6379> type hit_count
string
127.0.0.1:6379> incr hit_count
(integer) 101

127.0.0.1:6379> set hit_effect bomb
OK
127.0.0.1:6379> type hit_effect
string
127.0.0.1:6379> incr hit_effect
(error) ERR value is not an integer or out of range
127.0.0.1:6379> incr hit_count
(integer) 102
127.0.0.1:6379> incrby hit_count 8
(integer) 110
127.0.0.1:6379> incrbyfloat hit_count 0.99
"110.99"
127.0.0.1:6379> decr hit_count
(error) ERR value is not an integer or out of range
127.0.0.1:6379> incrbyfloat hit_count 1.01
"112"
127.0.0.1:6379> decr hit_count
(integer) 111
127.0.0.1:6379> decrby hit_count 10
(integer) 101

```

### String 型共通コマンドサンプル

```
127.0.0.1:6379> set hit_str hello
OK
127.0.0.1:6379> get hit_str
"hello"
127.0.0.1:6379> mset hit_str:case1 hello hit_str:case2 world
OK
127.0.0.1:6379> mget hit_str:case1 hit_str:case2
1) "hello"
2) "world"
127.0.0.1:6379> append hit_str:case1  world
(integer) 10
127.0.0.1:6379> get hit_str:case1
"helloworld"
127.0.0.1:6379> strlen hit_str:case1
(integer) 10
127.0.0.1:6379> getrange hit_str:case1 0 4
"hello"
127.0.0.1:6379> setrange hit_str:case1 0 H
(integer) 10
127.0.0.1:6379> get hit_str:case1
"Helloworld"
127.0.0.1:6379> getex hit_str:case1 ex 30
"Helloworld"
127.0.0.1:6379> get hit_str:case1
(nil)
127.0.0.1:6379> getdel hit_str:case2
"world"
127.0.0.1:6379> get hit_str:case2
(nil)
127.0.0.1:6379> set exist 1
OK
127.0.0.1:6379> msetnx exist not_exist 0 0
(integer) 0
127.0.0.1:6379> msetnx not_exist 0
(integer) 1
127.0.0.1:6379> set nx_case 1 nx
OK
127.0.0.1:6379> set nx_case 1 nx
(nil)
```

### List 型

```
127.0.0.1:6379> lpush mylist foo bar baz
(integer) 3
127.0.0.1:6379> lrange mylist 0 -1
1) "baz"
2) "bar"
3) "foo"
127.0.0.1:6379> lpop mylist 1
1) "baz"
127.0.0.1:6379> lpush mylist "baz"
(integer) 3
127.0.0.1:6379> rpop mylist 3
1) "foo"
2) "bar"
3) "baz"
127.0.0.1:6379> lpush mylist foo bar baz
(integer) 3
127.0.0.1:6379> rpush mylist hoge
(integer) 4
127.0.0.1:6379> rpop mylist
"hoge"
127.0.0.1:6379> lmpop 1 mylist right count 1
1) "mylist"
2) 1) "foo"
127.0.0.1:6379> blmpop 60 1 mylist left count 2
1) "mylist"
2) 1) "baz"
   2) "bar"
127.0.0.1:6379> rpush mylist foo bar baz
(integer) 3
127.0.0.1:6379> lindex mylist1
(error) ERR wrong number of arguments for 'lindex' command
127.0.0.1:6379> lindex mylist 1
"bar"
127.0.0.1:6379> linsert mylist before foo hello
(integer) 4
127.0.0.1:6379> lrange mylist 0 -1
1) "hello"
2) "foo"
3) "bar"
4) "baz"
127.0.0.1:6379> llen mylist
(integer) 4
127.0.0.1:6379> lrange mylist 2 3
1) "bar"
2) "baz"
127.0.0.1:6379> lrem mylist -1 hello
(integer) 1
127.0.0.1:6379> lrange mylist 0 -1
1) "foo"
2) "bar"
3) "baz"
127.0.0.1:6379> lrem mylist 2 foo
(integer) 1
127.0.0.1:6379> lrange mylist 0 -1
1) "bar"
2) "baz"
127.0.0.1:6379> lset mylist 0 foo
OK
127.0.0.1:6379> lrange mylist 0 -1
1) "foo"
2) "baz"
127.0.0.1:6379> ltrim mylist 0 0
OK
127.0.0.1:6379> lrange mylist 0 -1
1) "foo"
127.0.0.1:6379> lpos mylist foo
(integer) 0
127.0.0.1:6379> lpos mylist fool
(nil)
127.0.0.1:6379> lpushx no_exist a b c
(integer) 0
127.0.0.1:6379> lpushx mylist a b c
(integer) 4
127.0.0.1:6379> lmove mylist movelist right left
"foo"
127.0.0.1:6379> lrange movelist 0 -1
1) "foo"
127.0.0.1:6379> lrange mylist 0 -1
1) "c"
2) "b"
3) "a"
127.0.0.1:6379> rpushx mylist d
(integer) 4
127.0.0.1:6379> blpop mylist 0
1) "mylist"
2) "c"
127.0.0.1:6379> brpop mylist 10
1) "mylist"
2) "d"
```

### Hash 型共通コマンドサンプル

```
127.0.0.1:6379> hset user user_id 100 user_level 99
(integer) 2
127.0.0.1:6379> get user
(error) WRONGTYPE Operation against a key holding the wrong kind of value
127.0.0.1:6379> mset user_x 100 user_y 200 user_z 300
OK
127.0.0.1:6379> mget user_x user_y
1) "100"
2) "200"
127.0.0.1:6379> hset myhash field1 values1 field2 value2 field value3
(integer) 3
127.0.0.1:6379> hget myhash field1
"values1"
127.0.0.1:6379> hset user:1 name "Suzuki Taro" age 30
(integer) 2
127.0.0.1:6379> hdel user:1 age
(integer) 1
127.0.0.1:6379> hexists user:1 name
(integer) 1
127.0.0.1:6379> hgetall user:1
1) "name"
2) "Suzuki Taro"
127.0.0.1:6379> hkeys user:1
1) "name"
127.0.0.1:6379> hmset user:1 name "Yamada Taro"
OK
127.0.0.1:6379> hset user:1 name "Satou Ichiro"
(integer) 0
127.0.0.1:6379> hvals user:1
1) "Satou Ichiro"
127.0.0.1:6379> hscan user:1 0
1) "0"
2) 1) "name"
   2) "Satou Ichiro"
127.0.0.1:6379> hsetnx myhash hoge fuga
(integer) 1
127.0.0.1:6379> hsetnx myhash hoge fuga
(integer) 0
127.0.0.1:6379> hstrlen myhash hoge
(integer) 4
127.0.0.1:6379> hrandfield myhash
"hoge"
```

### Hash 型の数値

```
127.0.0.1:6379> hset user weight 70 height 180
(integer) 2
127.0.0.1:6379> hincrby user weight 5
(integer) 75
127.0.0.1:6379> hincrbyfloat user height 0.5
"180.5"

```

### Set 型

```
127.0.0.1:6379> sadd myset member1 member2 member3
(integer) 3
127.0.0.1:6379> smembers myset
1) "member2"
2) "member3"
3) "member1"
127.0.0.1:6379> scard myset
(integer) 3
127.0.0.1:6379> sismember myset member1
(integer) 1
127.0.0.1:6379> sismember myset member99
(integer) 0
127.0.0.1:6379> smembers myset
1) "member2"
2) "member3"
3) "member1"
127.0.0.1:6379> spop myset 1
1) "member1"
127.0.0.1:6379> sscan myset 0
1) "0"
2) 1) "member3"
127.0.0.1:6379> sscan myset 0
1) "0"
2) 1) "member3"
127.0.0.1:6379> sadd myset2 member1 member2 member3
(integer) 3
127.0.0.1:6379> sdiff myset
1) "member3"
127.0.0.1:6379> sdiff myset myset2
(empty array)
127.0.0.1:6379> sdiff myset2 myset
1) "member2"
2) "member1"
127.0.0.1:6379> sdiffstore myset2 myset
(integer) 1
127.0.0.1:6379> sadd myset member1 member2
(integer) 2
127.0.0.1:6379> sinter myset myset2
1) "member3"
127.0.0.1:6379> sinterstore myset myset2
(integer) 1
127.0.0.1:6379> smembers myset2
1) "member3"
127.0.0.1:6379> sunion myset myset2
1) "member3"
127.0.0.1:6379> sunionstore myset myset2
(integer) 1
127.0.0.1:6379> smismember myset member1
1) (integer) 0
127.0.0.1:6379> smismember myset member3
1) (integer) 1
127.0.0.1:6379> smove myset myset2 member3
(integer) 1
```

### SortedSet

```
127.0.0.1:6379> zadd myzset 123 member1
(integer) 1
127.0.0.1:6379> zadd myzset 321 member2
(integer) 1
127.0.0.1:6379> zadd myzset 700 member3
(integer) 1
127.0.0.1:6379> zadd myzset 200 member4
(integer) 1
127.0.0.1:6379> zcard myzset
(integer) 4
127.0.0.1:6379> zrank myzset member2
(integer) 2
127.0.0.1:6379> zrevrank myzset member2
(integer) 1
127.0.0.1:6379> zrange myzset 1 3
1) "member4"
2) "member2"
3) "member3"
127.0.0.1:6379> zrangestore myzset2 myzset 1 3
(integer) 3
127.0.0.1:6379> zcount myzset (123 700
(integer) 3
127.0.0.1:6379> zpopmax myzset
1) "member3"
2) "700"
127.0.0.1:6379> zpopmin myzset
1) "member1"
2) "123"
127.0.0.1:6379> zscore myzset member2
"321"
127.0.0.1:6379> zmscore myzset member4 member2
1) "200"
2) "321"
127.0.0.1:6379> zscan myzset 1
1) "0"
2) 1) "member4"
   2) "200"
   3) "member2"
   4) "321"
127.0.0.1:6379> zmpop 1 myzset MIN
1) "myzset"
2) 1) 1) "member4"
      2) "200"
127.0.0.1:6379> zadd myzset2 739 number4
(integer) 1
127.0.0.1:6379> zadd myzset2 39 number5
(integer) 1
127.0.0.1:6379> zadd myzset2 9 number7
(integer) 1
127.0.0.1:6379> zdiff 2 myzset2 myzset
1) "number7"
2) "number5"
3) "member4"
4) "member3"
5) "number4"
127.0.0.1:6379> zdiffstore myzset2 2 myzset2 myzset
(integer) 5
127.0.0.1:6379> zunion 2 myzset myzset2
1) "number7"
2) "number5"
3) "member4"
4) "member2"
5) "member3"
6) "number4"
127.0.0.1:6379> zremrangebylex myzset2 [number3 [number5
(integer) 0
127.0.0.1:6379> zremrangebyrank myzset2 2 3
(integer) 2
127.0.0.1:6379> zrange myzset2 0 -1
1) "number7"
2) "number5"
3) "number4"
127.0.0.1:6379> zremrangebyscore myzset2 -inf 50
(integer) 2
127.0.0.1:6379> zrange myzset2 0 -1
1) "number4"
127.0.0.1:6379> zrandmember myzset2
"number4"
127.0.0.1:6379> zincrby myzset 10 member4
"10"
127.0.0.1:6379> bzpopmin myzset2 10
1) "myzset2"
2) "number4"
3) "739"
127.0.0.1:6379> bzpopmax myzset 10
1) "myzset"
2) "member2"
3) "321"
```

### Bitmap

```
127.0.0.1:6379> setbit visitor:20220829 100 1
(integer) 0
127.0.0.1:6379> setbit visitor:20220829 200 1
(integer) 0
127.0.0.1:6379> setbit visitor:20220829 300 1
(integer) 0
127.0.0.1:6379> getbit visitor:20220829 300
(integer) 1
127.0.0.1:6379> getbit visitor:20220829 301
(integer) 0
127.0.0.1:6379> getbit visitor:20220830 200 1
(error) ERR wrong number of arguments for 'getbit' command
127.0.0.1:6379> setbit visitor:20220830 200 1
(integer) 0
127.0.0.1:6379> setbit visitor:20220830 400 1
(integer) 0
127.0.0.1:6379> setbit visitor:20220830 00 1
(error) ERR bit offset is not an integer or out of range
127.0.0.1:6379> setbit visitor:20220830 500 1
(integer) 0
127.0.0.1:6379> setbit visitor:20220830 600 1
(integer) 0
127.0.0.1:6379> setbit visitor:20220830 700 1
(integer) 0
127.0.0.1:6379> bitop or visitor:20220829-20220830 visitor:30330839 visitor:20220830
(integer) 88
127.0.0.1:6379> bitcount visitor:20220829-20220830
(integer) 5
```

### 地理空間インデックス

```
127.0.0.1:6379> geoadd building-location 139.7671248 35.6812362 "Tokyo Station" 135.4937619 34.7024854 "Osaka Station"
(integer) 2
127.0.0.1:6379> geohash building-location "Tokyo Station" "Osaka Station"
1) "xn76urx6600"
2) "xn0m7jrs9k0"
127.0.0.1:6379> geopos building-location "Tokyo Station"
1) 1) "139.76712495088577271"
   2) "35.68123554127875963"
127.0.0.1:6379> geodist building-location "Tokyo Station" "Osaka Station"
"403362.9301"
127.0.0.1:6379> georadius building-location 140 30 700 km
1) "Osaka Station"
2) "Tokyo Station"
127.0.0.1:6379> georadius building-location 140 30 650 km
1) "Tokyo Station"
127.0.0.1:6379> georadius building-location 140 30 100 km
(empty array)
127.0.0.1:6379> georadiusbymember building-location "Tokyo Station" 400 km
1) "Tokyo Station"
127.0.0.1:6379> georadiusbymember building-location "Tokyo Station" 410 km
1) "Osaka Station"
2) "Tokyo Station"
```

### キー検索

```
127.0.0.1:6379> keys *
1) "user_y"
2) "user"
3) "mykey"
4) "user_z"
5) "user_x"
```

### キー存在確認

```
127.0.0.1:6379> set x valueX
OK
127.0.0.1:6379> exists x
(integer) 1
127.0.0.1:6379> exists y
(integer) 0
127.0.0.1:6379> exists x y
(integer) 1
127.0.0.1:6379> set z valueZ
OK
127.0.0.1:6379> exists x y z
(integer) 2
```

### 型確認

```
127.0.0.1:6379> set mykey myvalue
OK
127.0.0.1:6379> hset myhash myfield myvalue
(integer) 1
127.0.0.1:6379> type mykey
string
127.0.0.1:6379> type myhash
hash
```

### キー削除

```
127.0.0.1:6379> mset l 0 m 0 n 0
OK
127.0.0.1:6379> exists l m n
(integer) 3
127.0.0.1:6379> del l
(integer) 1
127.0.0.1:6379> exists l m n
(integer) 2
127.0.0.1:6379> del m n
(integer) 2
127.0.0.1:6379> exists l m n
(integer) 0
```

### その他

```
127.0.0.1:6379> flushdb
OK
127.0.0.1:6379> exists channel:1
(integer) 1
127.0.0.1:6379> ttl channel:1
(integer) -1
127.0.0.1:6379> expire channel:1 365
(integer) 1
127.0.0.1:6379> ttl channel:1
(integer) 363
127.0.0.1:6379> pttl channel:1
(integer) 340360
127.0.0.1:6379> persist channel:1
(integer) 1
127.0.0.1:6379> pttl channel:1
(integer) -1
127.0.0.1:6379> dbsize
(integer) 12
```
