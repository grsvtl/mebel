<?php
namespace controllers\front\catalog;
class UgMebelCatalogFrontController extends \controllers\front\catalog\CatalogFrontController
{
	const QUANTITY_OF_OTHER_GOODS_OF_SERIA_AND_CATEGORY = 3;

	protected $permissibleActions = array(
        'getMinPriceByObjects',
        'getUgFabricatorId',
        'getMainCategoriesWhichHasChildren',
        'getObjectsByCategorySortPriority',
        'getSeriesByCategoryAndFabricator',
        'getCategoriesByFabricatorId',
        'getItemsByFabricatorId'
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
                if($this->checkSeriaCategoryPath($seria, $category, $this->getUgFabricatorId()))
                    return $this->viewSeria($seria, $category);
        }

		$this->sendRequestToArticlesController();
	}

//	protected function checkObjectPath($object)
//	{
//		return rtrim($object->getPath(), '/') == rtrim(str_replace('?'.$this->getSERVER()['REDIRECT_QUERY_STRING'], '', $this->getSERVER()['REQUEST_URI']), '/');
//	}
//
//    protected function checkSeriaCategoryPath($seria, $category, $fabricatorId = null)
//    {
//        if(!in_array($this->getUriLength(), array(2,3))) return false;
//        $objects = $this->getActiveObjectsBySeriaAndCategory($seria, $category);
//        if(!$objects->count()) return false;
//        return $objects->current()->getCategory()->getParent()->alias == $category->alias
//                ||
//                $objects->current()->getCategory()->alias == $category->alias;
//    }

	protected function index()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$article = $this->getObject('\modules\articles\lib\Articles')->getObjectByAlias('index_ug');
			$this
                ->setMetaFromObject($article)
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
		$defaultMetaArticle = (new \modules\articles\lib\Articles())->getObjectByAlias($articleConfig::DEFAULT_META_UG_ARTICLE_ALIAS);

		if(get_class( $object ) == 'modules\parameters\components\parametersValues\lib\ParameterValue')
			$seriaMetaArticle = (new \modules\articles\lib\Articles())->getObjectByAlias($object->getAlias());

		$articleConfig = new \modules\articles\lib\ArticleConfig();
		$object = (!empty($seriaMetaArticle)   &&   $seriaMetaArticle->categoryId == $articleConfig::META_UG_CATEGORY_ID)
						?
					$seriaMetaArticle
						:
					$object;

		return $this->setTitle(empty($object->getMetaTitle()) ? $defaultMetaArticle->getMetaTitle() : $object->getMetaTitle())
					->setDescription(empty($object->getMetaDescription()) ? $defaultMetaArticle->getMetaDescription() : $object->getMetaDescription())
					->setKeywords(empty($object->getMetaKeywords()) ? $defaultMetaArticle->getMetaKeywords() : $object->getMetaKeywords());
	}

	protected function getUgFabricatorId()
	{
		return $this->getFabricatorsConfig()->getUgFabricatorId();
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
            $fabricator = $this->getFabricatorById($this->getUgFabricatorId());
            $series = $this->getSeriesByCategoryAndFabricator($category, $fabricator);

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
			$objects = $this->getActiveObjectsBySeriaAndCategory($seria, $category, $this->getUgFabricatorId());

            $sorting = $this->getSorting($category);

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

    protected function getObjectsByCategorySortPriority($category, $limit = null)
    {
        $objects = $this->getObjectsByCategory($category, $this->getUgFabricatorId())
                        ->setOrderBy('`priority` ASC');
        if(isset($limit))
            $objects->setLimit($limit);
        return $objects;

    }
}