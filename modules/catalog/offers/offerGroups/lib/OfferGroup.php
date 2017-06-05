<?php
namespace modules\catalog\offers\offerGroups\lib;
class OfferGroup extends \core\modules\base\ModuleObject
{
	protected $configClass = '\modules\catalog\offers\offerGroups\lib\OfferGroupConfig';

	function __construct($objectId)
	{
		parent::__construct($objectId, new $this->configClass);
	}

	public function addGood($goodId)
	{
		$catalog = new \modules\catalog\catalog\lib\Catalog();
		$offerGroupGoods = new \modules\catalog\offers\offerGroups\offerGroupGoods\lib\OfferGroupGoods();
		if( !$catalog->objectExists($goodId) || $offerGroupGoods->isOfferGroupGoodExist($goodId))
			return false;

		$offerGroupGoods = new \modules\catalog\offers\offerGroups\offerGroupGoods\lib\OfferGroupGoods;
		return $offerGroupGoods->add( array('offerGroupId'=>$this->id, 'goodId'=>$goodId) );
	}
}
