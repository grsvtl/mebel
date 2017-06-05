<?php
namespace modules\catalog\subGoods\lib;
class SubGood extends \core\modules\base\ModuleDecorator
{
	function __construct($objectId)
	{
		$object = new SubGoodObject($objectId);
		parent::__construct($object);
	}

	public function getGood()
	{
		return \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->subGoodId);
	}

	public function getCost()
	{
		return $this->getGood()->getPriceByQuantity($this->subGoodQuantity) * $this->subGoodQuantity;
	}

	public function getBaseCost()
	{
		return  $this->getGood()->getBasePriceByQuantity($this->subGoodQuantity) * $this->subGoodQuantity;
	}

	public function getBaseCostByPartner($partnerId)
	{
		return  $this->getGood()->getBasePriceByQuantityForPartner($this->subGoodQuantity, $partnerId) * $this->subGoodQuantity;
	}

	public function getIncome()
	{
		return $this->getCost() - $this->getBaseCost();
	}

	public function getQuantity()
    {
        return $this->subGoodQuantity;
    }
}