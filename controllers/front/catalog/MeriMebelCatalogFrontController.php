<?php
namespace controllers\front\catalog;
use modules\articles\lib\Articles;
use modules\catalog\categories\CatalogCategoryConfig;

class MeriMebelCatalogFrontController extends \controllers\front\catalog\CatalogFrontController
{
	const QUANTITY_OF_OTHER_GOODS_OF_SERIA_AND_CATEGORY = 4;
    const QUANTITY_ITEMS_ON_SUBPAGE = 15;
    const QUANTITY_POPULAR_GOODS_ON_INDEX = 6;

    private $closetSeriesIdsString = '1181, 1184';
    private $excludeIncludeSeriesRules = array(
        '104' => 'AND `objectId` NOT IN (1184, 1181)',
        '108' => 'AND `objectId` IN (1108, 1109)',
        'gorki' => 'AND `objectId` IN (1129, 1128, 1130, 1132, 1133, 1134, 1131)',
    );

	protected $permissibleActions = array(
	    'getFabricatorsConfig',
        'getFabricatorById',
        'getMinPriceByObjects',
        'getMeriFabricatorId',
        'getMainCategoriesWhichHasChildren',
		'search',
        'getCategoriesByFabricatorId',
        'getItemsByFabricatorId',
        'getCategoryById',
        'getOneObjectOfCategoryOrChildren',
        'getSeriesByCategoryAndFabricator',
        'closet',
        'gorki'
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

		$category = $this->getCatalogObject()->getCategories()->getObjectByAlias($this->getLastElementFromRequest());

		if ($category){
            //			if($category->isMain())
            if($this->checkObjectPath($category))
                return $this->viewCategory($this->getLastElementFromRequest());
        }
        else{
            $seria = $this->getParameterValuesObject()->getObjectByAlias($this->getLastElementFromRequest());
            $category = $this->getCatalogObject()->getCategories()->getObjectByAlias($this->getElementFromTheEndOfRequest(2));
            if($seria  &&  $category)
                if($this->checkSeriaCategoryPath($seria, $category, $this->getMeriFabricatorId()))
                    return $this->viewSeria($seria, $category);
        }

		$this->sendRequestToArticlesController();
	}

	protected function checkObjectPath($object)
	{
		return rtrim($object->getPath(), '/') == rtrim(str_replace('?'.$this->getSERVER()['REDIRECT_QUERY_STRING'], '', $this->getSERVER()['REQUEST_URI']), '/');
	}

    protected function checkSeriaCategoryPath($seria, $category, $fabricatorId = null)
    {
        if(!in_array($this->getUriLength(), array(2,3))) return false;
        $objects = $this->getActiveObjectsBySeriaAndCategory($seria, $category);
        if(!$objects->count()) return false;
        return $objects->current()->getCategory()->getParent()->alias == $category->alias
                ||
                $objects->current()->getCategory()->alias == $category->alias;
    }

	protected function index()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$article = $this->getObject('\modules\articles\lib\Articles')->getObjectByAlias('index_meri');
			$this->setMetaFromObject($article)
				->setContent('mainSliderGoods', $this->getActiveObjects()
                                                    ->setSubquery('AND `onMainMeriPage` = ?d', 1)
                )
                ->setContent('popularGoods', $this->getItemsByFabricatorId($this->getMeriFabricatorId())
                                                                                ->setOrderBy('RAND()')
                                                                                ->setLimit(self::QUANTITY_POPULAR_GOODS_ON_INDEX)
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
		$defaultMetaArticle = (new \modules\articles\lib\Articles())->getObjectByAlias($articleConfig::DEFAULT_META_MERI_ARTICLE_ALIAS);

		if(get_class( $object ) == 'modules\parameters\components\parametersValues\lib\ParameterValue')
			$seriaMetaArticle = (new \modules\articles\lib\Articles())->getObjectByAlias($object->getAlias());

		$articleConfig = new \modules\articles\lib\ArticleConfig();
		$object = (!empty($seriaMetaArticle)   &&   $seriaMetaArticle->categoryId == $articleConfig::META_MERI_CATEGORY_ID)
						?
					$seriaMetaArticle
						:
					$object;

		return $this->setTitle(empty($object->getMetaTitle()) ? $defaultMetaArticle->getMetaTitle() : $object->getMetaTitle())
					->setDescription(empty($object->getMetaDescription()) ? $defaultMetaArticle->getMetaDescription() : $object->getMetaDescription())
					->setKeywords(empty($object->getMetaKeywords()) ? $defaultMetaArticle->getMetaKeywords() : $object->getMetaKeywords());
	}

	protected function getMeriFabricatorId()
	{
		return $this->getFabricatorsConfig()->getMeriFabricatorId();
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
            $fabricator = $this->getFabricatorById($this->getMeriFabricatorId());
            $series = $this->getSeriesByCategoryAndFabricator($category, $fabricator);

            if( isset($this->excludeIncludeSeriesRules[$category->id]) )
                $series->setSubquery( $this->excludeIncludeSeriesRules[$category->id] );

			$this->setContent('series', $series)
				->setContent('fabricator', $fabricator)
                ->setContent('h1', $category->getName())
                ->setContent('category', $category)
				->setMetaFromObject($category)
				->includeTemplate('catalog/category');

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	private function viewSeria($seria, $category)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$objects = $this->getActiveObjectsBySeriaAndCategory($seria, $category, $this->getMeriFabricatorId());

            $sorting = $this->getSorting($category);
            if( !$this->getGET()['sortBy'] )
                $sorting['sortString'] = (new CatalogCategoryConfig())->getSortingValues()['price']['down'];

            if ( $objects->count() > 0 )
                $objects->setOrderBy($sorting['sortString']);

            if(!$this->isNoop($category->getParent()))
                $this->setLevel($category->getParent()->getName(), $category->getParent()->getPath());

			$this->setLevel($category->getName(), $category->getPath())
                ->setLevel($seria->getValue())
                ->setContent('h1', $seria->getValue())
				->setContent('seria', $seria)
				->setContent('objects', $objects)
                ->setContent('sorting', $sorting)
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

			$this->setMetaFromObject($good)
				->setContent('object', $good)
				->setContent('sizesAndWeight', $this->getPropertiesListByAlias('sizesAndWeight'))
                ->setContent('materialArray', $this->getParameterArrayByIdAndGood($this->_config->getMaterialParametersId(), $good))
                ->setContent('corpusArray', $this->getParameterArrayByIdAndGood($this->_config->getCorpusParametersId(), $good))
                ->setContent('fasadArray', $this->getParameterArrayByIdAndGood($this->_config->getFasadParametersId(), $good))
				->setContent('otherGoodsOfSeriaAndCategory', $this->getOtherGoodsOfSeriaAndCategory($good, self::QUANTITY_OF_OTHER_GOODS_OF_SERIA_AND_CATEGORY))
				->includeTemplate('catalog/catalogObject');

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	protected function search()
	{
		if($this->getUriLength() > 1) return $this->redirect404 ();
		if(empty($this->getGET()['word'])) return header('Location: /');

		$objects = $this->getActiveObjects();

		if(!empty($this->getGET()['word'])){
			$find = \core\utils\DataAdapt::textValid($this->getGET()['word']);
			$objects->setSubquery('AND `fabricatorId` = ?d', $this->getMeriFabricatorId())
					->setSubquery('AND `id` IN ('
				. 'SELECT `id`  FROM `'.\modules\catalog\CatalogFactory::getInstance()->mainTable().'` '
				. 'WHERE LOWER(`name`) LIKE \'%?s%\')', strtolower($find));
		}

        $sorting = $this->getSorting();

        if ( $objects->count() > 0 )
            $objects->setOrderBy($sorting['sortString'])
                    ->setLimit(99);

		$this->setTitle('Поиск')
			->setDescription('Поиск')
			->setKeywords('Поиск')
			->setLevel('Поиск')
			->setContent('h1', 'Поиск: '.$this->getGet()['word'])
            ->setContent('sorting', $sorting)
			->setContent('objects', $objects)
			->includeTemplate('catalog/seria');
	}

	protected function closet()
    {
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();

            $categoriesConfig = new \modules\catalog\categories\CatalogCategoryConfig();
            $category = $this->getCategoryById($categoriesConfig::SHKAFI_DLYA_SPALNI_CATEGORY_ID);
            $this->setLevel('Шкафы купе');
            $fabricator = $this->getFabricatorById($this->getMeriFabricatorId());

            $series = $fabricator->getParameters()
                                ->setSubquery('AND `objectId` IN (' . $this->closetSeriesIdsString . ')');

            $this->setContent('series', $series)
                ->setContent('fabricator', $fabricator)
                ->setContent('h1', 'Шкафы купе')
                ->setContent('category', $category)
                ->setMetaFromObject((new Articles())->getObjectByAlias(__FUNCTION__))
                ->includeTemplate('catalog/category');

            $contents = ob_get_contents();
            ob_end_clean();
            \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
        }
        echo $contents;
    }

    protected function gorki()
    {
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();

            $categoriesConfig = new \modules\catalog\categories\CatalogCategoryConfig();
            $category = $this->getCategoryById($categoriesConfig::STENKI_CATEGORY_ID);
            $this->setLevel('Горки');
            $fabricator = $this->getFabricatorById($this->getMeriFabricatorId());

            $series = $this->getSeriesByCategoryAndFabricator($category, $fabricator);

            if( isset($this->excludeIncludeSeriesRules['gorki']) )
                $series->setSubquery( $this->excludeIncludeSeriesRules['gorki'] );

            $this->setContent('series', $series)
                ->setContent('fabricator', $fabricator)
                ->setContent('h1', 'Горки')
                ->setContent('category', $category)
                ->setMetaFromObject((new Articles())->getObjectByAlias(__FUNCTION__))
                ->includeTemplate('catalog/category');

            $contents = ob_get_contents();
            ob_end_clean();
            \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
        }
        echo $contents;
    }
}