## RESP2

redis サーバーとクライアントは redis 向けに設計された RESP というプロトコルで通信する。

set foo bar を RESP 形式で送る。

- netcat でキー読み書き。

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ echo -e "*3\r\n\$3\r\nset\r\n\$3\r\nfoo\r\n\$3\r\nbar\r\n" | nc localhost 6379
+OK

masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ echo -e "*2\r\n\$3\r\nget\r\n\$3\r\nfoo\r\n" | nc localhost 6379
$3
bar
```

先頭「\*」は配列を意味し、そのあとに続く数字は配列の要素数(パラメータ数)、要素ごとに CRLF。
\*3\r\n\$3\r\nset\r\n\$3\r\nhoge\r\n\$3\r\nfuga\r\n

- telnet でキー書き込み。

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ telnet localhost 6379
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
*3
$3
set
$3
foo
$3
bar
+OK

masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ telnet localhost 6379
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
*2
$3
get
$3
foo
$3
bar
```

## RESP3

redis-server との通信開始時は RESP2 だけど、「HELLO 3」コマンドで RESP3 に切り替えられる。RESP2 に改良を加え、暗黙変換に依存しない変更や改行コードを CRLF から LF に変えて、通信量を減らしています。

## RESP 形式以外

redis サーバーは RESP 形式に則っていない通信フォーマットにも対応している

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ telnet localhost 6379
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
get foo
$3
bar
```

先頭が\*の場合、RESP プロトコルで通信。それ以外の場合は名前は分からないが別のプロトコロルが使用される。  
ただし、RESP の方が効率が良いため、通常 RESP を利用するクライアントがほとんど。
