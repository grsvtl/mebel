<?php
namespace modules\catalog\offers\lib;
class Offer extends \modules\catalog\CatalogGood implements \interfaces\IObjectToFrontend, \interfaces\IGoodForShopcart, \interfaces\IGoodForOrder
{
	use \core\traits\objects\SiteMapPriority;
	use \core\traits\RequestHandler;

	private $setedGoodId;

	function __construct($objectId)
	{
		$object = new OfferObject($objectId);
		$object = new \core\modules\categories\CategoryDecorator($object);
		$object = new \core\modules\statuses\StatusDecorator($object);
		$object = new \core\modules\images\ImagesDecorator($object);
		$object = new \core\modules\filesUploaded\FilesDecorator($object);
//		$object = new \core\modules\categories\AdditionalCategoriesDecorator($object);
		parent::__construct($object);
		$this->setSettedGoodId();
	}

//	public function remove () {
//		$offerGroups = new \modules\catalog\offers\offerGroups\lib\OfferGroups;
//		$offerGroup = $offerGroups->getOfferGroupByOfferId($this->id);
//		if( $offerGroup )
//			if ($offerGroup->remove())
//				return ($this->delete()) ? (int)$this->id : false ;
//		return $this->delete();
//	}

//	public function edit ($data, $fields = array()) {
//		return ($this->additionalCategories->edit($data->additionalCategories)) ? $this->getParentObject()->edit($data, $fields) : false;
//	}

	public function getJQFormatedTime()
	{
		$time = explode('-', $this->time);
		return $time[2].', '.($time[1] - 1).', '.($time[0] +1 );
	}

//	protected function getPrice()
//	{
//		$discount = $this->discountPercent  ?  $this->getGoodPrice() * $this->discountPercent / 100  :  $this->discount;
//		return  $this->getGoodPrice() - $discount;
//	}
//
//	protected function getGoodPrice()
//	{
//		return $this->getGood()->getPriceByMinQuantity();
//	}

	protected function getGood()
	{
		return \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->getSettedGoodId());
	}

	private function getSettedGoodId()
	{
		return $this->settedGoodId;
	}

	public function setSettedGoodId($goodId = false)
	{
		$this->settedGoodId = $goodId ? $goodId : $this->goodId;
	}

	public function getName()
	{
		return $this->name;
	}

	public function getFirstPrimaryImage()
	{
		if($this->getImagesByCategoryAndStatus(array(2), array(1))->current())
			return $this->getImagesByCategoryAndStatus(array(2), array(1))->current();
		else
			return $this->getGood()->getFirstPrimaryImage();
	}

	public function getAdminURL()
	{
		return $this->getGood()->getAdminUrl();
	}

	/* Start: IGoodForShopcart Methods */
	public function getMinQuantity()
	{
		return 1;
	}

	public function getPriceByQuantity($quantity)
	{
//		return $this->getPrice();
	}

	public function getPriceByMinQuantity()
	{
//		return $this->getPrice();
	}

	public function getPathToShopcartGoodTemplate()
	{
		return $this->getConfig()->shopcartTemplate;
	}

	public function getClass()
	{
		return $this->getConfig()->objectClass;
	}
	/* End: IGoodForShopcart Methods */

	/* Start: IGoodForOrder Methods */
	public function getBasePriceByQuantity($quantity){}
	public function getBasePriceByMinQuantity(){}
	public function getBasePriceByQuantityForPartner($quantity, $partnerId){}
	public function getPathToOrderGoodTemplate(){}
	public function getPathToAdminOrderGoodTemplate(){}
	public function getTotalAvailability(){}
	/* End: IGoodForOrder Methods */

	/* Start: URL Methods */
	public function getPath()
	{
		return $this->getGood()->getPath();
	}

	public function getMetaTitle()
	{
		return $this->getDomainInfoByDomainAlias($this->getCurrentDomainAlias())->getMetaTitle();
	}

	public function getMetaDescription()
	{
		return $this->getDomainInfoByDomainAlias($this->getCurrentDomainAlias())->getMetaDescription();
	}

	public function getMetaKeywords()
	{
		return $this->getDomainInfoByDomainAlias($this->getCurrentDomainAlias())->getMetaKeywords();
	}

	public function getHeaderText()
	{
		return $this->getDomainInfoByDomainAlias($this->getCurrentDomainAlias())->getHeaderText();
	}
	/*   End: URL Methods */

	/* Start: Sitemap Methods */
	public function getLastUpdateTime()
	{
		return $this->lastUpdateTime;
	}

	public function getSitemapPriority()
	{
		return $this->sitemapPriority=='0.0' ? $this->getSitemapPriorityByPath($this->getPath()) : $this->sitemapPriority;
	}

	public function getChangeFreq()
	{
		return empty($this->changeFreq) ? 'weekly' : $this->changeFreq;
	}
	/*   End: Sitemap Methods */

	public function isBlocked()
	{
		$config = $this->getConfig();
		return $this->getStatus()->id == $config::BLOCKED_STATUS_ID;
	}

	public function isHasGroup()
	{
		$offerGroups = new \modules\catalog\offers\offerGroups\lib\OfferGroups();
		$offerGroupGoods = new \modules\catalog\offers\offerGroups\offerGroupGoods\lib\OfferGroupGoods;
		return is_object($offerGroups->getOfferGroupByOfferId($this->id))  &&  $offerGroupGoods->getGoodsByOffer($this)->count();
	}

	public function getType(){return $this->type;}
	public function getTime(){return $this->time;}
	public function getQuantity(){return $this->quantity;}

	public function getTypeName()
	{
		return array_search($this->getType(), $this->getObject($this->getConfig()->objectsClass)->getTypes());
	}

	public function getTypeRemain()
	{
		if($this->getType() == 'time')
			return 'до '.$this->getTime();
		if($this->getType() == 'quantity')
			return (string)$this->getQuantity().' шт.';
		return false;
	}

	public function isValid()
	{
		if($this->getType() == 'time')
			return strtotime(date("d-m-Y")) <= strtotime($this->time) ;
		if($this->getType() == 'quantity')
			return (int)$this->getQuantity() > 0;
		return false;
	}

	public function getDiscountSum()
    {
        $price = $this->getGood()->getNativePriceByQuantity($this->getGood()->getMinQuantity());
        return  round($this->discountPercent  ?  $price * $this->discountPercent / 100  :  $this->discount, 0);
    }
}
