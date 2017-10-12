<?php
namespace controllers\admin;
use modules\catalog\catalog\lib\Catalog;
use modules\catalog\catalog\lib\CatalogItem;
use modules\catalog\catalog\lib\CatalogItemConfig;
use modules\catalog\priority\CatalogPriorityGenerator;
use modules\catalog\priority\lib\CatalogPriorityConfig;
use modules\fabricators\lib\Fabricator;
use modules\modulesDomain\components\domains\lib\Domains;

class CatalogPriorityAdminController extends \controllers\base\Controller
{
	use	\core\traits\controllers\Rights,
		\core\traits\controllers\Templates,
		\core\traits\controllers\Authorization;

	protected $permissibleActions = array(
	    'catalog',
		'setPriority',
		'setGroupPriority'
	);

	protected $domainFabricators = array(
	    'dana-mebel.net'     => 12,
	    'meri-mebel.ru'      => 32,
	    'fabrika-ugmebel.ru' => 31,
	    'fabrikalerom.ru'    => 38,
    );

	public function  __construct()
	{
		parent::__construct();
		$this->_config = new CatalogPriorityConfig();
	}

	protected function catalog()
    {
        ini_set('memory_limit', '512M');

        $categoryObject = null;
        $category       = (empty($this->getGET()['categoryId']))
                            ? null
                            : \core\utils\DataAdapt::textValid($this->getGET()['categoryId']);
        $seria          = (empty($this->getGET()['seriaId']))
                            ? null
                            : \core\utils\DataAdapt::textValid($this->getGET()['seriaId']);
        $domainAlias    = $this->getGET()['domainAlias']
                            ? $this->getGET()['domainAlias']
                            : $this->getCurrentDomainAlias();

        if (!empty($category)){
            $categoryObject = new \core\modules\categories\Category($category, new CatalogItemConfig());
            if ( isset($this->domainFabricators[$domainAlias]) ) {
                $fabricator = new Fabricator($this->domainFabricators[$domainAlias]);
                $series     = $this->getSeriesByCategoryAndFabricator($categoryObject, $fabricator);
                $this->setContent('series', $series);
            }
        }

        $this->setContent('domains', new Domains())
             ->setContent('domainAlias', $domainAlias)
             ->setContent('category', $categoryObject)
             ->setContent('seria', $seria)
             ->setContent('objects', new Catalog())
             ->includeTemplate($this->_config->getAdminTemplateDir().'catalog');
    }

    protected function renderItems($domainAlias, $category, $seria)
    {
        $catalog        = new Catalog();

        if( $category->getChildrenIdString() ) {
            $catalog->setSubquery(' AND (`categoryId`=?d OR `categoryId` IN (?s)) ', $category->id, $category->getChildrenIdString());
        } else {
            $catalog->setSubquery('AND `categoryId` = ?d', $category->id);
        }
        $catalog->setSubquery('AND `seriaId` = ?d', $seria);

        if ( isset($this->domainFabricators[$domainAlias]) )
            $catalog->setSubquery('AND `fabricatorId` = ?d', $this->domainFabricators[$domainAlias]);

        $catalog->orderByDomainAlias($domainAlias, $category->id);

        $this->setContent('objects', $catalog)
             ->setContent('domainAlias', $domainAlias)
             ->setContent('category', $category)
             ->setContent('seria', $seria)
             ->includeTemplate($this->_config->getAdminTemplateDir().'list');
    }

    protected function renderMebelMebelItems($domainAlias, $category)
    {
        $catalog        = new Catalog();

        if( $category->getChildrenIdString() ) {
            $catalog->setSubquery(' AND (`categoryId`=?d OR `categoryId` IN (?s)) ', $category->id, $category->getChildrenIdString());
        } else {
            $catalog->setSubquery('AND `categoryId` = ?d', $category->id);
        }

        $catalog->orderByDomainAlias($domainAlias, $category->id);

        $this->setContent('objects', $catalog)
             ->setContent('domainAlias', $domainAlias)
             ->setContent('category', $category)
             ->includeTemplate($this->_config->getAdminTemplateDir().'list');
    }


    protected function setPriority()
    {
        $good        = new CatalogItem($this->getGET()['goodId']);
        $domainAlias = $this->getGET()['domainAlias'];
        $categoryId  = $this->getGET()['categoryId'];
        $priority    = $this->getGET()['priority'];
        $generator   = new CatalogPriorityGenerator($good, $domainAlias, $categoryId, $priority);

        $this->ajaxResponse( $generator->execute() );
    }

    protected function setGroupPriority()
    {
        $domainAlias = $this->getGET()['domainAlias'];
        $categoryId  = $this->getGET()['categoryId'];

        if ( $this->getGET()['data'] ) {
            foreach ( $this->getGET()['data'] as $objectId=>$priority ) {
                $generator = new CatalogPriorityGenerator(new CatalogItem($objectId), $domainAlias, $categoryId, $priority);
                if ( $generator->execute() === false ) {
                    $this->ajaxResponse(false);
                    return;
                }
            }
        } else {
            $this->ajaxResponse(false);
            return;
        }
        $this->ajaxResponse( true );
    }

    protected function getSeriesByCategoryAndFabricator($category, $fabricator)
    {
        if(!$fabricator->getParameters()->count()) return false;
        $catalog = new CatalogItemConfig();

        return $fabricator->getParameters()
                        ->setSubquery(
                            'AND `objectId` IN ('
                            . 'SELECT `seriaId` FROM `'.$catalog->mainTable().'` WHERE `categoryId` IN ('
                            . 'SELECT `id` FROM `'.$catalog->mainTable().'_categories` WHERE (`parentId` = '.$category->id.' OR `id` = '.$category->id.'))
                            )'
                        );
    }
}