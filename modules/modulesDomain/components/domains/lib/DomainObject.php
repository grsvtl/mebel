<?php
namespace modules\modulesDomain\components\domains\lib;
class DomainObject extends \core\modules\base\ModuleObject
{
	protected $configClass = '\modules\modulesDomain\components\domains\lib\DomainConfig';

	function __construct($objectId)
	{
		parent::__construct($objectId, new $this->configClass);
	}
}