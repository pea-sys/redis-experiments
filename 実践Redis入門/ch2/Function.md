## ■Pub/Sub 機能

### [Example1]

Subscriber で購読開始

```
127.0.0.1:6379> subscribe mychannel1 mychannel2 mychannel3
Reading messages... (press Ctrl-C to quit)
1) "subscribe"
2) "mychannel1"
3) (integer) 1
1) "subscribe"
2) "mychannel2"
3) (integer) 2
1) "subscribe"
2) "mychannel3"
3) (integer) 3
1) "message"
2) "mychannel2"
```

Publisher で配信

```
127.0.0.1:6379> publish mychannel2 "Hello, World!"
(integer) 1
```

Subscriber で受信

```
1) "message"
2) "mychannel2"
3) "Hello, World!"
```

### [Example2]

Subscriber で購読開始

```
127.0.0.1:6379> subscribe redis-interest memcached-interest mongodb-interest
Reading messages... (press Ctrl-C to quit)
1) "subscribe"
2) "redis-interest"
3) (integer) 1
1) "subscribe"
2) "memcached-interest"
3) (integer) 2
1) "subscribe"
2) "mongodb-interest"
3) (integer) 3
```

Publisher で配信

```
127.0.0.1:6379> publish redis-interest "Hey, guys. Good news about Redis."
(integer) 1
```

Subscriber で受信

```
1) "message"
2) "redis-interest"
3) "Hey, guys. Good news about Redis."
```

```
127.0.0.1:6379> psubscribe *-interest
Reading messages... (press Ctrl-C to quit)
1) "psubscribe"
2) "*-interest"
3) (integer) 1
```

## ■HyperLogLog 機能

```
127.0.0.1:6379> pfadd counter:day1 visitor1 visitor2 visitor3
(integer) 1
127.0.0.1:6379> pfadd counter:day1 visitor4 visitor5
(integer) 1
127.0.0.1:6379> pfadd counter:day1 visitor6 visitor7
(integer) 1
127.0.0.1:6379> pfcount counter:day1
(integer) 7
127.0.0.1:6379> pfadd counter:day2 visitor8
(integer) 1
127.0.0.1:6379> pfadd counter:day2 visitor2 visitor5 visitor9
(integer) 1
127.0.0.1:6379> pfcount counter:day2
(integer) 4
127.0.0.1:6379> pfmerge count:total counter:day1 counter:day2
OK
127.0.0.1:6379> pfcount count:total
(integer) 9
```

## ■Redis ストリーム

```
127.0.0.1:6379> xadd mystream * name Taro age 32 message "Hello, World!"
"1685012486711-0"
127.0.0.1:6379> xadd mystream * name Jiro age 26 message "Hi, Taro"
"1685012525249-0"
127.0.0.1:6379> xadd mystream * name Saburo age 30 message "Hi, Jiro"
"1685012548648-0"
127.0.0.1:6379> xrange mystream - +
1) 1) "1685012486711-0"
   2) 1) "name"
      2) "Taro"
      3) "age"
      4) "32"
      5) "message"
      6) "Hello, World!"
2) 1) "1685012525249-0"
   2) 1) "name"
      2) "Jiro"
      3) "age"
      4) "26"
      5) "message"
      6) "Hi, Taro"
3) 1) "1685012548648-0"
   2) 1) "name"
      2) "Saburo"
      3) "age"
      4) "30"
      5) "message"
      6) "Hi, Jiro"
127.0.0.1:6379> xrevrange mystream + -
1) 1) "1685012548648-0"
   2) 1) "name"
      2) "Saburo"
      3) "age"
      4) "30"
      5) "message"
      6) "Hi, Jiro"
2) 1) "1685012525249-0"
   2) 1) "name"
      2) "Jiro"
      3) "age"
      4) "26"
      5) "message"
      6) "Hi, Taro"
3) 1) "1685012486711-0"
   2) 1) "name"
      2) "Taro"
      3) "age"
      4) "32"
      5) "message"
      6) "Hello, World!"
127.0.0.1:6379> xlen mystream
(integer) 3
127.0.0.1:6379> xdel mystream 1685012525249-0
(integer) 1
127.0.0.1:6379> xlen mystream
(integer) 2
127.0.0.1:6379> xtrim mystream maxlen = 1
(integer) 1
127.0.0.1:6379> xlen mystream
(integer) 1
```

■ 先に受信待ちするケース

### メッセージ受信待ち

```
127.0.0.1:6379> xread block 0 streams channel:1 $
```

### メッセージ送信

```
127.0.0.1:6379>  xadd channel:1 * name Shiro age 35 message "Hi, Saburo"
"1685015457862-0"
```

### メッセージ受信

```
127.0.0.1:6379> xread block 0 streams channel:1 $
1) 1) "channel:1"
   2) 1) 1) "1685015457862-0"
         2) 1) "name"
            2) "Shiro"
            3) "age"
            4) "35"
            5) "message"
            6) "Hi, Saburo"
(43.30s)
```

■ 送信済み情報を受信するケース

```
127.0.0.1:6379> xread block 0 streams channel:1 1685015716524-0
^Cmasami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli
127.0.0.1:6379> xread block 0 streams channel:1 1685015457862-0
1) 1) "channel:1"
   2) 1) 1) "1685015716524-0"
         2) 1) "name"
            2) "Goro"
            3) "age"
            4) "20"
            5) "message"
            6) "Hi, Shiro"
```

■Consumer Group

```
127.0.0.1:6379> xreadgroup group message-analytics analyzer:1 block 2000 count 10 streams channel:1 >
(nil)
(2.09s)
127.0.0.1:6379> xadd channel:1 * name Rokuro age 26 message "Hi, Goro"
"1685019437857-0"
127.0.0.1:6379> xreadgroup group message-analytics analyzer:1 block 2000 count 10 streams channel:1 >
1) 1) "channel:1"
   2) 1) 1) "1685019437857-0"
         2) 1) "name"
            2) "Rokuro"
            3) "age"
            4) "26"
            5) "message"
            6) "Hi, Goro"
127.0.0.1:6379> xinfo consumers channel:1 message-analytics
1) 1) "name"
   2) "analyzer:1"
   3) "pending"
   4) (integer) 1
   5) "idle"
   6) (integer) 278597
127.0.0.1:6379> xpending channel:1 message-analytics
1) (integer) 1
2) "1685019437857-0"
3) "1685019437857-0"
4) 1) 1) "analyzer:1"
      2) "1"
127.0.0.1:6379> xpending channel:1 message-analytics - + 1
1) 1) "1685019437857-0"
   2) "analyzer:1"
   3) (integer) 338633
   4) (integer) 1
127.0.0.1:6379> xpending channel:1 message-analytics - + 1 analyzer:1
1) 1) "1685019437857-0"
   2) "analyzer:1"
   3) (integer) 362465
   4) (integer) 1
127.0.0.1:6379> xack channel:1 message-anlytics 1685019437857-0
(integer) 0
127.0.0.1:6379> xinfo stream channel:1
 1) "length"
 2) (integer) 4
 3) "radix-tree-keys"
 4) (integer) 1
 5) "radix-tree-nodes"
 6) (integer) 2
 7) "last-generated-id"
 8) "1685019437857-0"
 9) "max-deleted-entry-id"
10) "0-0"
11) "entries-added"
12) (integer) 4
13) "recorded-first-entry-id"
14) "1685015392909-0"
15) "groups"
16) (integer) 1
17) "first-entry"
18) 1) "1685015392909-0"
    2) 1) "name"
       2) "Shiro"
       3) "age"
       4) "35"
       5) "message"
       6) "Hi, Saburo"
19) "last-entry"
20) 1) "1685019437857-0"
    2) 1) "name"
       2) "Rokuro"
       3) "age"
       4) "26"
       5) "message"
       6) "Hi, Goro"
127.0.0.1:6379> xinfo groups channel:1
1)  1) "name"
    2) "message-analytics"
    3) "consumers"
    4) (integer) 1
    5) "pending"
    6) (integer) 1
    7) "last-delivered-id"
    8) "1685019437857-0"
    9) "entries-read"
   10) (integer) 4
   11) "lag"
   12) (integer) 0
```
