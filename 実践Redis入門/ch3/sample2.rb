require 'redis'

script = <<EOF
    local counts = {}

    for i, key in ipairs(KEYS) do
        counts[i] = redis.call('SCARD', key)
    end

    return counts
EOF

redis = Redis.new
hashed_script = redis.script(:load, script)
result = redis.evalsha(hashed_script, keys: ['user:1:votes', 'user:2:votes','user:3:votes'])

puts result