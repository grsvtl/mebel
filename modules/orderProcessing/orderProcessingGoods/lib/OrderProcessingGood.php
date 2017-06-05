<?php
namespace modules\orderProcessing\orderProcessingGoods\lib;
class OrderProcessingGood extends \core\modules\base\ModuleDecorator
{
	function __construct($objectId)
	{
		$object = new OrderProcessingGoodObject($objectId);
		$object = new \core\modules\statuses\StatusDecorator($object);
		parent::__construct($object);
	}
	
	public function getGood()
	{
		return $this->goodId
			? $this->getObject($this->class, $this->goodId)
			: $this->getNoop();
	}

	public function remove () 
	{
		return $this->delete();
	}
	
	public function getPrice()
	{
		return $this->price;
	}
	
	public function getBasePrice()
	{
		return $this->getGood()->getBasePriceByMinQuantity();
	}
	
	public function getQuantity()
	{
		return $this->quantity;
	}
	
	public function getTotalPrice()
	{
		return $this->getPrice() * $this->getQuantity();
	}
}