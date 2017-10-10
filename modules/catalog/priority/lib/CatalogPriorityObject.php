<?php
namespace modules\catalog\priority\lib;

class CatalogPriorityObject extends \core\modules\base\ModuleObject
{
	protected $configClass = '\modules\catalog\priority\lib\CatalogPriorityConfig';

	function __construct($objectId)
	{
		parent::__construct($objectId, new $this->configClass);
	}
}