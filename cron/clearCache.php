<?php
namespace core;
try {
    include('/var/www/vnm/data/www/mebel-mebel.ru/includes/config.php');
    if( \core\cache\Cacher::getInstance()->removeAll() ){
        $to = 'sashagrinceac@yahoo.com, ' . (new \core\Settings())->getAllGlobalSettings()['admin_email'];
        $string = 'автоматическая очистка кэша mebel-meble.ru - ' . date('m/d/Y h:i:s a', time());
        mail($to, $string, $string);
    }
} catch (\Exception $e) {
	$shell = new debug\DeveloperShell(new debug\ErrorHandler());
	$shell->exceptionHandler($e);
}
