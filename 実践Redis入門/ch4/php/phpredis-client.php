<?php
$redis = new Redis();
$redis ->connect("127.0.0.1", 6379);

$redis->set('foo','bar');
$value = $redis->get('foo');
echo $value . "\n";
?>