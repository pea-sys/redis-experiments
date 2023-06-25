- info コマンドでサーバー情報取得

```
127.0.0.1:6379> info
# Server
redis_version:7.0.11
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:450be55a432c4eba
redis_mode:standalone
os:Linux 5.15.90.1-microsoft-standard-WSL2 x86_64
arch_bits:64
monotonic_clock:POSIX clock_gettime
multiplexing_api:epoll
atomicvar_api:c11-builtin
gcc_version:11.3.0
process_id:694
process_supervised:no
run_id:0ac0070dda2e2a4eb14e72fce389eb21f2ed54ef
tcp_port:6379
server_time_usec:1685833200650764
uptime_in_seconds:9
uptime_in_days:0
hz:10
configured_hz:10
lru_clock:8111600
executable:/mnt/c/Users/user/redis-server
config_file:
io_threads_active:0

# Clients
connected_clients:1
cluster_connections:0
maxclients:10000
client_recent_max_input_buffer:20480
client_recent_max_output_buffer:0
blocked_clients:0
tracking_clients:0
clients_in_timeout_table:0

# Memory
used_memory:6809872
used_memory_human:6.49M
used_memory_rss:21086208
used_memory_rss_human:20.11M
used_memory_peak:6986944
used_memory_peak_human:6.66M
used_memory_peak_perc:97.47%
used_memory_overhead:1926984
used_memory_startup:862080
used_memory_dataset:4882888
used_memory_dataset_perc:82.10%
allocator_allocated:7038088
allocator_active:7364608
allocator_resident:10379264
total_system_memory:4071378944
total_system_memory_human:3.79G
used_memory_lua:31744
used_memory_vm_eval:31744
used_memory_lua_human:31.00K
used_memory_scripts_eval:0
number_of_cached_scripts:0
number_of_functions:1
number_of_libraries:1
used_memory_vm_functions:35840
used_memory_vm_total:67584
used_memory_vm_total_human:66.00K
used_memory_functions:728
used_memory_scripts:728
used_memory_scripts_human:728B
maxmemory:0
maxmemory_human:0B
maxmemory_policy:noeviction
allocator_frag_ratio:1.05
allocator_frag_bytes:326520
allocator_rss_ratio:1.41
allocator_rss_bytes:3014656
rss_overhead_ratio:2.03
rss_overhead_bytes:10706944
mem_fragmentation_ratio:3.11
mem_fragmentation_bytes:14299224
mem_not_counted_for_evict:0
mem_replication_backlog:0
mem_total_replication_buffers:0
mem_clients_slaves:0
mem_clients_normal:1800
mem_cluster_links:0
mem_aof_buffer:0
mem_allocator:jemalloc-5.2.1
active_defrag_running:0
lazyfree_pending_objects:0
lazyfreed_objects:0

# Persistence
loading:0
async_loading:0
current_cow_peak:0
current_cow_size:0
current_cow_size_age:0
current_fork_perc:0.00
current_save_keys_processed:0
current_save_keys_total:0
rdb_changes_since_last_save:0
rdb_bgsave_in_progress:0
rdb_last_save_time:1685833191
rdb_last_bgsave_status:ok
rdb_last_bgsave_time_sec:-1
rdb_current_bgsave_time_sec:-1
rdb_saves:0
rdb_last_cow_size:0
rdb_last_load_keys_expired:0
rdb_last_load_keys_loaded:20005
aof_enabled:0
aof_rewrite_in_progress:0
aof_rewrite_scheduled:0
aof_last_rewrite_time_sec:-1
aof_current_rewrite_time_sec:-1
aof_last_bgrewrite_status:ok
aof_rewrites:0
aof_rewrites_consecutive_failures:0
aof_last_write_status:ok
aof_last_cow_size:0
module_fork_in_progress:0
module_fork_last_cow_size:0

# Stats
total_connections_received:1
total_commands_processed:1
instantaneous_ops_per_sec:0
total_net_input_bytes:41
total_net_output_bytes:171624
total_net_repl_input_bytes:0
total_net_repl_output_bytes:0
instantaneous_input_kbps:0.00
instantaneous_output_kbps:0.00
instantaneous_input_repl_kbps:0.00
instantaneous_output_repl_kbps:0.00
rejected_connections:0
sync_full:0
sync_partial_ok:0
sync_partial_err:0
expired_keys:0
expired_stale_perc:0.00
expired_time_cap_reached_count:0
expire_cycle_cpu_milliseconds:0
evicted_keys:0
evicted_clients:0
total_eviction_exceeded_time:0
current_eviction_exceeded_time:0
keyspace_hits:0
keyspace_misses:0
pubsub_channels:0
pubsub_patterns:0
pubsubshard_channels:0
latest_fork_usec:0
total_forks:0
migrate_cached_sockets:0
slave_expires_tracked_keys:0
active_defrag_hits:0
active_defrag_misses:0
active_defrag_key_hits:0
active_defrag_key_misses:0
total_active_defrag_time:0
current_active_defrag_time:0
tracking_total_keys:0
tracking_total_items:0
tracking_total_prefixes:0
unexpected_error_replies:0
total_error_replies:0
dump_payload_sanitizations:0
total_reads_processed:2
total_writes_processed:3
io_threaded_reads_processed:0
io_threaded_writes_processed:0
reply_buffer_shrinks:1
reply_buffer_expands:0

# Replication
role:master
connected_slaves:0
master_failover_state:no-failover
master_replid:e215b1ecdd51cca67add77c412b659607551ccad
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:0
second_repl_offset:-1
repl_backlog_active:0
repl_backlog_size:1048576
repl_backlog_first_byte_offset:0
repl_backlog_histlen:0

# CPU
used_cpu_sys:0.125056
used_cpu_user:0.079581
used_cpu_sys_children:0.000000
used_cpu_user_children:0.000000
used_cpu_sys_main_thread:0.124852
used_cpu_user_main_thread:0.079451

# Modules

# Errorstats

# Cluster
cluster_enabled:0

# Keyspace
db0:keys=20005,expires=0,avg_ttl=0
```

### Server セクション

```
127.0.0.1:6379> info server
# Server
redis_version:7.0.11 # Redisバージョン確認
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:450be55a432c4eba
redis_mode:standalone # Redisのモード
os:Linux 5.15.90.1-microsoft-standard-WSL2 x86_64
arch_bits:64　#RedisサーバーのOS
monotonic_clock:POSIX clock_gettime
multiplexing_api:epoll
atomicvar_api:c11-builtin
gcc_version:11.3.0
process_id:694 #RedisサーバーのプロセスID
process_supervised:no
run_id:0ac0070dda2e2a4eb14e72fce389eb21f2ed54ef
tcp_port:6379
server_time_usec:1685834201124721 #サーバー起動時間
uptime_in_seconds:1010
uptime_in_days:0
hz:10
configured_hz:10
lru_clock:8112601
executable:/mnt/c/Users/user/redis-server # Redisサーバーのパス
config_file: # Redisサーバーが参照している設定ファイルのパス
io_threads_active:0
```

### Clients セクション

```
127.0.0.1:6379> info clients
# Clients
connected_clients:1 #クライアント接続数
cluster_connections:0
maxclients:10000
client_recent_max_input_buffer:20480 # 最近のクライアントからの接続の中で最も長いクライアント入力バッファ
client_recent_max_output_buffer:0 # 最近のクライアントからの接続の中で最も長いクライアント出力バッファ
blocked_clients:0 # ブロッキングされているクライアント数
tracking_clients:0
clients_in_timeout_table:0 #タイムアウトテーブル中のクライアント数
```

### Memory

```
127.0.0.1:6379> info memory
# Memory
used_memory:6832936 # 割り当てメモリーバイト数
used_memory_human:6.52M
used_memory_rss:21053440
used_memory_rss_human:20.08M
used_memory_peak:6986944 # Redisによって消費されたメモリーのピーク
used_memory_peak_human:6.66M
used_memory_peak_perc:97.80%
used_memory_overhead:1926984
used_memory_startup:862080 # Redis起動時に消費されたメモリー
used_memory_dataset:4905952 #データセットによって使用されるメモリーのバイト数
used_memory_dataset_perc:82.16%
allocator_allocated:7172648 #対象のプロセスによって割り当てられた、全メモリー割り当てを考慮したメモリー量のバイト数
allocator_active:7544832
allocator_resident:10477568
total_system_memory:4071378944 # Redisが稼働しているホストが持つメモリー量の合計
total_system_memory_human:3.79G
used_memory_lua:31744
used_memory_vm_eval:31744
used_memory_lua_human:31.00K
used_memory_scripts_eval:0
number_of_cached_scripts:0
number_of_functions:1 #Redisファンクションの関数の数
number_of_libraries:1 #Redisファンクションのライブラリの数
used_memory_vm_functions:35840
used_memory_vm_total:67584
used_memory_vm_total_human:66.00K
used_memory_functions:728
used_memory_scripts:728
used_memory_scripts_human:728B #Redisファンクションですべてのエンジンによって消費される全関数のメモリー量のバイト数
maxmemory:0 #設定ファイル中で設定したmaxmemoryディレクティブの値
maxmemory_human:0B
maxmemory_policy:noeviction
allocator_frag_ratio:1.05
allocator_frag_bytes:372184
allocator_rss_ratio:1.39
allocator_rss_bytes:2932736
rss_overhead_ratio:2.01
rss_overhead_bytes:10575872
mem_fragmentation_ratio:3.09 #used_memoryに対するused_memory_rssの割合。1.5以上だとフラグメントが激しい。1.0以下だとスワップが発生している可能性あり。
mem_fragmentation_bytes:14241176
mem_not_counted_for_evict:0
mem_replication_backlog:0 #レプリケーションバックログにより消費されたメモリー量
mem_total_replication_buffers:0
mem_clients_slaves:0
mem_clients_normal:1800
mem_cluster_links:0
mem_aof_buffer:0
mem_allocator:jemalloc-5.2.1
active_defrag_running:0
lazyfree_pending_objects:0 #非同期による削除待ちのオブジェクト数
lazyfreed_objects:0 #非同期による削除されたオブジェクトの数
```

### Persistence

```
127.0.0.1:6379> info persistence
# Persistence
loading:0 #rdbまたはaofファイルの読み込み中か
async_loading:0
current_cow_peak:0
current_cow_size:0
current_cow_size_age:0
current_fork_perc:0.00
current_save_keys_processed:0
current_save_keys_total:0
rdb_changes_since_last_save:0
rdb_bgsave_in_progress:0 #bgsaveコマンド実行中か
rdb_last_save_time:1685833191 #最後のスナップショットの取得成功時間
rdb_last_bgsave_status:ok #最後のスナップショットの実行結果
rdb_last_bgsave_time_sec:-1
rdb_current_bgsave_time_sec:-1
rdb_saves:0
rdb_last_cow_size:0
rdb_last_load_keys_expired:0
rdb_last_load_keys_loaded:20005
aof_enabled:0 #aofが有効化
aof_rewrite_in_progress:0 #aof書き換えステータス
aof_rewrite_scheduled:0
aof_last_rewrite_time_sec:-1
aof_current_rewrite_time_sec:-1
aof_last_bgrewrite_status:ok
aof_rewrites:0
aof_rewrites_consecutive_failures:0 #aofファイルの書き換え失敗累計回数
aof_last_write_status:ok
aof_last_cow_size:0
module_fork_in_progress:0 #モジュールのfork処理のステータス
module_fork_last_cow_size:0
```

### Stats

```
127.0.0.1:6379> info stats
# Stats
total_connections_received:3 #合計接続数
total_commands_processed:161 #処理されたコマンド数
instantaneous_ops_per_sec:0 #秒あたりに処理されたコマンド数
total_net_input_bytes:4949　#ネットワークから読み取られた合計バイト数
total_net_output_bytes:585703 #ネットワークに書き込まれた合計バイト数
total_net_repl_input_bytes:0
total_net_repl_output_bytes:0
instantaneous_input_kbps:0.00
instantaneous_output_kbps:0.00
instantaneous_input_repl_kbps:0.00
instantaneous_output_repl_kbps:0.00
rejected_connections:0 #maxclientsの値で制限された接続数
sync_full:0 #レプリカと完全同期が行われた数
sync_partial_ok:0
sync_partial_err:0 #部分同期のリクエストが拒否された下図
expired_keys:0 #キーの失効イベントの合計数
expired_stale_perc:0.00
expired_time_cap_reached_count:0
expire_cycle_cpu_milliseconds:229
evicted_keys:0
evicted_clients:0
total_eviction_exceeded_time:0
current_eviction_exceeded_time:0
keyspace_hits:44 #キャッシュからの呼び出し成功回数
keyspace_misses:0 #キャッシュからの呼び出し失敗回数
pubsub_channels:0
pubsub_patterns:0
pubsubshard_channels:0
latest_fork_usec:0
total_forks:0
migrate_cached_sockets:0
slave_expires_tracked_keys:0
active_defrag_hits:0
active_defrag_misses:0
active_defrag_key_hits:0
active_defrag_key_misses:0
total_active_defrag_time:0
current_active_defrag_time:0
tracking_total_keys:0
tracking_total_items:0
tracking_total_prefixes:0
unexpected_error_replies:0
total_error_replies:0 #コマンドの実行失敗数
dump_payload_sanitizations:0
total_reads_processed:103
total_writes_processed:103
io_threaded_reads_processed:0
io_threaded_writes_processed:0
reply_buffer_shrinks:73
reply_buffer_expands:72
```

### Replication

※レプリカ側はより多くの情報が表示される

```
127.0.0.1:6379> info replication
# Replication
role:master # マスターかレプリカか
connected_slaves:0 #接続中のレプリカ数
master_failover_state:no-failover
master_replid:e215b1ecdd51cca67add77c412b659607551ccad
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:0
second_repl_offset:-1
repl_backlog_active:0
repl_backlog_size:1048576
repl_backlog_first_byte_offset:0
repl_backlog_histlen:0
```

### CPU

※サードパーティー製ツールで別途監視するケースが多く、
あまり使われることはない

```
127.0.0.1:6379> info cpu
# CPU
used_cpu_sys:10.073955
used_cpu_user:10.611087
used_cpu_sys_children:0.000000
used_cpu_user_children:0.000000
used_cpu_sys_main_thread:10.072865
used_cpu_user_main_thread:10.609939
```

### Module

モジュールをロードしている場合は、モジュール情報を表示

```
127.0.0.1:6379> info module
```

### Commandstats

```
127.0.0.1:6379> info commandstats
# Commandstats
cmdstat_command|docs:calls=1,usec=1044,usec_per_call=1044.00,rejected_calls=0,failed_calls=0
cmdstat_ttl:calls=22,usec=176,usec_per_call=8.00,rejected_calls=0,failed_calls=0
cmdstat_module|list:calls=1,usec=43,usec_per_call=43.00,rejected_calls=0,failed_calls=0
cmdstat_info:calls=98,usec=22574,usec_per_call=230.35,rejected_calls=0,failed_calls=0
cmdstat_type:calls=22,usec=62,usec_per_call=2.82,rejected_calls=0,failed_calls=0
cmdstat_client|setname:calls=2,usec=170,usec_per_call=85.00,rejected_calls=0,failed_calls=0
cmdstat_dbsize:calls=1,usec=144,usec_per_call=144.00,rejected_calls=0,failed_calls=0
cmdstat_memory|usage:calls=22,usec=1850,usec_per_call=84.09,rejected_calls=0,failed_calls=0
cmdstat_scan:calls=1,usec=17443,usec_per_call=17443.00,rejected_calls=0,failed_calls=0
cmdstat_config|get:calls=2,usec=435,usec_per_call=217.50,rejected_calls=0,failed_calls=0
```

### LatencyStats

```
# Latencystats
latency_percentiles_usec_command|docs:p50=1044.479,p99=1044.479,p99.9=1044.479
latency_percentiles_usec_ttl:p50=0.001,p99=167.935,p99.9=167.935
latency_percentiles_usec_module|list:p50=43.007,p99=43.007,p99.9=43.007
latency_percentiles_usec_info:p50=102.399,p99=5341.183,p99.9=6389.759
latency_percentiles_usec_type:p50=0.001,p99=50.175,p99.9=50.175
latency_percentiles_usec_client|setname:p50=3.007,p99=167.935,p99.9=167.935
latency_percentiles_usec_dbsize:p50=144.383,p99=144.383,p99.9=144.383
latency_percentiles_usec_memory|usage:p50=2.007,p99=1359.871,p99.9=1359.871
latency_percentiles_usec_scan:p50=17563.647,p99=17563.647,p99.9=17563.647
latency_percentiles_usec_config|get:p50=9.023,p99=428.031,p99.9=428.031
```

### ErrorStats

```
127.0.0.1:6379> info errorstats
# Errorstats
```

### Cluster

```
127.0.0.1:6379> info cluster
# Cluster
cluster_enabled:0
```

### KeySpace

```
127.0.0.1:6379> info keyspace
# Keyspace
db0:keys=20005,expires=0,avg_ttl=0
```
