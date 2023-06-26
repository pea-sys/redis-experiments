### redis-cli オプション

- レイテンシー情報の継続取得

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli --latency
min: 0, max: 30, avg: 0.35 (7375 samples)
```

- 15 秒間隔で改行

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli --latency-history
min: 0, max: 1, avg: 0.36 (1413 samples) -- 15.00 seconds range
min: 0, max: 4, avg: 0.40 (1410 samples) -- 15.01 seconds range
min: 0, max: 1, avg: 0.37 (1410 samples) -- 15.01 seconds range
min: 0, max: 1, avg: 0.37 (1410 samples) -- 15.00 seconds range
min: 0, max: 1, avg: 0.37 (1411 samples) -- 15.01 seconds range
min: 0, max: 1, avg: 0.39 (1406 samples) -- 15.00 seconds range
min: 0, max: 1, avg: 0.36 (1411 samples) -- 15.00 seconds range
```

- スペクトラムで表示

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli --latency-dist
---------------------------------------------
. - * #          .01 .125 .25 .5 milliseconds
1,2,3,...,9      from 1 to 9     milliseconds
A,B,C,D,E        10,20,30,40,50  milliseconds
F,G,H,I,J        .1,.2,.3,.4,.5       seconds
K,L,M,N,O,P,Q,?  1,2,4,8,16,30,60,>60 seconds
From 0 to 100%:
---------------------------------------------
.-*#123456789ABCDEFGHIJKLMNOPQ?
.-*#123456789ABCDEFGHIJKLMNOPQ?
.-*#123456789ABCDEFGHIJKLMNOPQ?
.-*#123456789ABCDEFGHIJKLMNOPQ?
.-*#123456789ABCDEFGHIJKLMNOPQ?
.-*#123456789ABCDEFGHIJKLMNOPQ?
.-*#123456789ABCDEFGHIJKLMNOPQ?
.-*#123456789ABCDEFGHIJKLMNOPQ?
.-*#123456789AB
```

- 指定した時間だけカーネルが稼働プロセスを遅延させている最大時間を測定

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli --intrinsic-latency 10
Max latency so far: 1 microseconds.
Max latency so far: 12 microseconds.
Max latency so far: 25 microseconds.
Max latency so far: 26 microseconds.
Max latency so far: 30 microseconds.
Max latency so far: 37 microseconds.
Max latency so far: 63 microseconds.
Max latency so far: 282 microseconds.
Max latency so far: 462 microseconds.
Max latency so far: 513 microseconds.
Max latency so far: 583 microseconds.
Max latency so far: 1014 microseconds.
Max latency so far: 1386 microseconds.
Max latency so far: 9005 microseconds.
Max latency so far: 10822 microseconds.

124295762 total runs (avg latency: 0.0805 microseconds / 80.45 nanoseconds per run).
Worst run took 134513x longer than the average latency.
```

### レイテンシーモニタリング

- レイテンシーモニタリングを使用する際には 設定変更が必要

```

127.0.0.1:6379> latency doctor
I'm sorry, Dave, I can't do that. Latency monitoring is disabled in this Redis instance. You may use "CONFIG SET latency-monitor-threshold <milliseconds>." in order to enable it. If we weren't in a deep space mission I'd suggest to take a look at https://redis.io/topics/latency-monitor.

```

```
127.0.0.1:6379> CONFIG SET latency-monitor-threshold 10
OK
```

```
127.0.0.1:6379> latency help

1.  LATENCY <subcommand> [<arg> [value] [opt] ...]. Subcommands are:
2.  DOCTOR
3.        Return a human readable latency analysis report.
4.  GRAPH <event>
5.        Return an ASCII latency graph for the <event> class.
6.  HISTORY <event>
7.        Return time-latency samples for the <event> class.
8.  LATEST
9.        Return the latest latency samples for all events.
10. RESET [<event> ...]
11.     Reset latency data of one or more <event> classes.
12.     (default: reset all data for all event classes)
13. HISTOGRAM [COMMAND ...]
14.     Return a cumulative distribution of latencies in the format of a histogram for the specified command names.
15.     If no commands are specified then all histograms are replied.
16. HELP
17.     Prints this help.

```

- Latency doctor

```
127.0.0.1:6379> latency doctor

I have a few advices for you:

- I detected a non zero amount of anonymous huge pages used by your process. This creates very serious latency events in different conditions, especially when Redis is persisting on disk. To disable THP support use the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled', make sure to also add it into /etc/rc.local so that the command will be executed again after a reboot. Note that even if you have already disabled THP, you still need to restart the Redis process to get rid of the huge pages already created.
```

- Lantency Graph <event-name>

```
127.0.0.1:6379> latency graph command
command - high 11 ms, low 10 ms (all time high 11 ms)
--------------------------------------------------------------------------------
  ##  ##### #
  ||  ||||| |
  ||  ||||| |
__||__|||||_|

1154433222111
mm83242432750
  sssssssssss
```

- Latency history <event-name>

```
127.0.0.1:6379> latency history command
 1) 1) (integer) 1685853685
    2) (integer) 10
 2) 1) (integer) 1685853690
    2) (integer) 10
 3) 1) (integer) 1685853694
    2) (integer) 11
 4) 1) (integer) 1685853709
    2) (integer) 11
 5) 1) (integer) 1685853710
    2) (integer) 10
 6) 1) (integer) 1685853718
    2) (integer) 10
 7) 1) (integer) 1685853720
    2) (integer) 11
 8) 1) (integer) 1685853728
    2) (integer) 11
 9) 1) (integer) 1685853729
    2) (integer) 11
10) 1) (integer) 1685853730
    2) (integer) 11
11) 1) (integer) 1685853735
    2) (integer) 11
12) 1) (integer) 1685853737
    2) (integer) 10
13) 1) (integer) 1685853742
    2) (integer) 11
```

- Latency latest

```
127.0.0.1:6379> latency latest
1) 1) "fast-command"
   2) (integer) 1685853684
   3) (integer) 10
   4) (integer) 87
2) 1) "command"
   2) (integer) 1685853742
   3) (integer) 11
   4) (integer) 11
```

- Latecy Reset

```
127.0.0.1:6379> latency reset
(integer) 2
```

- Latency histogram

```
127.0.0.1:6379> latency histogram set
1) "set"
2) 1) "calls"
   2) (integer) 100001
   3) "histogram_usec"
   4)  1) (integer) 1
       2) (integer) 88443
       3) (integer) 2
       4) (integer) 95235
       5) (integer) 4
       6) (integer) 96312
       7) (integer) 8
       8) (integer) 96438
       9) (integer) 16
      10) (integer) 99316
      11) (integer) 33
      12) (integer) 99382
      13) (integer) 66
      14) (integer) 99611
      15) (integer) 132
      16) (integer) 99854
      17) (integer) 264
      18) (integer) 99963
      19) (integer) 528
      20) (integer) 99992
      21) (integer) 1056
      22) (integer) 99998
      23) (integer) 2113
      24) (integer) 100001
```
