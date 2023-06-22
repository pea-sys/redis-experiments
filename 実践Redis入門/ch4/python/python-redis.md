## Python で Resid を使用

- Python と aioredis をインストール

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo apt install python3-pip -y
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ pip3 install --user aioredis
```

- クライアントプログラムの作成  
  ※同フォルダの aioredis-client.py 参照

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ vi aioredis-client.py
```

- 実行

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ python3 aioredis-client.py
b'bar'
```
