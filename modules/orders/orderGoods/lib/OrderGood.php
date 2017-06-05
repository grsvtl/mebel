<?php
namespace modules\orders\orderGoods\lib;
class OrderGood extends \core\modules\base\ModuleDecorator
{
	use \core\traits\RequestHandler;

	function __construct($objectId)
	{
		$object = new OrderGoodObject($objectId);
		parent::__construct($object);
	}

	public function remove () {
		return ($this->delete()) ? (int)$this->id : false ;
	}

	public function getGood()
	{
		return \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->goodId);
	}
	
	public function getPrice()
	{
		return $this->price * $this->getQuantity();
	}
	
	public function getQuantity()
	{
		return $this->quantity;
	}
	
	public function getBasePrice()
	{
		return round($this->basePrice * $this->getQuantity());
	}
	
	public function getIncome()
	{
		return round($this->getPrice() - $this->getBasePrice());
	}
}
