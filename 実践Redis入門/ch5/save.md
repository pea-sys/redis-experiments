```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-cli
127.0.0.1:6379> set foo bar
OK
127.0.0.1:6379> save
OK
127.0.0.1:6379> exit
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ ls
127.0.0.1:6379> exit
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ hexdump -C dump.rdb
00000000  52 45 44 49 53 30 30 31  30 fa 09 72 65 64 69 73  |REDIS0010..redis|
00000010  2d 76 65 72 06 37 2e 30  2e 31 31 fa 0a 72 65 64  |-ver.7.0.11..red|
00000020  69 73 2d 62 69 74 73 c0  40 fa 05 63 74 69 6d 65  |is-bits.@..ctime|
00000030  c2 c6 d0 79 64 fa 08 75  73 65 64 2d 6d 65 6d c2  |...yd..used-mem.|
00000040  a0 22 12 00 fa 08 61 6f  66 2d 62 61 73 65 c0 00  |."....aof-base..|
00000050  f5 c3 40 d6 41 45 1f 23  21 6c 75 61 20 6e 61 6d  |..@.AE.#!lua nam|
00000060  65 3d 6d 79 6c 69 62 0d  0a 0d 0a 6c 6f 63 61 6c  |e=mylib....local|
00000070  20 66 75 6e 63 74 69 14  6f 6e 20 73 75 6d 28 6b  | functi.on sum(k|
00000080  65 79 73 2c 20 61 72 67  73 29 0d 0a 20 20 00 80  |eys, args)..  ..|
00000090  23 00 76 20 27 02 3d 20  30 80 12 04 66 6f 72 20  |#.v '.= 0...for |
000000a0  69 20 0e 00 31 80 28 05  5b 31 5d 20 64 6f 80 1a  |i ..1.(.[1] do..|
000000b0  40 00 80 2b 40 05 02 2b  20 69 80 16 02 65 6e 64  |@..+@..+ i...end|
000000c0  40 6f 40 1d 05 72 65 74  75 72 6e 40 1e 01 0d 0a  |@o@..return@....|
000000d0  a0 16 0e 72 65 64 69 73  2e 72 65 67 69 73 74 65  |...redis.registe|
000000e0  72 5f c0 8f 00 7b 80 30  e0 0b 00 c0 22 00 5f 40  |r_...{.0...."._@|
000000f0  cf 20 89 00 27 20 c7 08  63 75 6c 61 74 6f 72 27  |. ..' ..culator'|
00000100  2c e0 11 36 20 25 04 6c  62 61 63 6b 20 31 20 eb  |,..6 %.lback 1 .|
00000110  e0 12 28 04 66 6c 61 67  73 20 25 0f 7b 20 27 6e  |..(.flags %.{ 'n|
00000120  6f 2d 77 72 69 74 65 73  27 20 7d 7d fe 00 fb 01  |o-writes' }}....|
00000130  00 00 03 66 6f 6f 03 62  61 72 ff eb 18 82 82 67  |...foo.bar.....g|
00000140  e4 b6 80                                          |...|
00000143

masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ redis-check-rdb dump.rdb
[offset 0] Checking RDB file dump.rdb
[offset 27] AUX FIELD redis-ver = '7.0.11'
[offset 41] AUX FIELD redis-bits = '64'
[offset 53] AUX FIELD ctime = '1685704902'
[offset 68] AUX FIELD used-mem = '1188512'
[offset 80] AUX FIELD aof-base = '0'
[offset 302] Selecting DB ID 0
[offset 323] Checksum OK
[offset 323] \o/ RDB looks OK! \o/
[info] 1 keys read
[info] 0 expires
[info] 0 already expired
```
