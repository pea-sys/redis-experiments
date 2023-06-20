#!lua flags=no-writes,allow-stale
local result = redis.call('get','x')
return result