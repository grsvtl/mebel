<?php
namespace controllers\front\catalog;
use modules\catalog\categories\CatalogCategoryConfig;

class VnMebelCatalogFrontController extends \controllers\front\catalog\CatalogFrontController
{
	const NUMBER_OF_ADDITIONAL_GOODS = 3;
	const NUMBER_OF_OFFERS_IN_LEFT_COLUMN_AND_INDEX = 2;

	const NUMBER_OF_ELEMENTS_IN_INDEX_CATEGORY_BLOCK = 9;
	const FIRST_INDEX_CATEGORY_ID = 9;
	const SECOND_INDEX_CATEGORY_ID = 96;
	const QUANTITY_ITEMS_ON_SUBPAGE = 15;
	const NO_PAGINATION_QUANTITY_ITEMS = 1000000;
	const SECOND_SERIA_PARAMETER_ID = 67;

	private $smallForms = array(
	    4,5,6,11,14
	);
	private $gamesConstructions = array(
	    21,22,23,24,25,26
	);

	private $designedCategories = array(
		109 => 'cabinet',
		107 => 'detsckie',
		108 => 'gostinye',
		170 => 'miaghaiaMebel',
		110 => 'prihojie',
		104 => 'spalnii',
        202 => 'akcii'
	);

	private $quantityItemsOnSubpageCategoriesId = array(
		138 => 30,
		167 => 30
	);

	protected $permissibleActions = array(
		'getTopMenu',
		'getMainCategoriesWhichHasChildren',
		'getHeaderCategories',
		'search',
		'getAdditionalGoodsBlock',
		'getCatalogByCategoryId',
		'getCategoryById',
		'getLeftOffersBlock',
		'getOtherObjectsOfCategory',
		'getObjectPropertiesListByAlias',
		'getCatalogListContent',
		'ajaxGetCatalogListContent',
		'getMinPrice',
		'getMaxPrice',
		'getFilterBlockManufacturer',
		'ajaxGetFilterBlockManufacturer',
		'ajaxGetFilterBlockSeries',
		'getFilterBlockSeries',
		'ajaxGetSearchContent',
		'getSearchContent',
		'getCategoriesByFabricatorId',
		'getItemsByFabricatorId',
		'getCatalogListContentItemBlock',
		'getQuantityByCategoryAlias',
		'getFabricatorById',
		'countItemsByCategoryIdAndFabricatorId',
		'getOtherGoodsWithoutSubgoodsOfSeria',
		'getGoodsWithoutSubgoodsOfSecondSeria',
		'ajaxGetPriceByQuantity',
		'ajaxGetMinQuantity',
		'downloadFile',
		'getSpecialObjectsForIndex',
        'getActiveCategories',
        'getActiveObjects'
	);

	protected function pageDetect()
	{
		$alias = $this->getLastElementFromRequest();
		$good = $this->getGoodByAlias($alias);
		if ($good){
			if ($this->checkObjectPath($good)){
				if($this->isDownloadFileRequested())
					return $this->downloadFile($good);
				return $this->viewGood($good);
			}
		}

		$category = $this->getCatalogObject()->getCategories()->getObjectByAlias($alias);

		if ($category){
			if ($this->checkObjectPath($category))
				return $this->viewCategory($alias);
		}

		$this->sendRequestToArticlesController();
	}

	protected function index()
	{
		echo $this->index1Cache().$this->index2Cache().$this->index3Cache();
	}

	private function index1Cache()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->setMetaFromObject($this->getObject('\modules\articles\lib\Articles')->getObjectByAlias('index'))
				->includeTemplate('index1Cache');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

    private function index2Cache()
    {
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        if($this->getPOST()['clearCurrentPageCache'] === 'true')
            return \core\cache\Cacher::getInstance()->remove($cacheKey);

        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();
            $this->includeTemplate('index2NoCache');
            $contents = ob_get_contents();
            ob_end_clean();
            \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
        }
        echo $contents;
    }

	private function index3Cache()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		if($this->getPOST()['clearCurrentPageCache'] === 'true')
			return \core\cache\Cacher::getInstance()->remove($cacheKey);

		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->includeTemplate('index3Cache');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	protected function viewCategory($alias)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();

			$category = $this->getCatalogObject()->getCategories()->getObjectByAlias($alias);
			$this->setLevel($category->getParent()->name, $category->getParent()->getPath())
				 ->setLevel($category->getName());

			if(isset($this->designedCategories[$category->id]))
				$this->setContent ('mainCategoryContentInclude', $this->designedCategories[$category->id]);

			$this->setContent('category', $category)
				 ->setMetaFromObject($category)
				 ->includeTemplate('catalog/catalogList');

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	protected function getCatalogListContent($criteria)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
//			if(get_class($criteria) == 'core\modules\categories\Category'){
			if(get_class($criteria) == 'modules\catalog\categories\CatalogCategory'){
				$category = $criteria;
				$objects = $this->getObjectsByCategory($category, $this->getGet()['fabricator']);
			}
			else{
				$objects = $criteria;
				$category = $objects->current()->getCategory();
			}

            $sorting = $this->getSorting($category);

			if ( $objects->count() > 0 ) {
				$objects->setOrderBy($sorting['sortString'])
						->setQuantityItemsOnSubpageList(array($this->getQuantityItemsOnSubpage($category->id)))
						->setPager( $this->getQuantityItemsOnSubpage($category->id) );
			}

			$template = isset($this->getGet()['view'])  &&  isset($sorting['view'][$this->getGet()['view']])
                ?
                $sorting['view'][$this->getGet()['view']]
                :
                $category->template;

			ob_start();
			if(isset($category) && get_class($category)=='core\modules\categories\Category'){
				if(isset($this->designedCategories[$category->id]))
					$this->setContent ('mainCategoryContentInclude', $this->designedCategories[$category->id]);
				$this->setContent('category', $category);
			}
			$this->setContent('objects', $objects)
				 ->setContent('pager', $objects->getPager())
				 ->setContent('sorting', $sorting)
				 ->setContent('template', $template)
				 ->includeTemplate('/catalog/'.$template);
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		return $contents;
	}

	private function getQuantityItemsOnSubpage($categoryId = false)
	{
		$return = $categoryId
					?
				isset($this->quantityItemsOnSubpageCategoriesId[$categoryId]) ? $this->quantityItemsOnSubpageCategoriesId[$categoryId]  : self::QUANTITY_ITEMS_ON_SUBPAGE
					:
				self::QUANTITY_ITEMS_ON_SUBPAGE;
		return $return;
	}

	protected function ajaxGetCatalogListContent()
	{
		$category = $this->getCatalogObject()->getCategories()->getObjectById($this->getPost()['data']);
		echo $this->getCatalogListContent($category);
	}

	protected function viewGood($good)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();

			$this->setLevels($good)
				->setMetaFromObject($good)
				->setContent('object', $good)
				->setContent('objects', $this->getCatalogObject())
				->setContent('parameters', $this->getParametersToParametersBlock())
				->setContent('sizesAndWeight', $this->getPropertiesListByAlias('sizesAndWeight'))
				->setContent('delivery', $this->getGoodOrFabricatorPropertyListByAlias('delivery', $good))
				->setContent('lifting', $this->getGoodOrFabricatorPropertyListByAlias('lifting', $good))
				->setContent('fitting', $this->getGoodOrFabricatorPropertyListByAlias('fitting', $good))
				->includeTemplate('catalog/catalogObject');

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	protected function isFirstElement($number)
	{
		return !($number % 3);
	}

	protected function isLastElement($number)
	{
		return !(($number+1) % 3);
	}

	protected function getTopMenu()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->setContent('topMenu', $this->getMainCategoriesWhichHasChildren())
				 ->includeTemplate('catalog/topMenu');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	protected function getMainCategoriesWhichHasChildren($fabricatorId = null)
	{
		$categories = array();
		foreach ($this->getCatalogObject()->getMainCategories(self::ACTIVE_CATEGORY_STATUS) as $category)
			if($category->getChildren(1))
				$categories[] = $category;
		return $categories;
	}

	private function getMainCategoriesIdWhichHasChildrenString()
	{
		$string = '';
		$array = $this->getMainCategoriesWhichHasChildren();
		if(is_array($array))
			foreach($array as $category)
				$string .= $category->id.',';
		return !empty($array) ? substr($string, 0, strlen($string)-1) : $string;
	}

	protected function getHeaderCategories()
	{
		$smallForms = $this->getCatalogObject()->getCategories()->setSubquery(' AND `id` IN(?s)',implode(',',$this->smallForms));
		$gamesConstructions = new \modules\catalog\constructions\lib\Constructions();
		$gamesConstructions = $gamesConstructions->getCategories()->setSubquery(' AND `id` IN(?s)',implode(',',$this->gamesConstructions));
		$this->setContent('smallForms', $smallForms)
			 ->setContent('gamesConstructions', $gamesConstructions)
		     ->includeTemplate('headerCategories');
	}

	protected function search()
	{
		$this->setLevel('Поиск');
		$this->setContent('content', $this->getSearchContent())
			->includeTemplate('/catalog/search');
	}

	protected function getSearchContent()
	{
		$search = $this->getGet();
		$objects = $this->getSearchListObjects($search);
		if(!$objects->current()){
			ob_start();
				$this->setContent('objectsCount', 0)
					->includeTemplate('/catalog/searchContent');
				$contents = ob_get_contents();
			ob_end_clean();
			return $contents;
		}

		$category = $objects->current()->getCategory();

        $sorting = $this->getSorting();

		$objectsCount = $objects->count();
		if ( $objectsCount > 0 ) {
			$objects->setOrderBy($sorting['sortString'])
				->setQuantityItemsOnSubpageList(array($this->getQuantityItemsOnSubpage()))
				->setPager( $this->getQuantityItemsOnSubpage() );
		}

		$template = isset($search['view']) ? $sorting['view'][($search['view'])] : $category->template;

		ob_start();
			$this->setContent('objects', $objects)
				->setContent('objectsCount', $objectsCount)
				->setContent('pager', $objects->getPager())
				->setContent('sorting', $sorting)
				->setContent('template', $template)
				->includeTemplate('/catalog/searchContent');
			$contents = ob_get_contents();
		ob_end_clean();

		return $contents;
	}

	private function getSearchListObjects($search)
	{
		$objects = $this->getActiveObjects();

		if (!empty($search['seria']))
			$this->selectObjectsBySeria($objects, $search['seria']);

		if (is_array($search['fabricator'])  &&   count($search['fabricator'])  &&  !empty(current($_GET['fabricator'])))
			$objects->setSubquery('AND `fabricatorId` IN (?s)', implode(',', $search['fabricator']));

		if (is_array($search['mainCategory'])  &&   count($search['mainCategory'])  &&  !empty(current($_GET['mainCategory']))){
			$categoriesIdString = '';
			foreach($search['mainCategory'] as $mainCategoryId)
				foreach($this->getCategoryById($mainCategoryId)->getChildren() as $children)
					$categoriesIdString .= $children->id.',';
			$objects->setSubquery('AND `categoryId` IN (?s)', substr($categoriesIdString, 0, strlen($categoriesIdString)-1));
		}

		if (!empty($search['word']))
			$objects->setSubquery(
				'AND `id` IN (SELECT `id` FROM `tbl_catalog` WHERE ('
					. '`id` LIKE \'%?s%\' OR '
					. '`code` LIKE \'%?s%\' OR '
					. '`name` LIKE \'%?s%\'  OR '
					. '(`fabricatorId` IN (SELECT `id` FROM `tbl_fabricators` WHERE `name` LIKE \'%?s%\'))  OR'
					. '(`seriaId` IN (SELECT `id` FROM `tbl_parameters_values` WHERE `value` LIKE \'%?s%\'))'
				. '))',
				$search['word'], $search['word'], $search['word'], $search['word'], $search['word']
			);

		if (!empty($search['minPrice']))
			$objects->setSubquery('AND `id` IN (SELECT id FROM tbl_catalog WHERE getPriceById(tbl_catalog.id) >=  ?d)', $search['minPrice']);
		if (!empty($search['maxPrice']))
			$objects->setSubquery('AND `id` IN (SELECT id FROM tbl_catalog WHERE getPriceById(tbl_catalog.id) <=  ?d)', $search['maxPrice']);

		return $objects;
	}

	protected function ajaxGetSearchContent()
	{
		echo $this->getSearchContent();
	}

	private function getIdString()
	{
		$objectsArray = \modules\catalog\CatalogFactory::getInstance()->getGoodsByNameOrCode($this->getGET()['query'], $this->getCurrentDomainAlias());
		$objectsIdString = '';

		if(!empty($objectsArray))
			foreach ($objectsArray as $object)
				$objectsIdString = $objectsIdString.$object->id.',';

		$objectsIdString = substr($objectsIdString, 0, strlen($objectsIdString) - 1);
		return $objectsIdString ? $objectsIdString : -1;
	}

	protected function printParams($params)
	{
		if (is_array($params))
			$this->setContent('params', $params)
				 ->includeTemplate('catalog/paramsBlock');
		else
			echo $params;
		return $this;
	}

	protected function printSmallParams($params)
	{
		if (is_array($params))
			$this->setContent('params', $params)
				 ->includeTemplate('catalog/smallParamsBlock');
		else
			echo $params;
		return $this;
	}

	protected function getAdditionalGoodsBlock($goodId)
	{
		$this->setContent('objects', $this->getAdditionalGoods($goodId))
			->includeTemplate('/catalog/catalogObjectAdditionalGoods');
	}

	private function getAdditionalGoods($goodId)
	{
		$construction = \modules\catalog\CatalogFactory::getInstance()->getGoodById($goodId);
		$constructions = $this->getCatalogObject();
		return $constructions->setFiltersByCategoryAlias($construction->getCategory()->alias)
					->setSubquery('And mt.id<>?d', $goodId)
					->setOrderBy('RAND()')
					->setLimit(self::NUMBER_OF_ADDITIONAL_GOODS);
	}

	protected function getComplectsBlock($goodId)
	{
		$complects = $this->getComplects($goodId);
		if ($complects->count()) {
			$this->setContent('objects', $complects)
				->includeTemplate('/catalog/complects');
		}
	}

	private function getComplects($goodId)
	{
		$complects = new \modules\catalog\complects\lib\Complects();
		$config = $complects->getConfig();
		return $complects->getComplectsByGoodId($goodId, $config::ACTIVE_STATUS_ID);
	}

	protected function getCatalogByCategoryId($categoryId, $limit = false)
	{
		$objects = $this->getCatalogObject();
		$objects->resetFilters();
		$objects->setSubquery('AND `categoryId` = (?d)', (int)$categoryId)
				->setSubquery('AND `statusId` NOT IN (?s)', implode(',', $this->getExludedStatusesArray()))
				->setOrderBy('`priority` ASC, `date` ASC, `id` ASC');
		if($limit)
			$objects->setLimit($limit);

		return $objects;
	}

	protected function getCategoryById($id)
	{
		return new \core\modules\categories\Category($id, $this->_config);
	}

	protected function includeOfferToObjectContent($object)
	{
		echo $this->setContent('object', $object)
				  ->includeTemplate('catalog/offerToCatalogObject');
	}

	protected function getLeftOffersBlock()
	{
		$this->setContent('offers', $this->getValidOffers(self::NUMBER_OF_OFFERS_IN_LEFT_COLUMN_AND_INDEX))
			->includeTemplate('catalog/leftOffersBlock');
	}

	private function getValidOffers($limit)
	{
		$offers = new \modules\catalog\offers\lib\Offers();
		return $offers->getValidOffers($limit);
	}

	protected function getOtherObjectsOfCategory($object, $limit = false)
	{
		$objects = $this->getCatalogByCategoryId($object->categoryId);
		$objects->setSubquery('AND `id` != (?d)', (int)$object->id)
				->setOrderBy('`priority` ASC, `date` ASC, `id` ASC');
		if($limit)
			$objects->setLimit($limit);

		return $objects;
	}

	private function getParametersToParametersBlock()
	{
		$parameters = $this->getObject('\modules\parameters\lib\Parameters')
						->getParametersByCategoryAlias('catalogadmincontroller')
						->setSubquery('AND `id` != (?d)', self::SECOND_SERIA_PARAMETER_ID)
						->setOrderBy('`priority` ASC');
		return $parameters;
	}

	private function getGoodOrFabricatorPropertyListByAlias($alias, $object)
	{
		$properties = $this->getPropertiesListByAlias($alias);
		$propertiesArray = array();
		foreach( $properties as $item ){
			if($this->isNotNoop($object->getPropertyValueById($item->id)))
				$propertiesArray[] = array(
					'name' => $item->getValue(),
					'value' => $object->getPropertyValueById($item->id)->value,
					'measure' => $object->getPropertyValueById($item->id)->getMeasure()->shortName
				);
			else
				if($this->isNotNoop($object->getFabricator()->getPropertyValueById($item->id)))
					$propertiesArray[] = array(
						'name' => $item->getValue(),
						'value' => $object->getFabricator()->getPropertyValueById($item->id)->value,
						'measure' => $object->getFabricator()->getPropertyValueById($item->id)->getMeasure()->shortName
					);
		}

		return empty($propertiesArray) ? false : $propertiesArray;
	}

	protected function getObjectPropertiesListByAlias($alias, $object, $limit = null)
	{
		$array = array();
		$i = 1;
		foreach( $this->getPropertiesListByAlias($alias) as $item )
			if($object->getPropertyValueById($item->id)->value){
				$temp = array();
				$temp['name'] = $object->getPropertyValueById($item->id)->value;
				$temp['value'] = $item->getValue();
				$temp['measure'] = $object->getPropertyValueById($item->id)->getMeasure()->shortName;
				$array[] = $temp;
				if(isset($limit)  &&  $limit==$i)
					return empty($array) ? false : $array;
				$i++;
			}
		return empty($array) ? false : $array;
	}

	protected function getMinPrice(){
		return $this->getActiveObjects()
					->getMinPrice();
	}

	protected function getMaxPrice()
	{
		return $this->getActiveObjects()
					->getMaxPrice();
	}

	protected function getFilterBlockManufacturer($mainCategoriesId = null)
	{
		if(!isset($mainCategoriesId))
			$mainCategoriesId = $this->getMainCategoriesIdWhichHasChildrenString();

		$fabricators = false;
		if(isset($mainCategoriesId)  &&  !empty($mainCategoriesId))
			$fabricators = $this->getActiveObjects()->getFabricatorsByMainCategoriesId( is_array($mainCategoriesId) ? implode(',', $mainCategoriesId) : $mainCategoriesId );
		$this->setContent('fabricators', $fabricators)
			->includeTemplate('/catalog/filterBlockManufacturer');
	}

	protected function ajaxGetFilterBlockManufacturer()
	{
		$this->getFilterBlockManufacturer($this->getPOST()['mainCategoriesId']);
	}

	protected function ajaxGetFilterBlockSeries()
	{
		$this->getFilterBlockSeries($this->getPOST()['manufacturersId'], $this->getPOST()['mainCategoriesId']);
	}

	protected function getFilterBlockSeries($manufacturersId, $mainCategoriesId = null)
	{
		if(!isset($mainCategoriesId))
			$mainCategoriesId = $this->getMainCategoriesIdWhichHasChildrenString();

		$series = array();
		if(!empty($manufacturersId))
			foreach( (is_string($manufacturersId) ? explode(',', $manufacturersId) : $manufacturersId) as $fabricatorId)
				foreach(
						$this->getObject('\modules\fabricators\lib\Fabricator', $fabricatorId)->getParameters()
							->setSubquery('AND `objectId` IN ('
									. 'SELECT `seriaId` FROM `tbl_catalog_catalog` WHERE `categoryId` IN ('
									. 'SELECT `id` FROM `tbl_catalog_catalog_categories` WHERE `parentId` IN (?s))'
									. ')', is_string($mainCategoriesId) ? $mainCategoriesId : implode(',', $mainCategoriesId) )
				as $parameterValue)
					$series[] = $parameterValue;

		$seriesArray = array();
		if(!empty($series)){
			foreach($series as $seria)
				$seriesArray[] = $seria->getValue();
			sort($seriesArray);
			reset($seriesArray);
		}

		$this->setContent('series', $seriesArray)
			->includeTemplate('/catalog/filterBlockSeries');
	}

	protected  function getCatalogListContentItemBlock($object)
	{
		$this->setContent('object', $object)
			->includeTemplate('/catalog/catalogListContentItem');
	}

	protected function getQuantityByCategoryAlias($alias)
	{
		$category = $this->getCatalogObject()->getCategories()->getObjectByAlias($alias);
		if(!$category)
			return false;
		$catalog = $this->getObjectsByCategory($category);
		return $catalog->count() ? $catalog->count() : false;
	}

	protected function getFabricatorById($id)
	{
		return $this->getObject('\modules\fabricators\lib\Fabricator', $id);
	}

	protected function countItemsByCategoryIdAndFabricatorId($categoryId, $fabricatorId = null)
	{
		$objects = isset($fabricatorId) ? $this->getItemsByFabricatorId($fabricatorId) : $this->getActiveObjects();
		$objects->setSubquery('AND `categoryId` = (?d)', (int)$categoryId);
        $objects->setSubquery(' OR `id` IN (SELECT `ownerId` FROM `tbl_catalog_catalog_additional_categories` WHERE `objectId` = ?d)', (int)$categoryId);
        return $objects->count();
	}

	protected function getOtherGoodsOfSeria($object)
	{
		if(!$object->getSeriaObject())
			return new \core\Noop;

		$objects = $this->getObjectsByFabricatorAndSeria($object->getFabricator()->id, $object->getSeriaObject()->getValue());
		$objects->setSubquery('AND `id` != (?d)', (int)$object->id)
				->setSubquery('AND `statusId` NOT IN (?s)', implode(',', $this->getExludedStatusesArray()))
				->setOrderBy('`priority` ASC, `date` ASC, `id` ASC');
		return $objects;
	}

	protected function getGoodsOfSecondSeria($object)
	{
		if(!$object->getSeriaObject())
			return new \core\Noop;

		$parameterValues = new \modules\parameters\components\parametersValues\lib\ParameterValues;
		$parameterValues->setSubquery('AND `value` = \'?s\'', $object->getSeriaObject()->getValue())
						->setSubquery('AND `parameterId` = (?d)', self::SECOND_SERIA_PARAMETER_ID)
						->setLimit(1);
		if(!$parameterValues->count())
			return new \core\Noop();

		$objects = $this->getActiveObjectsBySeriaId($parameterValues->current()->id)
					->setSubquery('AND `id` != (?d)', (int)$object->id)
					->setSubquery('AND `statusId` NOT IN (?s)', implode(',', $this->getExludedStatusesArray()))
					->setOrderBy('`priority` ASC, `date` ASC, `id` ASC');
		return $objects;
	}

	protected function getOtherGoodsWithoutSubgoodsOfSeria($object)
	{
		$objects = $this->getObjectsByFabricatorAndSeria($object->getFabricator()->id, $object->getSeriaObject()->getValue());
		$objects->setSubquery('AND `id` != (?d)', (int)$object->id)
			     ->setSubquery('AND `statusId` NOT IN (?s)', implode(',', $this->getExludedStatusesArray()))
			     ->setSubquery('AND `id` NOT IN (SELECT `goodId` FROM `tbl_catalog_subgoods` WHERE 1=1)');
		return $objects;
	}

	protected function getGoodsWithoutSubgoodsOfSecondSeria($object)
	{
		$parameterValues = new \modules\parameters\components\parametersValues\lib\ParameterValues;
		$parameterValues->setSubquery('AND `value` = \'?s\'', $object->getSeriaObject()->getValue())
						->setSubquery('AND `parameterId` = (?d)', self::SECOND_SERIA_PARAMETER_ID)
						->setLimit(1);
		if(!$parameterValues->count())
			return new \core\Noop();

		$objects = $this->getActiveObjectsBySeriaId($parameterValues->current()->id)
					->setSubquery('AND `id` != (?d)', (int)$object->id)
					->setSubquery('AND `id` NOT IN (SELECT `goodId` FROM `tbl_catalog_subgoods` WHERE 1=1)');
		return $objects;
	}

	private function getActiveObjectsBySeriaId($seriaId)
	{
		$objects = $this->getActiveObjects();
//		$objects->setSubquery(' AND `id` IN( SELECT `ownerId` FROM `tbl_catalog_catalog_parameters_values_relation` WHERE `objectId` = ?d )', $seriaId);
		$subqueryResult = \core\db\Db::getSubqueryStringResult('SELECT `ownerId` FROM `tbl_catalog_catalog_parameters_values_relation` WHERE `objectId` = ?d', $seriaId);
		$objects->setSubquery(' AND `id` IN ('.($subqueryResult ? $subqueryResult : -1).') ');
		return $objects;
	}

	protected function ajaxGetPriceByQuantity()
	{
		$data = $this->getPost();
		$this->ajaxResponse( $this->getObject($this->objectClass, $data['id'])->getPrices()->getPriceByQuantity($data['quantity'])->getPrice() );
	}

	protected function ajaxGetMinQuantity()
	{
		$data = $this->getPost();
		$this->ajaxResponse( $this->getObject($this->objectClass, $data['id'])->getMinQuantity() );
	}

	protected function getSpecialObjectsForIndex($limit)
	{
		$objects = $this->getCatalogObject();
		$objects->resetFilters();

		$objects->setSubquery(
			'AND `statusId` IN (?s)',
			$this->_config->getSuperPriceStatusId().','.$this->_config->getTopSellStatusId().','.$this->_config->getNewStatusId()
		);

		$validOffers = $this->getValidOffers(9999999);

		if($validOffers->count())
			$objects->setSubquery(
				'OR id IN ('
					.'SELECT id FROM tbl_catalog_catalog where id IN ('
						.'SELECT goodId from tbl_catalog_offerGroup_goods WHERE offerGroupId IN ('
							.'SELECT id FROM tbl_catalog_offerGroups WHERE offerId IN ('
								.'SELECT `id` from `tbl_catalog_offers` WHERE `id` IN ( ?s )'
							.')'
						.')'
					.')'
				.')',
				$validOffers->getIdStringInModuleObjects()
			);

		if(!$objects->count())
			return false;

		return $objects->setOrderBy('RAND()')
						->setLimit($limit);
	}
}