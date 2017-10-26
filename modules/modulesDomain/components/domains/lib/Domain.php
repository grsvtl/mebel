<?php
namespace modules\modulesDomain\components\domains\lib;
class Domain extends \core\modules\base\ModuleDecorator
{
	function __construct($objectId)
	{
		$object = new DomainObject($objectId);
		parent::__construct($object);
	}

	public function remove () {
		return ($this->delete()) ? (int)$this->id : false ;
	}
}