## スローログ

以下の設定でスローログをコントロール出来ます

```
slowlog-log-slower-than 10000
slowlog-max-len 128
```

クライアントからは次のようにログ操作できます

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli
127.0.0.1:6379> slowlog get 10
1) 1) (integer) 0
   2) (integer) 1685837496
   3) (integer) 17443
   4) 1) "scan"
      2) "0"
      3) "MATCH"
      4) "*"
      5) "COUNT"
      6) "500"
   5) "127.0.0.1:58746"
   6) "redisinsight-browser-a6705473"
127.0.0.1:6379> slowlog len
(integer) 1
127.0.0.1:6379> slowlog reset
OK
127.0.0.1:6379> slowlog len
(integer) 0
```

## メモリー問題

メモリー使用量を確認出来るコマンド

```
127.0.0.1:6379> memory help
 1) MEMORY <subcommand> [<arg> [value] [opt] ...]. Subcommands are:
 2) DOCTOR
 3)     Return memory problems reports.
 4) MALLOC-STATS
 5)     Return internal statistics report from the memory allocator.
 6) PURGE
 7)     Attempt to purge dirty pages for reclamation by the allocator.
 8) STATS
 9)     Return information about the memory usage of the server.
10) USAGE <key> [SAMPLES <count>]
11)     Return memory in bytes used by <key> and its value. Nested values are
12)     sampled up to <count> times (default: 5, 0 means sample all).
13) HELP
14)     Prints this help.
```

- Memory doctor

以下の基準で診断

- 1.  メモリー量が 5MB 以上使用されている
- 2.  ピーク時が現在使用しているメモリー量の 1.5 倍以上か
- 3.  RSS が大きいことによりフラグメンテーションが 1.4 以上かつメモリー量が 10MB 以上か
- 4.  メモリーアロケーターで外部フラグメンテーションが 1.1 以上かつメモリー量が 10MB 以上か
- 5.  メモリーアロケーターで RSS が大きいことにより、フラグメンテーションが 1.1 以上かつメモリー量が 10MB 以上か
- 6.  エフェメラルスクリプトやモジュールなど、メモリーアロケーターではないプロセスによる外部フラグメンテーションが 1.1 以上かつメモリー量が 10MB か
- 7.  各クライアントがクライアント出力バッファーで平均 200KB 以上メモリーを消費しているか
- 8.  各レプリカがクライアント出力バッファーで平均 10MB 以上メモリーを消費しているか
- 9.  エフェメラルスクリプトが 1000 個以上キャッシュされているか

```
127.0.0.1:6379> memory doctor
Sam, I detected a few issues in this Redis instance memory implants:

 * High total RSS: This instance has a memory fragmentation and RSS overhead greater than 1.4 (this means that the Resident Set Size of the Redis process is much larger than the sum of the logical allocations Redis performed). This problem is usually due either to a large peak memory (check if there is a peak memory entry above in the report) or may result from a workload that causes the allocator to fragment memory a lot. If the problem is a large peak memory, then there is no issue. Otherwise, make sure you are using the Jemalloc allocator and not the default libc malloc. Note: The currently used allocator is "jemalloc-5.2.1".

I'm here to keep you safe, Sam. I want to help you.
```

- memory stats

```
127.0.0.1:6379> memory stats
 1) "peak.allocated"
 2) (integer) 8698232
 3) "total.allocated"
 4) (integer) 8592888
 5) "startup.allocated"
 6) (integer) 862080
 7) "replication.backlog"
 8) (integer) 0
 9) "clients.slaves"
10) (integer) 0
11) "clients.normal"
12) (integer) 1800
13) "cluster.links"
14) (integer) 0
15) "aof.buffer"
16) (integer) 0
17) "lua.caches"
18) (integer) 0
19) "functions.caches"
20) (integer) 728
21) "db.0"
22) 1) "overhead.hashtable.main"
    2) (integer) 1062384
    3) "overhead.hashtable.expires"
    4) (integer) 32
    5) "overhead.hashtable.slot-to-keys"
    6) (integer) 0
23) "overhead.total"
24) (integer) 1927024
25) "keys.count"
26) (integer) 20006
27) "keys.bytes-per-key"
28) (integer) 386
29) "dataset.bytes"
30) (integer) 6665864
31) "dataset.percentage"
32) "86.22467041015625"
33) "peak.percentage"
34) "98.788909912109375"
35) "allocator.allocated"
36) (integer) 8839784
37) "allocator.active"
38) (integer) 9183232
39) "allocator.resident"
40) (integer) 12140544
41) "allocator-fragmentation.ratio"
42) "1.0388525724411011"
43) "allocator-fragmentation.bytes"
44) (integer) 343448
45) "allocator-rss.ratio"
46) "1.3220338821411133"
47) "allocator-rss.bytes"
48) (integer) 2957312
49) "rss-overhead.ratio"
50) "1.8279352188110352"
51) "rss-overhead.bytes"
52) (integer) 10051584
53) "fragmentation"
54) "2.5888075828552246"
55) "fragmentation.bytes"
56) (integer) 13619792
```

- MEMORY malloc-stats

```
127.0.0.1:6379> memory malloc-stats
___ Begin jemalloc statistics ___
Version: "5.2.1-0-g0"
Build-time option settings
  config.cache_oblivious: true
  config.debug: false
  config.fill: true
  config.lazy_lock: false
  config.malloc_conf: ""
  config.opt_safety_checks: false
  config.prof: false
  config.prof_libgcc: false
  config.prof_libunwind: false
  config.stats: true
  config.utrace: false
  config.xmalloc: false
Run-time option settings
  opt.abort: false
  opt.abort_conf: false
  opt.confirm_conf: false
  opt.retain: true
  opt.dss: "secondary"
  opt.narenas: 16
  opt.percpu_arena: "disabled"
  opt.oversize_threshold: 8388608
  opt.metadata_thp: "disabled"
  opt.background_thread: false (background_thread: true)
  opt.dirty_decay_ms: 10000 (arenas.dirty_decay_ms: 10000)
  opt.muzzy_decay_ms: 0 (arenas.muzzy_decay_ms: 0)
  opt.lg_extent_max_active_fit: 6
  opt.junk: "false"
  opt.zero: false
  opt.tcache: true
  opt.lg_tcache_max: 15
  opt.thp: "default"
  opt.stats_print: false
  opt.stats_print_opts: ""
Arenas: 17
Quantum size: 8
Page size: 4096
Maximum thread-cached size class: 32768
Number of bin size classes: 39
Number of thread-cache bin size classes: 44
Number of large size classes: 196
Allocated: 8868456, active: 9216000, metadata: 2984512 (n_thp 0), resident: 12173312, mapped: 15507456, retained: 2318336
Background threads: 1, num_runs: 4, run_interval: 5065908750 ns
                           n_lock_ops (#/sec)       n_waiting (#/sec)      n_spin_acq (#/sec)  n_owner_switch (#/sec)   total_wait_ns   (#/sec)     max_wait_ns  max_n_thds
background_thread               17377      19               0       0               0       0               1       0               0         0               0           0
ctl                             34747      39               0       0               0       0               1       0               0         0               0           0
prof                                0       0               0       0               0       0               0       0               0         0               0           0
arenas[0]:
assigned threads: 1
uptime: 875419996208
dss allocation precedence: "secondary"
decaying:  time       npages       sweeps     madvises       purged
   dirty: 10000            0            1            3           24
   muzzy:     0            0            0            0            0
                            allocated         nmalloc (#/sec)         ndalloc (#/sec)       nrequests   (#/sec)
  nfill   (#/sec)          nflush   (#/sec)
small:                        7545448           96833     110            1291       1           97794       111
   1101         1              86         0
large:                        1323008              24       0               1       0              24         0
     24         0               1         0
total:                        8868456           96857     110            1292       1           97818       111
   1125         1              87         0

active:                       9216000
mapped:                      15507456
retained:                     2318336
base:                         2951736
internal:                       32776
metadata_thp:                       0
tcache_bytes:                   37872
resident:                    12173312
abandoned_vm:                       0
extent_avail:                       8
                           n_lock_ops (#/sec)       n_waiting (#/sec)      n_spin_acq (#/sec)  n_owner_switch (#/sec)   total_wait_ns   (#/sec)     max_wait_ns  max_n_thds
large                            8688       9               0       0               0       0               1       0               0         0               0           0
extent_avail                     9609      10               0       0               0       0               5       0               0         0               0           0
extents_dirty                    9655      11               0       0               0       0               5       0               0         0               0           0
extents_muzzy                    8688       9               0       0               0       0               1       0               0         0               0           0
extents_retained                10491      11               0       0               0       0               5       0               0         0               0           0
decay_dirty                      8702       9               0       0               0       0               9       0               0         0               0           0
decay_muzzy                      8704       9               0       0               0       0               9       0               0         0               0           0
base                            18301      20               0       0               0       0               3       0               0         0               0           0
tcache_list                      8689       9               0       0               0       0               1       0               0         0               0           0
bins:           size ind    allocated      nmalloc (#/sec)      ndalloc (#/sec)    nrequests   (#/sec)  nshards      curregs     curslabs  nonfull_slabs regs pgs   util       nfills (#/sec)     nflushes (#/sec)       nslabs     nreslabs (#/sec)      n_lock_ops (#/sec)       n_waiting (#/sec)      n_spin_acq (#/sec)  n_owner_switch (#/sec)   total_wait_ns   (#/sec)     max_wait_ns  max_n_thds
                   8   0         4752          631       0           37       0         1637         1        1
 594            2              0  512   1  0.580            9       0            5       0            2            0       0            8705       9               0       0               0       0               1       0               0         0               0           0
                  16   1       180448        11331      12           53       0        11797        13        1        11278           45              0  256   1  0.978          115       0            5       0           45            0       0            8853      10               0       0               0       0               1       0               0         0               0           0
                  24   2      1718400        71600      81            0       0        71691        81        1        71600          140              0  512   3  0.998          716       0            0       0          140            0       0            9544      10               0       0               0       0               1       0               0         0               0           0
                  32   3         4480          218       0           78       0          206         0        1
 140            2              0  128   1  0.546            4       0            5       0            2            0       0            8699       9               0       0               0       0               1       0               0         0               0           0
                  40   4       429800        10875      12          130       0        10667        12        1        10745           21              0  512   5  0.999          151       0            3       0           21            0       0            8863      10               0       0               0       0               1       0               0         0               0           0
                  48   5         3312          156       0           87       0           69         0        1
  69            1              0  256   3  0.269            3       0            5       0            1            0       0            8697       9               0       0               0       0               1       0               0         0               0           0
                  56   6         9408          225       0           57       0          159         0        1
 168            1              0  512   7  0.328            4       0            3       0            1            0       0            8696       9               0       0               0       0               1       0               0         0               0           0
                  64   7         1920           72       0           42       0           37         0        1
  30            1              0   64   1  0.468            2       0            3       0            1            0       0            8694       9               0       0               0       0               1       0               0         0               0           0
                  80   8          880          106       0           95       0           13         0        1
  11            1              0  256   5  0.042            2       0            4       0            1            0       0            8695       9               0       0               0       0               1       0               0         0               0           0
                  96   9          672          100       0           93       0           12         0        1
   7            1              0  128   3  0.054            1       0            4       0            1            0       0            8694       9               0       0               0       0               1       0               0         0               0           0
                 112  10          784          106       0           99       0            4         0        1
   7            1              0  256   7  0.027            2       0            4       0            1            0       0            8695       9               0       0               0       0               1       0               0         0               0           0
                 128  11        25600          224       0           24       0          830         0        1
 200            7              0   32   1  0.892            7       0            3       0            7            0       0            8705       9               0       0               0       0               1       0               0         0               0           0
                 160  12         1440          106       0           97       0            4         0        1
   9            1              0  128   5  0.070            2       0            4       0            1            0       0            8695       9               0       0               0       0               1       0               0         0               0           0
                 192  13            0           64       0           64       0            1         0        1
   0            0              0   64   3      1            1       0            4       0            1            0       0            8695       9               0       0               0       0               1       0               0         0               0           0
                 224  14         1568          106       0           99       0            2         0        1
   7            1              0  128   7  0.054            2       0            4       0            1            0       0            8695       9               0       0               0       0               1       0               0         0               0           0
                 256  15          256           16       0           15       0            4         0        1
   1            1              0   16   1  0.062            1       0            3       0            1            0       0            8693       9               0       0               0       0               1       0               0         0               0           0
                 320  16         5120           64       0           48       0           17         0        1
  16            1              0   64   5  0.250            1       0            3       0            1            0       0            8693       9               0       0               0       0               1       0               0         0               0           0
                 384  17          768           32       0           30       0            3         0        1
   2            1              0   32   3  0.062            1       0            3       0            1            0       0            8693       9               0       0               0       0               1       0               0         0               0           0
                 448  18         1792           68       0           64       0            2         0        1
   4            1              0   64   7  0.062            2       0            4       0            2            0       0            8697       9               0       0               0       0               1       0               0         0               0           0
                 512  19          512           10       0            9       0            4         0        1
   1            1              1    8   1  0.125            1       0            2       0            2            0       0            8694       9               0       0               0       0               1       0               0         0               0           0
                 640  20            0            0       0            0       0            0         0        1
   0            0              0   32   5      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
                     ---
                 768  21         4608           20       0           14       0            2         0        1
   6            1              0   16   3  0.375            2       0            2       0            1            0       0            8693       9               0       0               0       0               1       0               0         0               0           0
                 896  22            0            0       0            0       0            0         0        1
   0            0              0   32   7      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
                     ---
                1024  23         1024           11       0           10       0            3         0        1
   1            1              0    4   1  0.250            2       0            3       0            4            0       0            8700       9               0       0               0       0               1       0               0         0               0           0
                1280  24         6400           20       0           15       0            1         0        1
   5            1              0   16   5  0.312            2       0            2       0            1            0       0            8693       9               0       0               0       0               1       0               0         0               0           0
                1536  25        15360           10       0            0       0            0         0        1
  10            2              0    8   3  0.625            1       0            0       0            2            0       0            8691       9               0       0               0       0               1       0               0         0               0           0
                1792  26            0            0       0            0       0            0         0        1
   0            0              0   16   7      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
                     ---
                2048  27        12288           12       0            6       0            4         0        1
   6            3              0    2   1      1            2       0            2       0            6            0       0            8701       9               0       0               0       0               1       0               0         0               0           0
                2560  28            0            0       0            0       0            0         0        1
   0            0              0    8   5      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
                3072  29            0            0       0            0       0            0         0        1
   0            0              0    4   3      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
                3584  30            0            0       0            0       0            0         0        1
   0            0              0    8   7      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
                     ---
                4096  31         4096           10       0            9       0            1         0        1
   1            1              0    1   1      1            1       0            2       0           10            0       0            8710       9               0       0               0       0               1       0               0         0               0           0
                5120  32            0            0       0            0       0            0         0        1
   0            0              0    4   5      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
                     ---
                6144  33         6144           10       0            9       0            1         0        1
   1            1              1    2   3  0.500            1       0            2       0            5            0       0            8700       9               0       0               0       0               1       0               0         0               0           0
                7168  34            0            0       0            0       0            0         0        1
   0            0              0    4   7      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
                     ---
                8192  35      5103616          630       0            7       0          623         0        1
 623          623              0    1   2      1           63       0            2       0          630            0       0            9390      10               0       0               0       0               1       0               0         0               0           0
               10240  36            0            0       0            0       0            0         0        1
   0            0              0    2   5      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
               12288  37            0            0       0            0       0            0         0        1
   0            0              0    1   3      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
               14336  38            0            0       0            0       0            0         0        1
   0            0              0    2   7      1            0       0            0       0            0            0       0            8688       9               0       0               0       0               1       0               0         0               0           0
                     ---
large:          size ind    allocated      nmalloc (#/sec)      ndalloc (#/sec)    nrequests (#/sec)  curlextents
               16384  39        49152            4       0            1       0            4       0            3
               20480  40       184320            9       0            0       0            9       0            9
               24576  41       122880            5       0            0       0            5       0            5
                     ---
               32768  43        32768            1       0            0       0            1       0            1
                     ---
               81920  48        81920            1       0            0       0            1       0            1
                     ---
              131072  51       262144            2       0            0       0            2       0            2
                     ---
              262144  55       262144            1       0            0       0            1       0            1
              327680  56       327680            1       0            0       0            1       0            1
                     ---
extents:        size ind       ndirty        dirty       nmuzzy        muzzy    nretained     retained       ntotal        total
                4096   0            0            0            0            0            2         8192            2         8192
                8192   1            0            0            0            0            2        16384            2        16384
                     ---
             2621440  32            0            0            0            0            1      2293760            1      2293760
                     ---
--- End jemalloc statistics ---
```

- MEMORY purge  
  ※GC のようなもの

```
127.0.0.1:6379> memory purge
OK
```

- Memory Usage  
  キーやそれに関連する値の保存に必要なメモリーサイズ

```
127.0.0.1:6379> memory usage foo
(integer) 56
```
