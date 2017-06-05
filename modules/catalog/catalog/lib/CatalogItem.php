<?php
namespace modules\catalog\catalog\lib;
use modules\catalog\prices\lib\PricesObject;

class CatalogItem extends \modules\catalog\CatalogGood implements \interfaces\IObjectToFrontend, \interfaces\IGoodForShopcart
{
	use \core\traits\RequestHandler,
		\core\traits\objects\SiteMapPriority;

	function __construct($objectId)
	{
		$object = new CatalogItemObject($objectId);
		$object = new \modules\catalog\categories\CatalogCategoryDecorator($object);
		$object = new \core\modules\statuses\StatusDecorator($object);
		$object = new \modules\catalog\prices\lib\PricesDecorator($object);
		$object = new \modules\catalog\availability\lib\AvailabilityListDecorator($object);
		$object = new \modules\catalog\domainsInfo\lib\DomainsInfoDecorator($object);
		$object = new \core\modules\images\ImagesDecorator($object);
		$object = new \core\modules\filesUploaded\FilesDecorator($object);
		$object = new \core\modules\categories\AdditionalCategoriesDecorator($object);
		$object = new \modules\catalog\offers\lib\OfferDecorator($object);
		$object = new \modules\parameters\components\parametersValues\lib\ParametersValuesRelationDecorator($object);
		$object = new \modules\properties\components\propertiesValues\lib\RelationsDecorator($object);
		$object = new \modules\catalog\subGoods\lib\SubGoodsDecorator($object);
		$object = new \modules\fabricators\lib\FabricatorDecorator($object);
		parent::__construct($object);
	}

	public function edit ($data, $fields = array())
	{
		if ( $this->getParameters()->edit($data->parametersValues) )
			if ( $this->additionalCategories->edit($data->additionalCategories) )
				return $this->getParentObject()->edit($data, $fields);

		return false;
	}

	/* Start: Meta Methods */
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
	/*   End: Meta Methods */

	/* Start: URL Methods */
	public function getPath($domainAlias = false)
	{
		$currentDomainAlias = $domainAlias ? $domainAlias : $this->getCurrentDomainAlias();
        if(in_array($currentDomainAlias, array('dana-mebel.net', 'meri-mebel.ru', 'fabrika-ugmebel.ru')))
			return $this->getDanaSeriaPath().$this->getDomainInfoByDomainAlias($currentDomainAlias)->alias.'/';
		return $this->getCategory()->getPath().$this->getDomainInfoByDomainAlias($currentDomainAlias)->alias.'/';
	}
	public function getGoodDomain()
	{
		return $this->getObject('\modules\catalog\domainsInfo\lib\DomainsInfo', $this)->getDomainInfoByObjectId($this->id)->domainAlias;
	}
	/*   End: URL Methods */

	public function getDanaSeriaPath()
	{
		$category = $this->getCategory();
		$seria = $this->getSeriaObject();
		return ( $category->isMain() ? $category->getPath() : $category->getParent()->getPath() ).$seria->alias.'/';
	}

	public function getAdminURL()
	{
		return '/admin/catalog/catalogItem/'.$this->id;
	}

	public function getPathByDomainAlias($domainAlias)
	{
//		return $this->getCategory()->getPath().$this->getDomainInfoByDomainAlias($domainAlias)->alias.'/';
		if($this->isProductionDomain())
			$domain = $domainAlias;
		else
			$domain = $_SERVER['HTTP_HOST'];
		return 'http://'.$domain.$this->getPath($domainAlias);
	}

	public function isValidPath($path)
	{
		return $this->getPath() == rtrim($path,'/').'/';
	}

	/* Start: IGoodForShopcart Methods */
	public function getMinQuantity()
	{
		return $this->isPricesExists()
			? $this->getPrices()->getMinQuantity()
			:1;
	}

	private function isPricesExists()
	{
		return (bool)$this->getPrices()->count();
	}

	public function getPriceByQuantity($quantity)
	{
		$price = $this->getNativePriceByQuantity($quantity);
		if($this->getOffer())
			return round($price - $this->getOffer()->getDiscountSum(), 0);
		return $price;
	}

	public function getPriceByMinQuantity()
	{
		return $this->getPriceByQuantity($this->getMinQuantity());
	}

	public function getPathToShopcartGoodTemplate()
	{
		 return $this->getConfig()->shopcartTemplate;
	}
	/* End: IGoodForShopcart Methods */

	/* Start: IGoodForOrder Methods */
	public function getBasePriceByQuantity($quantity)
	{
		return $this->isPricesExists()
			? $this->getPrices()->getPriceByQuantity($quantity)->getBasePrices()->getMinBasePrice()->price
			: $this->getSubGoods()->getBaseCost()*$quantity;
	}

	public function getBasePriceByMinQuantity()
	{
		return $this->isPricesExists()
			? $this->getPrices()->getPriceByQuantity($this->getMinQuantity())->getBasePrices()->getMinBasePrice()->price
			: $this->getSubGoods()->getBaseCost();
	}

	public function getBasePriceByQuantityForPartner($quantity, $partnerId)
	{
		return $this->isPricesExists()
			? $this->getPrices()->getPriceByQuantity($this->getMinQuantity())->getBasePrices()->getMinBasePrice()->price
			: $this->getSubGoods()->getBaseCostByPartner($partnerId);
	}

	public function getPathToOrderGoodTemplate()
	{
		 return $this->getConfig()->orderTemplate;
	}

	public function getPathToAdminOrderGoodTemplate()
	{
		return $this->getConfig()->orderGoodAdminTemplate;
	}

	public function getTotalAvailability()
	{
		return $this->getAvailabilityList()->getTotalQuantity();
	}
	/* End: IGoodForOrder Methods */

	public function getInfo()
	{
		return $this->getDomainInfoByDomainAlias($this->getCurrentDomainAlias());
	}

	public function getAvailabilityList()
	{
		return $this->getParentObject()->getAvailabilityList();
	}

	/* Start: Sitemap Methods */
	public function getLastUpdateTime()
	{
		return $this->lastUpdateTime;
	}

	public function getSitemapPriority()
	{
		return $this->sitemapPriority=='default' ? $this->getSitemapPriorityByPath($this->getPath()) : $this->sitemapPriority;
	}

	public function getChangeFreq()
	{
		return empty($this->changeFreq) ? 'weekly' : $this->changeFreq;
	}
	/*   End: Sitemap Methods */

	public function remove () {
		return ($this->delete()) ? (int)$this->id : false ;
	}

	public function isZeroPrice()
	{
		return $this->getPrices()->getMinPrice()->getPrice() == 0;
	}

	public function isNotZeroPrice()
	{
		return ! $this->isZeroPrice();
	}

	public function getAdminPath()
	{
		return '/admin/catalog/catalogItem/'.$this->id.'/';
	}

	public function getSeriaObject()
	{
		$this->seriaId;
		return isset($this->seriaId) && !empty($this->seriaId)
				?
					$this->getObject('\modules\parameters\components\parametersValues\lib\ParameterValue', $this->seriaId)
				:
					false;
	}

	public function isBlocked()
	{
		$config = $this->getConfig();
		return $this->getStatus()->id == $config::BLOCKED_STATUS_ID;
	}

	public function getNativePriceByQuantity($quantity)
	{
		$price = $this->isPricesExists()
				? $this->getPrices()->getPriceByQuantity($quantity)->getPrice()
				: $this->getSubGoods()->getCost();

		return $price;
	}

	public function getNativePriceByMinQuantity()
	{
		return $this->getNativePriceByQuantity($this->getMinQuantity());
	}

	public function isNew(){return $this->statusId == $this->getConfig()->getNewStatusId();}

	public function isSuperPrice(){return $this->statusId == $this->getConfig()->getSuperPriceStatusId();}

	public function isTopSell(){return $this->statusId == $this->getConfig()->getTopSellStatusId();}

    public function isSale(){return $this->statusId == $this->getConfig()->getSaleStatusId();}

    public function isAkcia(){return $this->statusId == $this->getConfig()->getAkciaStatusId();}

	public function getSmallDescription(){return $this->getInfo()->smallDescription;}

	public function isDana()
	{
		if(!empty($this->fabricatorId))
			if($this->fabricatorId == (new \modules\fabricators\lib\FabricatorConfig())->getDanaFabricatorId())
				return true;
		return false;
	}

    public function isMeri()
    {
        if(!empty($this->fabricatorId))
            if($this->fabricatorId == (new \modules\fabricators\lib\FabricatorConfig())->getMeriFabricatorId())
                return true;
        return false;
    }

    public function getShowPrice()
    {
        if($this->getOffer())
            return $this->getNativePriceByQuantity(1) - $this->getOffer()->getDiscountSum();
        if($this->isSubGoodsExists()){
            return $this->getSubgoods()->getCost();
        }
        return $this->getPriceByMinQuantity();
    }

    public function getShowOldPrice()
    {
        if($this->getOffer())
            return $this->getNativePriceByQuantity(1);
        if($this->isSubGoodsExists()){
            $price = 0;
            foreach ($this->getSubGoods() as $subGood)
                $price += $subGood->getGood()->getShowOldPrice() * $subGood->subGoodQuantity;
            return $price;
        }
        return (new PricesObject($this))->getPriceByMinQuantity()->getOldPrice();
    }
}