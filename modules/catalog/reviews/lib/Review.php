<?php
namespace modules\catalog\reviews\lib;
class Review extends \core\modules\base\ModuleDecorator
{
	function __construct($objectId)
	{
		$object = new ReviewObject($objectId);
		$object = new \core\modules\statuses\StatusDecorator($object);
		parent::__construct($object);
	}
}