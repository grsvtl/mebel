<?php
namespace modules\catalog\priority\lib;

class CatalogPriorities extends \core\modules\base\ModuleDecorator
{
    function __construct()
	{
		$object = new CatalogPrioritiesObject();
		parent::__construct($object);
	}
}
