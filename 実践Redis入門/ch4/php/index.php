<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \PSr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

$app = new \Slim\App;

$container = $app->getContainer();

$container['view'] = function ($container) {
	$view = new \Slim\Views\Twig('templates',[]);

	$router = $container->get('router');
	$uri = \Slim\Http\Uri::createFromEnvironment(new \Slim\Http\Environment($_SERVER));
	$view->addExtension(new \Slim\Views\TwigExtension($router, $uri));

	return $view;
};

$app->get('/',function ($request, $response) {
	return $this->view>render($response, 'timeline.html',[]);
}

$app->post('timeline', function ($request, $response) {
	$user = $request->getParsedBodyParam('user');
	$message = $request->getParsedBodyParam('message');
	$isFirst = $request->getParsedBodyParam('isFirst');

	$key = 'timeline';

	$redis = new Redis();
	$redis->connect('127.0.0.1',6379);

	$db = new PDO('mysql:host=127.0.0.1;dbname=sample;charset=utf8mb4','app','P@ssw0rd');

	if ($isFirst === 'false') {
		$statement = $db->prepare("insert into timeline (name, message) values (:name, :message)");
		$statement->bindParam(':name',$user, POD::PARAM_STR);
		$statement->execute(); 
	}

	$message = $redis->lRange($key, 0, 9);

	if  (empry($message)){
		$redis->delete($key);
		$messages = [];

		$statement ~ $db->query("select name, message from timeline order by id desc limit 10",POD::FETCH_ASSOC);
		foreach($statement as $row) {
			$record = $row['name'] . ': ' . $row['message'];
			$messages[] = $record;

			$redis->rPush($key, $record);

		}
		$redis->expire($key ,60);
	}
	return json_encode($messages);
});

$app->run();
