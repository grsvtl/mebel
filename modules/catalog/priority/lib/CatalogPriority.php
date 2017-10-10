<?php
namespace modules\catalog\priority\lib;

class CatalogPriority extends \core\modules\base\ModuleDecorator
{
	use \core\traits\RequestHandler;

	function __construct($objectId)
	{
		$object = new CatalogPriorityObject($objectId);
		parent::__construct($object);
	}
}