<?php
namespace core;

try {

	define('TYPE','front');

	session_start();
	include('includes/config.php');
	$configurator = Configurator::getInstance();

	
	// Start debug
	if ($configurator->developerShell->XHProf)
		xhprof_enable(XHPROF_FLAGS_CPU + XHPROF_FLAGS_MEMORY);

	utils\Protector::getInstance()->xss($_REQUEST)->xss($_POST)->xss($_GET);
	$config = $configurator->getArrayByKey('debug');
	debug\Debug::getInstance()->setConfig($config);
	debug\Debug::getInstance(__FILE__, __LINE__,__FUNCTION__,__CLASS__,__METHOD__)->start();

	$urlDecodeConfig = $configurator->getArrayByKey('url');
	url\UrlDecoder::getInstance()
		->setConfig($urlDecodeConfig)
		->requestRebuild();

	$urlRedirectorConfig = $configurator->getArrayByKey('redirect');
	url\UrlRedirector::getInstance()
		->setConfig($urlRedirectorConfig)
		->loadCsvData()
		->redirectCurrentPage();

	$controllerFactoryConfig = $configurator->getArrayByKey('controllers');
	$controller = \controllers\base\ControllerFactory::getInstance()
		->setConfig($controllerFactoryConfig)
		->$_REQUEST['controller'];
	$controller->$_REQUEST['action']();

	\core\debug\Debug::getInstance(__FILE__, __LINE__,__FUNCTION__,__CLASS__,__METHOD__)->setResult();

	// Start debug
	if ($configurator->developerShell->XHProf){
		$xhprof_data = xhprof_disable();
		include_once DIR.'vendor/xhprof/xhprof_lib/utils/xhprof_lib.php';
		include_once DIR.'vendor/xhprof/xhprof_lib/utils/xhprof_runs.php';
		$xhprof_runs = new \XHProfRuns_Default(DIR.'tmp');
		$run_id = $xhprof_runs->save_run($xhprof_data, str_replace('/', '-', $_SERVER['REQUEST_URI']));
	}
} catch (\Exception $e) {
	$shell = new debug\DeveloperShell(new debug\ErrorHandler());
	$shell->exceptionHandler($e);
}
