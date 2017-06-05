<?php
namespace modules\catalog\offers\lib;
class Offers extends \core\modules\base\ModuleDecorator
{
	use	\core\traits\RequestHandler;

	function __construct()
	{
		$object = new OffersObject();
		$object = new \core\modules\images\ImagesDecorator($object);
		$object = new \core\modules\filesUploaded\FilesDecorator($object);
		$object = new \core\modules\statuses\StatusesDecorator($object);
		$object = new \core\modules\categories\CategoriesDecorator($object);
		parent::__construct($object);
	}

	protected function getTypes()
	{
		return array(
			'по времени'=>'time',
			'по количеству'=>'quantity',
		);
	}

	protected function getValidOfferByGoodId($goodId)
	{
		$config = $this->getConfig();
		$offer = $this->getOfferFromGroupsByGoodId($goodId, $config::ACTIVE_STATUS_ID);
		if($offer)
			$offer->setSettedGoodId($goodId);
		else{
			$config = $this->getConfig();
			$res = $this->resetFilters()
					->setSubquery('AND `goodId` = ?d', $goodId)
					->setSubquery('AND `statusId` = ?d', $config::ACTIVE_STATUS_ID)
					->setOrderBy('`priority` ASC')
					->setLimit('1');
			$offer = $res->current();
		}

		if(isset($offer)  &&  $offer){
			if($offer->type == 'time')
				return strtotime($offer->time) >= strtotime(date('d-m-Y')) ? $offer : false;
			if($offer->type == 'quantity')
				return $offer->quantity > 0 ? $offer : false;
		}

		return false;
	}

	public function getOfferFromGroupsByGoodId($goodId, $status = null)
	{
		$offer = false;
		$offerGroups = new \modules\catalog\offers\offerGroups\lib\OfferGroups();
		$offerGroup = $offerGroups->getOfferGroupByGoodId($goodId);
		$offerId = $offerGroup->offerId;
		$config = $this->getConfig();
		$res = $this->resetFilters();
		if(isset($status)){
			if($status=='all')
				$res = $this->loadWithRemovedObjects();
			elseif(is_numeric($status))
				$res = $this->setSubquery('AND `statusId` = ?d', $status);
		}
		$res = $this->setSubquery('AND `id` = ?d', $offerId)
			->setOrderBy('`priority` ASC')
			->setLimit('1');
		return $res->current();
	}

	protected function getValidOffers($limit = null)
	{
		$limit = isset($limit) ? $limit : 1000000;
		$config = $this->getConfig();
		$res = $this->setSubquery('AND `statusId` = ?d', $config::ACTIVE_STATUS_ID)
			->setSubquery('AND `domain` = \'?s\'', $this->getCurrentDomainAlias())
			->setSubquery('AND `id` IN ('
								. 'SELECT `id` FROM `tbl_catalog_offers` WHERE '
								. '	CASE WHEN (`type` = "time") THEN (time > UNIX_TIMESTAMP(CURDATE() )) '
								. '	ELSE'
									. '	(CASE WHEN (`type` = "quantity") THEN (quantity > 1) ELSE 1=9 END)'
								. '	END'
							. ')')
				->setSubquery('AND id != 999999999999')
			->setOrderBy('`priority` ASC')
			->setLimit($limit);
		return $res;
	}
}