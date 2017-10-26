<?php
namespace modules\modulesDomain\components\domains\lib;
class Domains extends \core\modules\base\ModuleDecorator
{
	function __construct()
	{
		$object = new DomainsObject();
		parent::__construct($object);
	}
}