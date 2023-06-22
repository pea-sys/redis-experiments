## リアルタイムチャット

- requirements.txt の定義

```
fastapi
starlette
uvicorn[standard]
aioredis
uvloop
```

- インストール

```
pip3 install -r requirements.txt --user
```

- クライアントプログラム作成  
  ※ファイル内容は同フォルダ参照

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/StreamChat$ vi stream-chat.py
```

- 静的ファイルを配置するフォルダの作成  
  ※ ファイル内容は同フォルダ参照

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/StreamChat$ mkdir static
```

- クライアントプログラム実行

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/StreamChat$ python3 stream-chat.py
```

- ブラウザにアクセスするために IP アドレスを確認

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user/StreamChat/static$ hostname -I
192.168.19.197
```

- 以下のアドレスにアクセス

http://192.168.19.197:8080/static/index.html
