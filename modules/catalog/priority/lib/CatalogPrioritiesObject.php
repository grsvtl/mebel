<?php
namespace modules\catalog\priority\lib;

class CatalogPrioritiesObject extends \core\modules\base\ModuleObjects
{
	protected $configClass = '\modules\catalog\priority\lib\CatalogPriorityConfig';

	function __construct()
	{
		parent::__construct(new $this->configClass);
	}
}
