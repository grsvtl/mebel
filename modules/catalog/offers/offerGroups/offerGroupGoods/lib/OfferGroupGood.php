<?php
namespace modules\catalog\offers\offerGroups\offerGroupGoods\lib;
class OfferGroupGood extends \core\modules\base\ModuleObject
{
	protected $configClass = '\modules\catalog\offers\offerGroups\offerGroupGoods\lib\OfferGroupGoodConfig';

	function __construct($objectId)
	{
		parent::__construct($objectId, new $this->configClass);
	}

	public function getGood()
	{
		return \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->goodId);
	}
}