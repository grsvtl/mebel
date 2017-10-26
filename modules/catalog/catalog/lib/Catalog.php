<?php
namespace modules\catalog\catalog\lib;
use core\traits\RequestHandler;

class Catalog extends \core\modules\base\ModuleDecorator implements \Countable
{
	use \modules\catalog\traits\filterCategoryAlias;
	use RequestHandler;

	function __construct()
	{
		$object = new CatalogObject();
		$object = new \core\modules\images\ImagesDecorator($object);
		$object = new \core\modules\statuses\StatusesDecorator($object);
//		$object = new \core\modules\categories\CategoriesDecorator($object);
		$object = new \modules\catalog\categories\CatalogCategoryDecorator($object);
		$object = new \modules\fabricators\lib\FabricatorsDecorator($object);
		parent::__construct($object);
	}

	/* Start: Countable Methods */
	public function count()
	{
		return $this->getParentObject()->count();
	}
	/* End: Countable Methods */

	public function getMinPrice()
	{
		return $this->getMinField('price', 'tbl_catalog_catalog_prices');
	}

	public function getMaxPrice()
	{
		return $this->getMaxField('price', 'tbl_catalog_catalog_prices');
	}

	public function getFabricatorsByMainCategoriesId($mainCategoriesId = null)
	{
		if(!isset($mainCategoriesId)  ||  empty($mainCategoriesId))
			return $this->getObject('\modules\fabricators\lib\Fabricators')
					->getActiveFabricators();

		$fabricatorsIdArray = array();
		$this->setSubquery('AND `categoryId` IN ( SELECT `id` FROM `tbl_catalog_catalog_categories` WHERE `parentId` IN (?s))', $mainCategoriesId);
		foreach($this as $object)
			if(!in_array($object->fabricatorId, $fabricatorsIdArray))
				$fabricatorsIdArray[] = $object->fabricatorId;

		return $this->getObject('\modules\fabricators\lib\Fabricators')
				->setSubquery('AND `id` IN (?s)', implode(',', $fabricatorsIdArray));

	}

    /**
     * @param null   $domainAlias
     * @param int    $categoryId
     * @param string $type
     *
     * @return mixed
     */
	public function orderByDomainAlias($domainAlias = null, $categoryId = 0, $type = 'ASC')
    {
        if ( $domainAlias === null ) {
            $domainAlias = $this->getCurrentDomainAlias();
        }

        if ( (string)$categoryId == '' ) {
            $categoryId = '0';
        }

        return $this->setOrderBy(
            $this->getOrderByDomainAliasString($domainAlias, $categoryId, $type)
        );
    }

    public function getOrderByDomainAliasString($domainAlias, $categoryId, $type)
    {
        $category = $this->getCategories()->getObjectById($categoryId);
        $childrenIdString = $category ? $category->getChildrenIdString() : false;
        return ' (
            SELECT priority 
            FROM `'.$this->mainTable().'_priorities` 
            WHERE goodId    = mt.id 
            AND domainAlias = "'.$domainAlias.'"          
            AND (
                categoryId  = '.$categoryId.'
                OR 
                `id` IN (SELECT `ownerId` FROM `'.$this->mainTable().'_additional_categories` WHERE `objectId` = '.$categoryId.')
                OR 
                `categoryId` IN ('.($childrenIdString ? $childrenIdString : '-1').')
            )
        ) '.$type;
    }

    public function setCatalogSubquery($subquery, $data = null)
    {
        $this->getParentObject()->setSubquery($subquery, $data);
        return $this;
    }
}