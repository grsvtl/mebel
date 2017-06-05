<?php
namespace modules\catalog\subGoods\lib;
class SubGoods extends \core\modules\base\ModuleDecorator
{
	private $goodId;

	function __construct()
	{
		$object = new SubGoodsObject();
		parent::__construct($object);
	}

	public function getSubGoodsByParentId($goodId)
	{
		$this->setGoodId($goodId)->setSubquery('AND `goodId` = ?d', $this->goodId);
		return $this;
	}

	private function setGoodId($goodId)
	{
		$this->goodId = (int)$goodId;
		return $this;
	}

	public function getQuantity()
	{
		$return = 0;
		foreach ($this as $subGood)
			$return += $subGood->subGoodQuantity;
		return $return;
	}

	public function getCost()
	{
		$return = 0;
		foreach ($this as $subGood)
			$return += $subGood->getCost();
		return $return;
	}

	public function getBaseCost()
	{
		$return = 0;
		foreach ($this as $subGood)
			$return += $subGood->getBaseCost();
		return $return;
	}

	public function getBaseCostByPartner($partnerId)
	{
		$return = 0;
		foreach ($this as $subGood)
			$return += $subGood->getBaseCostByPartner($partnerId);
		return $return;
	}

	public function getIncome()
	{
		$return = 0;
		foreach ($this as $subGood)
			$return += $subGood->getIncome();
		return $return;
	}
}