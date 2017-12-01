<?php
namespace controllers\front\catalog;
use core\traits\controllers\RequestLevels;
use modules\catalog\catalog\lib\CatalogItemConfig;
use modules\catalog\CatalogFactory;
use modules\catalog\searchParameters\lib\SearchParameterConfig;
use modules\catalog\searchParameters\lib\SearchParameters;

class LeromMebelCatalogFrontController extends \controllers\front\catalog\CatalogFrontController
{
    use RequestLevels;

    const SECOND_SERIA_PARAMETER_ID = 67;
    const LOAD_MORE_GOODS_QUANTITY = 9;
    const QUANTITY_OBJECTS_ON_FIRST_LOAD = 12;

    protected $permissibleActions = [
        'getLeftMenu',
        'getQuantityByCategoryAlias',
        'getTopSalesProducts',
        'getCatalogListContentItemBlock',
        'ajaxGetCatalogListModalContentItemBlock',
        'ajaxFetchMoreGoods',
        'ajaxCheckMoreGoodsAvailable',
        'search',
        'test',
        'getSeriesByCategory'
    ];

    protected $compositionsCategories = [
        'modulnyie_gostinyie' => 119,
        'modulnyie_detskie'   => 124,
        'modulnyie_spalni'    => 122,
        'podtovaryi_dlya_prihojey' => 112,

        'gostinnye' => 108,
        'detskie'   => 107,
        'spalni'    => 104,
        'prihojii'  => 110,
    ];

    protected $mainCompositionsCategoriesToSubcategories = [
        'gostinnye' => 'modulnyie_gostinyie',
        'detskie'   => 'modulnyie_detskie',
        'spalni'    => 'modulnyie_spalni',
        'prihojii'  => 'podtovaryi_dlya_prihojey',
    ];

    const LEFT_MENU_CATEGORIES_IMG_PATH = '/images/fabrikaLerom/leftMenuCategories/';

    private $leftMenuCategoriesMapping = array(
        '108' => array('img' => 'decorating.svg', 'name' => 'Для гостиной', 'showSeries' => true),
        '104' => array('img' => 'bed.svg', 'name' => 'Для спальни', 'showSeries' => true),
        '110' => array('img' => 'furniture.svg', 'name' => 'Для прихожей', 'showSeries' => true),
        '107' => array('img' => 'frontal-teddy-bear.svg', 'name' => 'Для детской', 'showSeries' => true),
        '217' => array('img' => 'wardrobe.svg', 'name' => 'Шкафы купе', 'showSeries' => false),
        '170' => array('img' => 'matrass.svg', 'name' => 'Матрасы', 'showSeries' => true)
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
        else{
            $seria = $this->getParameterValuesObject()->getObjectByAlias($this->getLastElementFromRequest());
            $category = $this->getCatalogObject()->getCategories()->getObjectByAlias($this->getElementFromTheEndOfRequest(2));
            if($seria  &&  $category)
                if($this->checkSeriaCategoryPath($seria, $category, $this->getLeromFabricatorId()))
                    return $this->viewSeria($seria, $category);
        }

        $this->sendRequestToArticlesController();
    }

    protected function getLeromFabricatorId()
    {
        return $this->getFabricatorsConfig()->getLeromFabricatorId();
    }

    protected function index()
    {
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();
            $article = $this->getObject('\modules\articles\lib\Articles')->getObjectByAlias('index_lerom');
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

            if (get_class($object) == 'modules\parameters\components\parametersValues\lib\ParameterValue')
                $seriaMetaArticle = (new \modules\articles\lib\Articles())->getObjectByAlias($object->getAlias());

            $articleConfig = new \modules\articles\lib\ArticleConfig();
            $object = (!empty($seriaMetaArticle) && $seriaMetaArticle->categoryId == $articleConfig::META_UG_CATEGORY_ID)
                ?
                $seriaMetaArticle
                :
                $object;

            return $this->setTitle(empty($object->getMetaTitle()) ? $defaultMetaArticle->getMetaTitle() : $object->getMetaTitle())
                ->setDescription(empty($object->getMetaDescription()) ? $defaultMetaArticle->getMetaDescription() : $object->getMetaDescription())
                ->setKeywords(empty($object->getMetaKeywords()) ? $defaultMetaArticle->getMetaKeywords() : $object->getMetaKeywords());
    }

    protected function isCategoryCompositional($category)
    {
        return in_array($category, array_keys($this->compositionsCategories));
    }

    protected function search()
    {
        if(empty($this->getGET()['query'])) return header('Location: /');

        $objects = $this->getActiveObjects();

        if(!empty($this->getGET()['query'])){
            $objects = $this->filterObjectsByQuery($objects, $this->getGET()['query']);
        }

        $objects->setLimit(self::QUANTITY_OBJECTS_ON_FIRST_LOAD);

        $this->setTitle('Поиск')
            ->setDescription('Поиск')
            ->setKeywords('Поиск')
            ->setLevel('Поиск')
            ->setContent('h1', 'Результаты поиска: ' . $this->getGet()['query'])
            ->setContent('objects', $objects)
            ->setContent('level', 'search')
            ->setContent('query', $this->getGET()['query'])
            ->setContent('activeSearchParameters', $this->getActiveSearchParameters())
            ->setContent('isParameterSearchActive', $this->isFilteringCategory())
            ->includeTemplate('catalog/search');
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
            $fabricator = $this->getFabricator();

            if ($this->isCategoryCompositional($alias)) {
                if ($category->isMain()) {
                    $subCategoryAlias = $this->mainCompositionsCategoriesToSubcategories[$alias];
                    $subCategory = $this->getCatalogObject()->getCategories()->getObjectByAlias($subCategoryAlias);
                    $mainObjects = $this->getObjectsByCategory($subCategory, $fabricator->id);
                    $restObjects = $this->getObjectsExceptCategory($subCategory, $category->id, $fabricator->id);
                } else {
                    $mainObjects = $this->getObjectsByCategory($category, $fabricator->id);
                }
            } else
                $mainObjects = $this->getObjectsByCategory($category, $fabricator->id);

            if ($this->isFilteringCategory())
                $this->filterByUserSelection($mainObjects);

            if (isset($restObjects)) {
                if ($this->isFilteringCategory())
                    $this->filterByUserSelection($restObjects);
                $restObjects->setLimit(self::QUANTITY_OBJECTS_ON_FIRST_LOAD);
                $this->setContent('restObjects', $restObjects);
            }

            $mainObjects->setLimit(self::QUANTITY_OBJECTS_ON_FIRST_LOAD);

            $this->setContent('mainObjects', $mainObjects)
                ->setContent('activeSearchParameters', $this->getActiveSearchParameters())
                ->setContent('isParameterSearchActive', $this->isFilteringCategory())
                ->setContent('hasModules', isset($restObjects))
                ->setContent('fabricator', $fabricator)
                ->setContent('h1', $category->getName())
                ->setContent('category', $category)
                ->setContent('isMainCategory', $category->isMain())
                ->setContent('level', 'category')
                ->setMetaFromObject($category)
                ->includeTemplate('catalog/catalogList');

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

            $sizesAndWeight = $this->getObjectPropertiesListByAlias('sizesAndWeight', $good);

            $this->setLevels($good)
                ->setMetaFromObject($good)
                ->setContent('object', $good)
                ->setContent('category', $good->getCategory())
                ->setContent('sizesAndWeight', $sizesAndWeight)
                ->setContent('hasOtherProperties', (count($sizesAndWeight) > 3 ) )
                ->setContent('dimensions', $this->getObjectPropertiesListByAlias('sizesAndWeight', $good, 3))
                ->setContent('materialArray', $this->getParameterArrayByIdAndGood($this->_config->getMaterialParametersId(), $good))
                ->setContent('corpusArray', $this->getParameterArrayByIdAndGood($this->_config->getCorpusParametersId(), $good))
                ->setContent('fasadArray', $this->getParameterArrayByIdAndGood($this->_config->getFasadParametersId(), $good))
                //->setContent('otherGoodsOfSeriaAndCategory', $this->getOtherGoodsOfSeriaAndCategory($good, self::QUANTITY_OF_OTHER_GOODS_OF_SERIA_AND_CATEGORY))
                ->includeTemplate('catalog/catalogObject');

            $contents = ob_get_contents();
            ob_end_clean();
            \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
        }
        echo $contents;
    }

    private function filterObjectsByQuery($objects, $query)
    {
        $_query = \core\utils\DataAdapt::textValid($query);
        $objects->setSubquery('AND `fabricatorId` = ?d', $this->getLeromFabricatorId())
            ->setSubquery('AND `id` IN ('
                . 'SELECT `id`  FROM `'.\modules\catalog\CatalogFactory::getInstance()->mainTable().'` '
                . 'WHERE LOWER(`name`) LIKE \'%?s%\')', strtolower($_query));
        return $objects;
    }

    private function getActiveSearchParameters()
    {
        $searchParameters = new SearchParameters();
        return $searchParameters->setSubquery('AND `statusId` = ?d', SearchParameterConfig::ACTIVE_STATUS_ID);
    }

    private function isFilteringCategory()
    {
        return isset($_GET['searchParameterActive']) && $_GET['searchParameterActive'] == 1 && count($_GET) > 1;
    }

    private function filterByUserSelection($objects)
    {
        $get = $this->getGET()->getArray();
        unset($get['searchParameterActive']);

        $userParameters = [];
        foreach ($get as $param => $value) {
            $id = $this->parseUserSearchParameterValue($param);
            $userParameters[] = $id;
        }

        $objects->setSubquery('AND `id` IN (SELECT `ownerId` FROM `tbl_catalog_catalog_parameters_values_relation` WHERE `objectId` IN (' . implode(',', $userParameters) . '))');
    }

    private function parseUserSearchParameterValue($name)
    {
        return str_replace('param_', '', $name);
    }

    protected function getLeftMenu()
    {
//        var_dump($this->getLeftMenuCategoriesObject());
//
//
//        die();


        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();
            $this
//                ->setContent('leftMenuCategories', $this->getMainCategoriesWhichHasChildren($this->getLeromFabricatorId()))
                ->setContent('leftMenuCategories', $this->getLeftMenuCategoriesObject())
                ->includeTemplate('catalog/leftMenu');
            $contents = ob_get_contents();
            ob_end_clean();
            \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
        }
        echo $contents;
    }

    private function getLeftMenuCategoriesObject()
    {
        $categories = array();
        foreach ($this->leftMenuCategoriesMapping as $key=>$value) {
            if($this->getActiveCategories()->objectExists($key)){
                $category = $this->getCategoryById((int)$key);
                $category->leftMenuImg = self::LEFT_MENU_CATEGORIES_IMG_PATH.$value['img'];
                $category->leftMenuName = $value['name'];
                $category->showSeries = $value['showSeries'];
                $categories[] = $category;
            }
        }
        return (object)$categories;
    }

    public function getObjectPropertiesListByAlias($alias, $object, $limit = null)
    {
        $array = array();
        $i = 1;
        foreach( $this->getPropertiesListByAlias($alias) as $item )
            if($object->getPropertyValueById($item->id)->value){
                $temp = array();
                $temp['name'] = $object->getPropertyValueById($item->id)->value;
                $temp['value'] = $item->getValue();
                $temp['id'] = $item->id;
                $temp['measure'] = $object->getPropertyValueById($item->id)->getMeasure()->shortName;
                $array[] = $temp;
                if(isset($limit)  &&  $limit==$i)
                    return empty($array) ? false : $array;
                $i++;
            }
        return empty($array) ? false : $array;
    }

    private function getParametersToParametersBlock()
    {
        $parameters = $this->getObject('\modules\parameters\lib\Parameters')
            ->getParametersByCategoryAlias('catalogadmincontroller')
            ->setSubquery('AND `id` != (?d)', self::SECOND_SERIA_PARAMETER_ID)
            ->setOrderBy('`priority` ASC');
        return $parameters;
    }

    protected function mb_ucfirst($string, $encoding = 'UTF-8')
    {
        $strlen = mb_strlen($string, $encoding);
        $firstChar = mb_substr($string, 0, 1, $encoding);
        $then = mb_substr($string, 1, $strlen - 1, $encoding);
        return mb_strtoupper($firstChar, $encoding) . $then;
    }

//    protected function getMainCategories()
//    {
//        return $this->getCategoriesTreeByFabricatorId($this->getLeromFabricatorId());
//    }

    protected function getCategoryByAlias($categoryAlias)
    {
        return $this->getCatalogObject()->getCategories()->getObjectByAlias($categoryAlias);
    }

    protected function getQuantityByCategoryAlias($alias)
    {
        $category = $this->getCatalogObject()->getCategories()->getObjectByAlias($alias);
        if(!$category)
            return false;
        $catalog = $this->getObjectsByCategory($category, $this->getLeromFabricatorId());
        return $catalog->count() ? $catalog->count() : false;
    }

    protected function getTopSalesProducts()
    {
        $objects = $this->getActiveObjects();
        $objects->setSubquery('AND `statusId` = (?d)', (int)CatalogItemConfig::TOP_SELL_ID)
                ->setSubquery('AND `fabricatorId` = (?d)', $this->getLeromFabricatorId())
                ->setLimit(35)
                ->setOrderBy('`priority` ASC');
        return $objects;
    }

    protected function getCatalogListContentItemBlock($object)
    {
        $this->setContent('object', $object)
            ->setContent('sizesAndWeight', $this->getObjectPropertiesListByAlias('sizesAndWeight', $object, 3))
            ->includeTemplate('/catalog/catalogListContentItem');
    }

    protected function ajaxGetCatalogListModalContentItemBlock()
    {
        $post = $this->getPOST();
        if (  (isset($post['objectId']) && !empty($post['objectId']))  ) {
            $object = CatalogFactory::getInstance()->getGoodById($post['objectId']);
            $sizesAndWeight = $this->getObjectPropertiesListByAlias('sizesAndWeight', $object);
        }

        ob_start();
        $this->setContent('object', $object)
            ->setContent('sizesAndWeight', $this->getObjectPropertiesListByAlias('sizesAndWeight', $object, 3))
            ->setContent('hasOtherProperties', (count($sizesAndWeight) > 3))
            ->setContent('dimensions', $this->getObjectPropertiesListByAlias('sizesAndWeight', $object, 3))
            ->setContent('materialArray', $this->getParameterArrayByIdAndGood($this->_config->getMaterialParametersId(), $object))
            ->setContent('corpusArray', $this->getParameterArrayByIdAndGood($this->_config->getCorpusParametersId(), $object))
            ->setContent('fasadArray', $this->getParameterArrayByIdAndGood($this->_config->getFasadParametersId(), $object))
            ->includeTemplate('/catalog/modalCatalogListContentItem');
        $content = ob_get_contents();
        ob_end_clean();

        echo json_encode(['content' => $content]);
    }

    protected function getOtherGoodsByCategory($category, $exceptGood)
    {
        $catalog = $this->getObjectsByCategory($category, $this->getLeromFabricatorId());
        $catalog->setSubquery('AND `id` != ?d', $exceptGood->id)
            ->setLimit(6)
            ->setOrderBy('`priority` ASC');
        return $catalog;
    }

    protected function ajaxFetchMoreGoods()
    {
        $post = $this->getPOST();
        $fabricator = $this->getFabricator();

        if (  (isset($post['loadedGoods']) && !empty($post['loadedGoods']))  ) {
            $loadedGoods = $post['loadedGoods'];
            if (isset($post['level']) && !empty($post['level']) && $post['level'] == 'search') {
                $objects = $this->getActiveObjects();
                $objects = $this->filterObjectsByQuery($objects, $post['query']);
            } else {
                $categoryId = $post['categoryId'];
                $tab = $post['tab'];
                $category = $this->getCatalogObject()->getCategories()->getObjectById($categoryId);

                if ($this->isCategoryCompositional($category->alias)) {
                    $subCategoryAlias = $this->mainCompositionsCategoriesToSubcategories[$category->alias];
                    $subCategory = $this->getCatalogObject()->getCategories()->getObjectByAlias($subCategoryAlias);
                }

                if ($tab == 'composition') {
                    if ($category->isMain())
                        $objects = $this->getObjectsByCategory($subCategory, $fabricator->id);
                    else
                        $objects = $this->getObjectsByCategory($category, $fabricator->id);
                } else {
                    if ($category->isMain())
                        $objects = $this->getObjectsExceptCategory($subCategory, $categoryId, $fabricator->id);
                }
            }

            $objects->setLimit((int)$loadedGoods . ',' . self::LOAD_MORE_GOODS_QUANTITY);
            ob_start();
            $this->getMoreGoodsTemplate($objects);
            $content = ob_get_contents();
            ob_end_clean();

            echo json_encode([
                'count' => $objects->count(),
                'content' => $content
            ]);
        }

    }

    private function getMoreGoodsTemplate($objects)
    {
        $this->setContent('objects', $objects)
            ->includeTemplate('catalog/moreGoods');
    }

    protected function ajaxCheckMoreGoodsAvailable()
    {
        $post = $this->getPOST();
        $fabricator = $this->getFabricator();

        if (  (isset($post['loadedGoods']) && !empty($post['loadedGoods']))  ) {
            $loadedGoods = $post['loadedGoods'];
            if (isset($post['level']) && !empty($post['level']) && $post['level'] == 'search') {
                $objects = $this->getActiveObjects();
                $objects = $this->filterObjectsByQuery($objects, $post['query']);
                $objectsCount = $objects->count();
            } else {
                $categoryId = $post['categoryId'];
                $tab = $post['tab'];
                $category = $this->getCatalogObject()->getCategories()->getObjectById($categoryId);

                if ($this->isCategoryCompositional($category->alias)) {
                    $subCategoryAlias = $this->mainCompositionsCategoriesToSubcategories[$category->alias];
                    $subCategory = $this->getCatalogObject()->getCategories()->getObjectByAlias($subCategoryAlias);
                }

                if ($tab == 'composition') {
                    if ($category->isMain())
                        $objectsCount = $this->getObjectsByCategory($subCategory, $fabricator->id)->count();
                    else
                        $objectsCount = $this->getObjectsByCategory($category, $fabricator->id)->count();
                } else {
                    if ($category->isMain())
                        $objectsCount = $this->getObjectsExceptCategory($subCategory, $categoryId, $fabricator->id)->count();
                }
            }
            $this->ajaxResponse( boolval($objectsCount - $loadedGoods > 0) );
        }
    }

    protected function getSeriesByCategory($category)
    {
        return $this->getSeriesByCategoryAndFabricator($category, $this->getFabricator());
    }

    private function getFabricator()
    {
        return $this->getFabricatorById($this->getLeromFabricatorId());
    }

    private function viewSeria($seria, $category)
    {
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();

            $objects = $this->getActiveObjectsBySeriaAndCategory($seria, $category, $this->getLeromFabricatorId())
                            ->orderByDomainAlias($this->getCurrentDomainAlias(), $category->id)
                            ->setSubquery('AND `id` IN (SELECT DISTINCT `goodId` FROM `tbl_catalog_subgoods`)');
            if ($this->isFilteringCategory())
                $this->filterByUserSelection($objects);
               $objects->setLimit(self::QUANTITY_OBJECTS_ON_FIRST_LOAD)
            ;

            $subGoods = $this->getActiveObjectsBySeriaAndCategory($seria, $category, $this->getLeromFabricatorId())
                            ->orderByDomainAlias($this->getCurrentDomainAlias(), $category->id)
                            ->setSubquery('AND `id` NOT IN (SELECT DISTINCT `goodId` FROM `tbl_catalog_subgoods`)');
            if ($subGoods->count()) {
                if ($this->isFilteringCategory())
                    $this->filterByUserSelection($subGoods);
                $subGoods->setLimit(self::QUANTITY_OBJECTS_ON_FIRST_LOAD);
            }

            if(!$this->isNoop($category->getParent()))
                $this->setLevel($category->getParent()->getName(), $category->getParent()->getPath());

            $this->setLevel($category->getName(), $category->getPath())
                ->setLevel($seria->getValue())
                ->setContent('h1', $seria->getValue())
                ->setContent('seria', $seria)
                ->setContent('objects', $objects)
                ->setContent('subGoods', $subGoods)
                ->setMetaFromObject($seria)

                ->setContent('level', 'category')
                ->setContent('category', $category)
                ->setContent('activeSearchParameters', $this->getActiveSearchParameters())
                ->setContent('isParameterSearchActive', $this->isFilteringCategory())

                ->includeTemplate('catalog/seria');

            $contents = ob_get_contents();
            ob_end_clean();
            \core\cache\Cacher::getInstance()->set($contents, $cacheKey);
        }
        echo $contents;
    }
}