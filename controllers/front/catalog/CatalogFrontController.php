<?php
namespace controllers\front\catalog;
use core\modules\categories\Categories;
use modules\catalog\categories\CatalogCategories;
use modules\catalog\categories\CatalogCategoryConfig;

class CatalogFrontController extends \controllers\base\Controller
{
	use	\core\traits\controllers\Meta,
		\core\traits\controllers\Templates,
		\core\traits\composition\RequestLevels_RequestHandler,
		\core\traits\UriHandler,
		\core\traits\Pager,
		\core\traits\controllers\Authorization,
		\core\traits\controllers\Breadcrumbs;

	const ACTIVE_CATEGORY_STATUS = 1;

	protected $catalog;

	public function __construct()
	{
		parent::__construct();
		$this->_config = new \modules\catalog\catalog\lib\CatalogItemConfig();
		$this->objectClass = $this->_config->getObjectClass();
		$this->objectsClass = $this->_config->getObjectsClass();
		$this->objectClassName = $this->_config->getObjectClassName();
		$this->objectsClassName = $this->_config->getObjectsClassName();
	}

	public function __call($name, $arguments)
	{
		if (empty($name))
			return $this->defaultAction();
		elseif ($this->setAction($name)->isPermissibleAction())
			return $this->callAction($arguments);
		else
			return $this->pageDetect();
	}

	protected function defaultAction()
	{
		$this->index();
	}

	protected function isDownloadFileRequested()
	{
		return isset($this->getGET()['downloadFile']);
	}

	protected function downloadFile($good)
	{
		$extension = pathinfo($this->getGET()['downloadFile'], PATHINFO_EXTENSION);
		$fileAlias = str_replace('.'.$extension, '', $this->getGET()['downloadFile']);
		$file = $good->getFabricator()->getFiles()->getObjectByAlias($fileAlias);
		if($file && is_object($file) && get_class($file)=='core\modules\filesUploaded\FileUploaded' && $file->getExtension()==$extension)
			return $file->download();
		else
			$this->redirect404();
	}

	protected function getGoodByAlias($alias)
	{
		return \modules\catalog\CatalogFactory::getInstance()->getGoodByAlias($alias, $this->getCurrentDomainAlias());
	}

	protected function checkObjectPath($object)
	{
		return rtrim($object->getPath(), '/') == rtrim(str_replace('?'.$this->getSERVER()['REDIRECT_QUERY_STRING'], '', $this->getSERVER()['REQUEST_URI']), '/');
	}

	protected function getCatalogObject()
	{
		$this->catalog = new \modules\catalog\catalog\lib\Catalog();
		return $this->catalog;
	}

	protected function getExludedStatusesArray()
	{
		return $exludedStatuses = array(
			\modules\catalog\catalog\lib\CatalogItemConfig::BLOCKED_STATUS_ID,
			\modules\catalog\catalog\lib\CatalogItemConfig::REMOVED_STATUS_ID,
		);
	}

	protected function sendRequestToArticlesController()
	{
		$action = $this->getREQUEST()['action'];
		$this->getController('Article')->$action();
	}

	public function getObjectsByFabricatorAndSeria($fabricatorId, $seria)
	{
		$objects = $this->getItemsByFabricatorId($fabricatorId);
		$this->selectObjectsBySeria($objects, array($seria));
		return $objects;
	}

	protected function getItemsByFabricatorId($fabricatorId, $limit = null)
	{
		$objects = $this->getActiveObjects();
		$objects->setSubquery('AND `fabricatorId` = (?d)', (int)$fabricatorId)
				->setOrderBy('`priority` ASC, `date` ASC, `id` ASC');
		if(isset($limit))
			$objects->setLimit($limit);
		return $objects;
	}

	protected function getActiveObjects($limit = null)
	{
		$objects = $this->getCatalogObject();
		$objects->resetFilters();
		$objects->setSubquery('AND `statusId` NOT IN (?s)', implode(',', $this->getExludedStatusesArray()));
        if(isset($limit))
            $objects->setLimit($limit);
		return $objects;
	}

	protected function selectObjectsBySeria($objects, $seria)
	{
		if (!empty($seria)){
			$idString = '';

			foreach($objects as $object)
				if($object->seriaId)
					if( in_array($this->getObject('\modules\parameters\components\parametersValues\lib\ParameterValue', $object->seriaId)->getValue(), $seria) )
						$idString .= $object->id.',';

			if(strlen($idString) > 0)
				$idString = substr($idString, 0, strlen($idString)-1);

			$objects->resetFilters();
			if(!empty($idString))
				$objects->setSubquery(' AND `id` IN(?s)', $idString);
			else
				$objects->setSubquery(' AND `id` IN(?s)', 0);
		}
	}

	public function getObjectsByCategory($category, $fabricatorId = null)
	{
		$objects = $this->getActiveObjects()
					->setFiltersByCategoryAlias($category->alias);
		if(isset($fabricatorId))
			$objects->setSubquery('AND `fabricatorId` = ?d', $fabricatorId);
		return $objects;
	}

	public function getPropertiesListByAlias($alias)
	{
		$properties = new \modules\properties\lib\Properties;
		$propertiesValues = new \modules\properties\components\propertiesValues\lib\PropertyValues;
		$propertiesValues->setSubquery(' AND `propertyId` IN ( SELECT `id` FROM `'.$properties->mainTable().'` WHERE `alias` = \'?s\' ) ', $alias);
		return $propertiesValues;
	}

	public function getSeriesByFabricator($fabricator)
	{
		if(!$fabricator->getParameters()->count())
			return false;

		$res = \core\db\Db::getMysql()->rows(
			'SELECT `objectId`, (SELECT `value` FROM `tbl_parameters_values` WHERE `id` = `objectId`) AS `name` '
				. 'FROM `tbl_fabricators_parameters_values_relation` WHERE `ownerId` = "'.$fabricator->id.'"'
				. ' ORDER BY `name` ASC'
		);

		$ids = '';
		foreach($res as $key=>$item)
			$ids .= $item['objectId'].',';
		$ids = substr($ids, 0, strlen($ids)-1);

		return $fabricator->getParameters()
						->setSubquery('AND `objectId` IN ('.$ids.') ORDER BY FIELD(objectId, '.$ids.')');
	}

    protected function getCategoriesByFabricatorId($fabricatorId)
    {
        $catalog = $this->getCatalogObject();
        $categoriesId = \core\db\Db::getMysql()->rows('SELECT DISTINCT `categoryId` FROM `'.$catalog->mainTable().'` '
            . 'WHERE `fabricatorId` ='.$fabricatorId.' '
            . '	AND `statusId` NOT IN ('.implode(',', $this->getExludedStatusesArray()).')');

        if(empty($categoriesId))
            return false;

        $array = array();
        foreach ($categoriesId as $key=>$value){
            $category = $this->getObject('\modules\catalog\categories\CatalogCategory', $value['categoryId'], $this->_config);
            $array[$category->getName()] = $category;
        }
        ksort($array);
        return $array;
    }

    protected function getActiveCategories()
    {
        $categories = (new \core\modules\categories\Categories($this->_config));
        return $categories->setSubquery(' AND `statusId` = ?d', 1);
    }

    protected function getFabricatorsConfig()
    {
        return $this->getObject('\modules\fabricators\lib\FabricatorConfig');
    }

    protected function getFabricatorById($id)
    {
        return $this->getObject('\modules\fabricators\lib\Fabricator', $id);
    }

    protected function getMinPriceByObjects($objects)
    {
        $minPrice = $objects->current()->getPriceByMinQuantity();
        foreach($objects as $object){
            $price = $object->getPriceByMinQuantity();
            if($price < $minPrice)
                $minPrice = $price;
        }
        return (int)$minPrice;
    }

    protected function getMainCategoriesWhichHasChildren($fabricatorId)
    {
        $categories = array();
        foreach ($this->getMainCategoriesArrayByFabricatorId($fabricatorId) as $category)
            if($category->getChildren(1))
                $categories[] = $category;
        return $categories;
    }

    private function getMainCategoriesArrayByFabricatorId($fabricatorId)
    {
        $categoriesId = \core\db\Db::getMysql()
            ->rows('SELECT DISTINCT `parentId` FROM `'.$this->getCatalogObject()->mainTable().'_categories` WHERE `parentId` != 0 AND `id` IN '
                . '(SELECT DISTINCT `categoryId` FROM `'.$this->getCatalogObject()->mainTable().'` WHERE '
                . '`fabricatorId` = '.$fabricatorId.' AND `statusId` NOT IN ('.implode(',', $this->getExludedStatusesArray()).') )');

        if(empty($categoriesId))
            return false;

        $array = array();
        foreach ($categoriesId as $key=>$value)
            $array[] = $this->getObject('\modules\catalog\categories\CatalogCategory', $value['parentId'], $this->_config);

        usort($array, function($a, $b){
            if ($a->priority == $b->priority) return 0;
            return ($a->priority < $b->priority) ? -1 : 1;
        });

        return $array;
    }

    protected function getParameterValuesObject()
	{
		return new \modules\parameters\components\parametersValues\lib\ParameterValues();
	}

    protected function checkSeriaCategoryPath($seria, $category, $fabricatorId = null)
    {
        if($this->getUriLength() != 2) return false;
        if(!$category->isMain()) return false;
        $objects = $this->getActiveObjectsBySeriaAndCategory($seria, $category);
        if(!$objects->count()) return false;
        return $objects->current()->getCategory()->getParent()->alias == $category->alias;
    }

    protected function getActiveObjectsBySeriaAndCategory($seria, $category, $fabricatorId = null)
    {
        return $this->getObjectsByCategory($category, $fabricatorId)
                    ->setSubquery(' AND `seriaId` = ?d', $seria->id);
    }

    protected function getParameterArrayByIdAndGood($parameterId, $good)
    {
        $parameters = (new \modules\parameters\lib\Parameters())
            ->setSubquery('AND `id` = (?d)', $parameterId)
            ->setOrderBy('`priority` ASC');

        $array = array();
        foreach( $parameters as $parameter ){
            $parameterValues = $parameter->getParameterValuesByObjectParametersArray($good->getParametersArray());
            if(isset($parameterValues[0]))
                foreach($parameterValues  as $value )
                    $array[] = $value;
        }
        return empty($array) ? false : $array;
    }

    protected function getOtherGoodsOfSeriaAndCategory($object, $limit)
    {
        $category = $object->getCategory()->isMain() ? $object->getCategory() : $object->getCategory()->getParent();
        $objects = $this->getActiveObjectsBySeriaAndCategory($object->getSeriaObject(), $category);
        return $objects->setSubquery('AND `id` != (?d)', (int)$object->id)
            ->setSubquery('AND `statusId` NOT IN (?s)', implode(',', $this->getExludedStatusesArray()))
            ->setOrderBy('RAND()')
            ->setLimit($limit);
    }

    protected function getSorting($category = null)
    {
        $sortingValues = (new CatalogCategoryConfig())->getSortingValues();
        $currentSortField = '';
        $sortString = "`priority` ASC";

        if (isset($this->getGET()['sortBy'])  &&  !empty($this->getGET()['sortBy'])) {
            $sortKeys = array_keys($this->getGET()['sortBy']);
            $sortKey = array_pop($sortKeys);
            $sortDirection = $this->getGET()['sortBy'][$sortKey];
            $currentSortField = $sortKey;
        }
        elseif(isset($category)  && $category->getSorting() && $category->getSortingKey()){
            $currentSortField = $category->getSorting();
            $sortKey = $category->getSorting();
            $sortDirection = $category->getSortingKey();
        }

        if(isset($sortKey)  &&  isset($sortingValues[$sortKey][$sortDirection]))
            $sortString = $sortingValues[$sortKey][$sortDirection];

        $sorting = array(
            'current' => $currentSortField,
            'direction' => isset($sortDirection) ? $sortDirection : '',
            'sortString' => $sortString,
            'fields' => array_flip((new CatalogCategoryConfig())->getSortingValuesTranslate()),
            'view' => array(
                'list' => 'catalogVerticalListContent',
                'tile' => 'catalogListContent'
            )
        );

        return $sorting;
    }

    protected function getCategoryById($categoryId)
    {
        return $this->getActiveCategories()->getObjectById($categoryId);
    }

    protected function getOneObjectOfCategoryOrChildren($category, $fabricatorId = null)
    {
        $objects = $this->getObjectsByCategory($category, $fabricatorId)
                        ->setOrderBy('RAND()');
        if($objects->count())
            return $objects->current();
        foreach ($category->getChildren() as $child){
            $objects = $this->getObjectsByCategory($child, $fabricatorId);
            if($objects->count())
                return $objects->current();
        }

        return $this->getNoop();
    }

    protected function getSeriesByCategoryAndFabricator($category, $fabricator)
    {
        if(!$fabricator->getParameters()->count()) return false;

        return $fabricator->getParameters()
            ->setSubquery(
                'AND `objectId` IN ('
                . 'SELECT `seriaId` FROM `'.$this->getCatalogObject()->mainTable().'` WHERE `categoryId` IN ('
                . 'SELECT `id` FROM `'.$this->getCatalogObject()->mainTable().'_categories`  WHERE (`parentId` = '.$category->id.' OR `id` = '.$category->id.'))
                        )'
            );
    }
}