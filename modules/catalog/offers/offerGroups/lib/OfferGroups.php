<?php
namespace modules\catalog\offers\offerGroups\lib;
class OfferGroups extends \core\modules\base\ModuleObjects
{
	protected $configClass = '\modules\catalog\offers\offerGroups\lib\OfferGroupConfig';

	function __construct()
	{
		parent::__construct(new $this->configClass);
	}

	public function getOfferGroupByOfferId($offerId)
	{
		$filters = new \core\FilterGenerator();
		$filters->setSubquery('AND `offerId`="?d"', $offerId)
			->setLimit(1);
		return $this->setFilters($filters)->current();
	}

	public function getOfferGroupByGoodId($goodId)
	{
		$offerGroupGoods = new \modules\catalog\offers\offerGroups\offerGroupGoods\lib\OfferGroupGoods();
		$offerGroupGood = $offerGroupGoods->getOfferGroupGoodByGoodId($goodId);
		if(!$offerGroupGood)
			return new \core\Noop ();
		return new \modules\catalog\offers\offerGroups\lib\OfferGroup ($offerGroupGood->offerGroupId);
	}
}