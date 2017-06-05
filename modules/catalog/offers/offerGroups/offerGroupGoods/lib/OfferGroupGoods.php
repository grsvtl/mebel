<?php
namespace modules\catalog\offers\offerGroups\offerGroupGoods\lib;
class OfferGroupGoods extends \core\modules\base\ModuleObjects
{
	protected $configClass = '\modules\catalog\offers\offerGroups\offerGroupGoods\lib\OfferGroupGoodConfig';

	function __construct(){
		parent::__construct(new $this->configClass);
	}

	public function add($data, $fields = null)
	{
		return parent::add($data, $fields);
	}

	private function getOfferGroupGoodByOfferGroupGoodIdAndGoodId($offerGroupGoodId, $goodId)
	{
		$filters = new \core\FilterGenerator();
		$filters->setSubquery('AND `offerGroupId`="?d"', $offerGroupGoodId)
			->setSubquery('AND `goodId`="?d"', $goodId)
			->setLimit(1);
		return $this->setFilters($filters)->current();
	}

	public function isOfferGroupGoodExist($goodId)
	{
		return is_object($this->getOfferGroupGoodByGoodId($goodId));
	}

	public function getGoodsByOffer(\modules\catalog\offers\lib\Offer $offer)
	{
		$offerGroups = new \modules\catalog\offers\offerGroups\lib\OfferGroups();
		$offerGroup = $offerGroups->getOfferGroupByOfferId($offer->id);
		if(!$offerGroup)
			return new \core\Noop();
		$filters = new \core\FilterGenerator();
		$filters->setSubquery('AND `offerGroupId`="?d"', $offerGroup->id);
		return $this->resetFilters()
				->setFilters($filters);
	}

	public function getOfferGroupGoodByGoodId($goodId)
	{
		$filters = new \core\FilterGenerator();
		$filters->setSubquery('AND `goodId`="?d"', $goodId)
			->setLimit(1);
		return $this->setFilters($filters)->current();
	}
}