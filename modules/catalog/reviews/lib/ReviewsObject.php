<?php
namespace modules\catalog\reviews\lib;
class ReviewsObject extends \core\modules\base\ModuleObjects
{
	protected $configClass     = '\modules\catalog\reviews\lib\ReviewConfig';
	protected $objectClassName = '\modules\catalog\reviews\lib\Reviews';
	
	function __construct()
	{
		parent::__construct(new $this->configClass);
	}
}
