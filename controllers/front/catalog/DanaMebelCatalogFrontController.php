<?php
namespace controllers\front\catalog;
class DanaMebelCatalogFrontController extends \controllers\front\catalog\CatalogFrontController
{
	const QUANTITY_ITEMS_ON_SUBPAGE = 30;
	const QUANTITY_OF_OTHER_GOODS_OF_SERIA_AND_CATEGORY = 3;
	const QUANTITY_OF_NEW_GOODS_ON_INDEX = 4;

	protected $permissibleActions = array(
        'getFabricatorsConfig',
        'getFabricatorById',
		'getCatalogLeftMenu',
		'getMainCategoriesWhichHasChildren',
		'getCatalogObjectBlock',
		'getSeriaBlock',
		'search',
		'getGoodsWithSubgoodsBySeria',
		'getNewObjects',
		'getFirstObjectOfCategoryAndSeria',
        'types',
        'getCategoriesByFabricatorId',
        'skidki',
        'getDanaFabricatorId',
        'getActiveCategories',
        'getItemsByFabricatorId',
        'getSeriesByCategoryAndFabricator'
	);

	protected function pageDetect()
	{
		$alias = $this->getLastElementFromRequest();
        $preAlias = $this->getElementFromTheEndOfRequest(2);

		$good = $this->getGoodByAlias($alias);
		if ($good){
			if ($this->checkObjectPath($good)){
				if($this->isDownloadFileRequested())
					return $this->downloadFile($good);
				return $this->viewGood($good);
			}
		}

		$category = $this->getCatalogObject()->getCategories()->getObjectByAlias($alias);
        $preCategory = $this->getCatalogObject()->getCategories()->getObjectByAlias($preAlias);

		if ($category){
			if($category->isMain()){
				if($this->checkObjectPath($category))
					return $this->viewMainCategory($alias);
				$seria = $this->getParameterValuesObject()->getObjectByAlias($this->getUriElement(-2));
				if($seria)
					if($this->checkSeriaCategoryPath($seria, $category, $this->getDanaFabricatorId()))
						return $this->viewSeria($seria, $category, 'seria');
			}
			elseif($preCategory  &&  !$this->getUriElement(-3)){
                if($preCategory->isMain()    &&    $category->parentId == $preCategory->id   &&   $this->checkObjectPath($category))
                    return $this->viewCategory($category);
            }
			else{
				$seria = $this->getParameterValuesObject()->getObjectByAlias($this->getUriElement(-3));
				if($seria)
					return $this->viewSeria($seria, $category, 'seria');
			}
		}

		$seria = $this->getParameterValuesObject()->getObjectByAlias($alias);
		if ($seria){
			$category = $this->getCatalogObject()->getCategories()->getObjectByAlias($this->getElementFromTheEndOfRequest(2));
			if($category)
				if ($this->checkSeriaCategoryPath($seria, $category, $this->getDanaFabricatorId()))
					return $this->viewSeria($seria, $category, 'category');
			if(!$this->getUriElement(2))
				return $this->seriaCategories ($seria);
		}

		$this->sendRequestToArticlesController();
	}

	protected function checkObjectPath($object)
	{
		return rtrim($object->getPath(), '/') == rtrim(str_replace('?'.$this->getSERVER()['REDIRECT_QUERY_STRING'], '', $this->getSERVER()['REQUEST_URI']), '/');
	}

	private function checkObjectPathWithSeriaFirst($object, $seria)
	{
		return '/'.$seria->alias.rtrim($object->getPath(), '/') == rtrim(str_replace('?'.$this->getSERVER()['REDIRECT_QUERY_STRING'], '', $this->getSERVER()['REQUEST_URI']), '/');
	}

	protected function index()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$article = $this->getObject('\modules\articles\lib\Articles')->getObjectByAlias('index_dana');
			$this->setMetaFromObject($article)
				->setContent('article', $article)
				->setContent('series', $this->getSeriesByFabricator($this->getFabricatorById($this->getDanaFabricatorId())))
				->setContent('fabricator', $this->getFabricatorById($this->getDanaFabricatorId()))
				->setContent('sizesAndWeight', $this->getPropertiesListByAlias('sizesAndWeight'))
				->setContent('mainSliderGoods', $this->getActiveObjects()
                                                    ->setSubquery('AND `onMainDanaPage` = ?d', 1)
                )
				->includeTemplate('index');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	protected function setMetaFromObject($object)
	{
		$articleConfig = new \modules\articles\lib\ArticleConfig;
		$defaultMetaArticle = (new \modules\articles\lib\Articles())->getObjectByAlias($articleConfig::DEFAULT_META_DANA_ARTICLE_ALIAS);

		if(get_class( $object ) == 'modules\parameters\components\parametersValues\lib\ParameterValue'){
			$alias = strtok($_SERVER["REQUEST_URI"],'?');
			$alias = substr(substr($alias,1), 0, -1);
			$alias = str_replace('/', '_', $alias);
			$seriaMetaArticle = (new \modules\articles\lib\Articles())->getObjectByAlias($alias);
		}

		$articleConfig = new \modules\articles\lib\ArticleConfig();
		$object = (!empty($seriaMetaArticle)   &&   $seriaMetaArticle->categoryId == $articleConfig::META_DANA_CATEGORY_ID)
						?
					$seriaMetaArticle
						:
					$object;

		return $this->setTitle(empty($object->getMetaTitle()) ? $defaultMetaArticle->getMetaTitle() : $object->getMetaTitle())
					->setDescription(empty($object->getMetaDescription()) ? $defaultMetaArticle->getMetaDescription() : $object->getMetaDescription())
					->setKeywords(empty($object->getMetaKeywords()) ? $defaultMetaArticle->getMetaKeywords() : $object->getMetaKeywords());
	}

	protected function getCatalogLeftMenu()
	{
		$cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->setContent('catalogLeftMenu', $this->getMainCategoriesWhichHasChildren($this->getDanaFabricatorId()))
				 ->includeTemplate('catalog/catalogLeftMenu');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	protected function getDanaFabricatorId()
	{
		return $this->getFabricatorsConfig()->getDanaFabricatorId();
	}

	protected function viewMainCategory($alias)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();

			$category = $this->getCatalogObject()->getCategories()->getObjectByAlias($alias);
			$this->setLevel($category->getParent()->name, $category->getParent()->getPath())
				 ->setLevel($category->getName());

            $fabricator = $this->getFabricatorById($this->getDanaFabricatorId());
            $series = $this->getSeriesByCategoryAndFabricator($category, $fabricator);

			$this->setContent('bodyClass', 'insetPage')
				->setContent('series', $series)
				->setContent('fabricator', $fabricator)
                ->setContent('h1', $category->getName())
				->setMetaFromObject($category)
				->includeTemplate('catalog/mainCategory');

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	protected function getSeriaBlock($series)
	{
		$this->setContent('series', $series)
			->includeTemplate('catalog/seriaBlock');
	}

	private function viewSeria($seria, $category, $firstLevelType)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();

			if($firstLevelType == 'category'){
				$this->setLevel($category->getName(), $category->getPath())
					->setLevel($seria->getValue())
					->setContent('h1', $seria->getValue());
			}

			if($firstLevelType == 'seria'){
				$this->setLevel($seria->getValue(), '/'.$seria->getAlias().'/')
					->setLevel($category->getName())
					->setContent('h1', $category->getName());
			}

			$objects = $this->getActiveObjectsBySeriaAndCategory($seria, $category)
							->setQuantityItemsOnSubpageList(array(self::QUANTITY_ITEMS_ON_SUBPAGE))
							->setPager(self::QUANTITY_ITEMS_ON_SUBPAGE);

			$this->setContent('bodyClass', 'insetPage')
				->setContent('seria', $seria)
				->setContent('objects', $objects)
				->setContent('pager', $objects->getPager())
//				->setMetaFromObject($category)
				->setMetaFromObject($seria)
				->includeTemplate('catalog/seria');

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	private function viewGood($good)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();

			$category = $good->getCategory()->isMain() ? $good->getCategory() : $good->getCategory()->getParent();
			$seria = $good->getSeriaObject();

			$this->setLevel($category->getName(), $category->getPath())
				->setLevel($seria->getValue(), $good->getDanaSeriaPath())
				->setLevel($good->getName());

			$this->setContent('bodyClass', 'insetPage')
				->setMetaFromObject($good)
				->setContent('object', $good)
				->setContent('sizesAndWeight', $this->getPropertiesListByAlias('sizesAndWeight'))
				->setContent('materialArray', $this->getParameterArrayByIdAndGood($this->_config->getMaterialParametersId(), $good))
				->setContent('corpusArray', $this->getParameterArrayByIdAndGood($this->_config->getCorpusParametersId(), $good))
				->setContent('fasadArray', $this->getParameterArrayByIdAndGood($this->_config->getFasadParametersId(), $good))
				->setContent('otherGoodsOfSeriaAndCategory', $this->getOtherGoodsOfSeriaAndCategory($good, self::QUANTITY_OF_OTHER_GOODS_OF_SERIA_AND_CATEGORY))
				->includeTemplate('catalog/catalogObject'.($good->isSubGoodsExists() ? 'WithSubgoods' : ''));

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	protected function getCatalogObjectBlock($objects)
	{
		$this->setContent('objects', $objects)
			->setContent('sizesAndWeight', $this->getPropertiesListByAlias('sizesAndWeight'))
			->includeTemplate('catalog/catalogObjectBlock');
	}

	private function seriaCategories($seria)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();

			$this->setLevel($seria->getValue())
				->setContent('bodyClass', 'insetPage')
				->setMetaFromObject($seria)
				->setContent('seria', $seria)
				->setContent('seriaCategories', $this->getCategoriesOfSeria($seria))
				->includeTemplate('catalog/seriaCategories');

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	private function getCategoriesOfSeria($seria)
	{
		$objects = $this->getObjectsByFabricatorAndSeria($this->getDanaFabricatorId(), $seria->getValue());
		return $this->getCategoriesByObjects($objects);
	}

	private function getCategoriesByObjects($objects)
	{
		$objectsIds = \core\utils\Utils::getCountableObjectPropertiesString($objects, 'id');
		return $this->getCatalogObject()->getCategories()
						->setSubquery('AND `id` IN (SELECT DISTINCT `categoryId` FROM `'.$this->getCatalogObject()->mainTable().'` WHERE '
							. '`id` IN ('.$objectsIds.') AND `statusId` NOT IN ('.implode(',', $this->getExludedStatusesArray()).') )');
	}

	private function getMainCategoriesByObjects($objects)
	{
		$objectsIds = \core\utils\Utils::getCountableObjectPropertiesString($objects, 'id');
		return $this->getCatalogObject()->getCategories()
						->setSubquery('AND `id` IN (SELECT DISTINCT `parentId` FROM `'.$this->getCatalogObject()->mainTable().'_categories` WHERE `id` IN '
							. '(SELECT DISTINCT `categoryId` FROM `'.$this->getCatalogObject()->mainTable().'` WHERE '
							. '`id` IN ('.$objectsIds.') AND `statusId` NOT IN ('.implode(',', $this->getExludedStatusesArray()).') ) )');
	}

	protected function search()
	{
		if($this->getUriLength() > 1) return $this->redirect404 ();
		if(empty($this->getGET()['find'])) return header('Location: /');

		$objects = $this->getActiveObjects();

		if(!empty($this->getGET()['find'])){
			$find = \core\utils\DataAdapt::textValid($this->getGET()['find']);
			$objects->setSubquery('AND `fabricatorId` = ?d', $this->getDanaFabricatorId())
					->setSubquery('AND `id` IN ('
				. 'SELECT `id`  FROM `'.\modules\catalog\CatalogFactory::getInstance()->mainTable().'` '
				. 'WHERE LOWER(`name`) LIKE \'%?s%\')', strtolower($find));
		}

		$objects->setQuantityItemsOnSubpageList(array(self::QUANTITY_ITEMS_ON_SUBPAGE))
						->setPager(self::QUANTITY_ITEMS_ON_SUBPAGE);

		$this->setTitle('Поиск')
			->setDescription('Поиск')
			->setKeywords('Поиск')
			->setLevel('Поиск')
			->setContent('h1', 'Поиск: '.$this->getGet()['find'])
			->setContent('bodyClass', 'insetPage')
			->setContent('objects', $objects)
			->setContent('pager', $objects->getPager())
			->includeTemplate('catalog/seria');
	}

	protected function getGoodsWithSubgoodsBySeria($seria)
	{
		return $this->getActiveObjects()
					->setSubquery('AND `seriaId` = ?d', $seria->id)
					->setSubquery('AND `fabricatorId` = ?d', $this->getDanaFabricatorId())
					->setSubquery('AND `id` IN (SELECT `goodId` FROM `tbl_catalog_subgoods` WHERE 1=1)')
					->setOrderBy('RAND()');
	}

	protected function getNewObjects()
	{
		return $this->getActiveObjects()
					->setSubquery('AND `fabricatorId` = ?d', $this->getDanaFabricatorId())
					->setSubquery('AND `statusId` = ?d', $this->_config->getNewStatusId())
					->setOrderBy('RAND()')
					->setLimit(self::QUANTITY_OF_NEW_GOODS_ON_INDEX);
	}

	protected function getFirstObjectOfCategoryAndSeria($category, $seria)
	{
		$objects = $this->getObjectsByFabricatorAndSeria($this->getDanaFabricatorId(), $seria->getValue())
					->setSubquery('AND `categoryId` = ?d', $category->id);
		return $objects->current();
	}

	protected function types()
    {
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();

            $this->setLevel('Все категории фабрики')
                ->setContent('bodyClass', 'insetPage')
                ->setContent('h1', 'Все категории фабрики')
                ->includeTemplate('catalog/mainCategory');

            $contents = ob_get_contents();
            ob_end_clean();
            \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
        }
        echo $contents;
    }

    protected function viewCategory($category)
    {
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();

            $objects = $this->getObjectsByCategory($category, $this->getDanaFabricatorId())
                            ->setQuantityItemsOnSubpageList(array(self::QUANTITY_ITEMS_ON_SUBPAGE))
                            ->setPager(self::QUANTITY_ITEMS_ON_SUBPAGE);

            $this->setLevel($category->getParent()->getName(), $category->getParent()->getPath())
                ->setLevel($category->getName())
                ->setMetaFromObject($category)
                ->setContent('bodyClass', 'insetPage')
                ->setContent('h1', $category->getName())
                ->setContent('objects', $objects)
                ->setContent('pager', $objects->getPager())
                ->includeTemplate('catalog/seria');

            $contents = ob_get_contents();
            ob_end_clean();
            \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
        }
        echo $contents;
    }

    protected function skidki()
    {
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();

            $category = $this->getCatalogObject()->getCategories()->getObjectByAlias(__FUNCTION__);
            $objects = $this->getObjectsByCategory($category, $this->getDanaFabricatorId())
                ->setQuantityItemsOnSubpageList(array(self::QUANTITY_ITEMS_ON_SUBPAGE))
                ->setPager(self::QUANTITY_ITEMS_ON_SUBPAGE);

            $this->setLevel($category->getName())
                ->setMetaFromObject($category)
                ->setContent('bodyClass', 'insetPage')
                ->setContent('h1', $category->getName())
                ->setContent('objects', $objects)
                ->setContent('pager', $objects->getPager())
                ->includeTemplate('catalog/seria');

            $contents = ob_get_contents();
            ob_end_clean();
            \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
        }
        echo $contents;
    }
}