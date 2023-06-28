# レプリケーション

- 完全同期
  - マスターからレプリカに rdb ファイルを送信
  - レプリカはデータクリア後に restore  
    ※TTL により失効したキーはレプリケーションしない
- 部分同期
  - マスターとレプリカの差分が判定できる場合は、部分同期が優先されます。
  * マスターとレプリカのレプリケーションバックログの差分のみ送信します。
  * マスターのバックログサイズはデフォルト 1MB であり、以下の設定で変更可能
  ```
  repl-backlog-size
  ```
  - レプリケーションが切断してから一定時間過ぎるとバックログの解放が行われる。デフォルトでは 1 時間であり、以下の設定で変更可能
  ```
  repl-backlog-ttl
  ```

* ディスクレスレプリケーション

  - ディスクが遅くネットワークが広帯域の環境向けにディスクレスレプリケーション機能が提供されている。  
    設定を変更する必要がある・
    ```
    repl-diskless-sync yes
    ```

* レプリケーション負荷の調整
  　遅延が発生するが、レプリケーションの帯域幅を減らす設定がある。

  ```
  repl-disable-tcp-nodelay no
  ```

* 非同期レプリケーション・・・デフォルト動作
* 同期レプリケーション・・・WAIT コマンドを使用する

* レプリケーションのリンク状態の死活監視  
  デフォルトで 10 秒間隔でマスターから ping を送信します。  
  以下の設定で間隔を変更可能

```
    repl-ping-replica-priod
```

- デフォルトでは 10 秒間 ping 受け取っていないと、切断状態とみなされる。  
  この秒は設定変更可能。

```
    min-replica-max-lag
```

## フェイルオーバー

Redis には自動でフェイルオーバーする機能はないので、新マスター上で手動でコマンドを実行する必要がある。

```
replica aof no one
```

それ以外のレプリカは以下のコマンドを実行する必要がある。

```
replicaof <new_maste_ip> <new_master_port>
```

ファイルオーバー中はクライアントからのアクセスを一時的に中断します。

```
client pause
```

- レプリケーション時ののエフェメラルスクリプト  
  設定によって、スクリプト全体をレプリケーションするか
  変更内容を 1 つのコマンドとしてレプリケーションするか選択できる

```
lua-replicate-commands yes
```

## 導入

マスター用の redis.conf 作成  
※内容は同フォルダ参照

```
vi redis-master.conf
```

レプリカ用の redis.conf 作成  
※内容は同フォルダ参照

```
vi redis-replica.conf
```

docker-compose.yaml の作成  
※内容は同フォルダ参照

```
vi docker-compose.yaml
```

docker 起動

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ sudo docker-compose up
[sudo] password for masami:
WARNING: The PWD variable is not set. Defaulting to a blank string.
Creating network "user_default" with the default driver
Pulling master (redis:latest)...
latest: Pulling from library/redis
f03b40093957: Pull complete
8db26c5e8435: Pull complete
37e84c7a626f: Pull complete
806c192e0375: Pull complete
08769906aa59: Pull complete
635073d8ccd5: Pull complete
Digest: sha256:f9724694a0b97288d2255ff2b69642dfba7f34c8e41aaf0a59d33d10d8a42687
Status: Downloaded newer image for redis:latest
Creating user_replica_1 ... done
Creating user_master_1  ... done
Attaching to user_master_1, user_replica_1
replica_1  | 1:C 05 Jun 2023 11:47:34.474 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
replica_1  | 1:C 05 Jun 2023 11:47:34.474 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
replica_1  | 1:C 05 Jun 2023 11:47:34.475 # Configuration loaded
replica_1  | 1:M 05 Jun 2023 11:47:34.476 * monotonic clock: POSIX clock_gettime
master_1   | 1:C 05 Jun 2023 11:47:34.465 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
replica_1  | 1:M 05 Jun 2023 11:47:34.479 * Running mode=standalone, port=6379.
master_1   | 1:C 05 Jun 2023 11:47:34.467 # Redis version=7.0.11, bits=64, commit=00000000, modified=0, pid=1, just started
master_1   | 1:C 05 Jun 2023 11:47:34.468 # Configuration loaded
master_1   | 1:M 05 Jun 2023 11:47:34.470 * monotonic clock: POSIX clock_gettime
master_1   | 1:M 05 Jun 2023 11:47:34.471 * Running mode=standalone, port=6379.
master_1   | 1:M 05 Jun 2023 11:47:34.472 # Server initialized
master_1   | 1:M 05 Jun 2023 11:47:34.472 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
master_1   | 1:M 05 Jun 2023 11:47:34.472 * Ready to accept connections
replica_1  | 1:M 05 Jun 2023 11:47:34.479 # Server initialized
replica_1  | 1:M 05 Jun 2023 11:47:34.479 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
replica_1  | 1:M 05 Jun 2023 11:47:34.480 * Ready to accept connections
```

- Redis Sentinel  
   Redis Sentinel は Redis に高可用性を提供する分散システム。
  特定の種類の障害に対して人手を介さずに抵抗する Redis 配備を作成することができます。
