require 'redis'

script = <<EOF
    redis.call('HMSET', KEYS[1], ARGV[1],ARGV[2], ARGV[3], ARGV[4])
    redis.call('EXPIRE', KEYS[1], ARGV[5])
EOF

redis = Redis.new

hashed_script = redis.script(:load, script)
redis.evalsha(hashed_script, keys: ['user:1'], argv:['age', 30 , 'email', 'taro@example.com', 60*60*24])