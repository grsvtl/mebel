<?php
namespace modules\catalog\reviews\lib;
class ReviewObject extends \core\modules\base\ModuleObject
{
	protected $configClass = '\modules\catalog\reviews\lib\ReviewConfig';
	
	function __construct($objectId)
	{
		parent::__construct($objectId, new $this->configClass);
	}
}