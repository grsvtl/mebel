<?php
namespace modules\catalog\subGoods\lib;
class SubGoodsDecorator extends \core\modules\base\ModuleDecorator
{
	public $subGoods;

	function __construct($object)
	{
		parent::__construct($object);
	}

	public function getSubGoods()
	{
		if(empty($this->subGoods)) {
			$this->subGoods = new \modules\catalog\subGoods\lib\SubGoods();
			$this->subGoods->getSubGoodsByParentId($this->getParentObject()->id);
		}
		return $this->subGoods;
	}

	public function isSubGoodsExists()
	{
		return $this->getSubGoods()->count() != 0;
	}
}