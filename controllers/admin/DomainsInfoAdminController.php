<?php
namespace controllers\admin;
use core\traits\controllers\ControllersHandler;

class DomainsInfoAdminController extends \controllers\base\Controller
{
	use	\core\traits\controllers\Templates,
		\core\traits\controllers\Images,
        ControllersHandler;

	protected $permissibleActions = array(
		'ajaxGetDomainBlock',
		'getMainBlockContent',
		'editDomainInfo',

		'ajaxGetCategoryDomainBlock',

		/* Start: Images Trait Methods*/
		'uploadImage',
		'addImagesFromEditPage',
		'removeImage',
		'setPrimary',
		'resetPrimary',
		'setBlock',
		'resetBlock',
		'editImage',
		'getTemplateToEditImage',
		/*   End: Images Trait Methods*/
	);

	public function  __construct()
	{
		parent::__construct();
		$this->_config = new \modules\catalog\domainsInfo\lib\DomainInfoConfig();
		$this->objectClass = $this->_config->getObjectClass();
		$this->objectsClass = $this->_config->getObjectsClass();
	}

	protected function defaultAction()
	{
		return $this->redirect404();
	}

	protected function ajaxGetDomainBlock()
	{
		return ($this->getREQUEST()['domainAlias'] == 'main')
			? $this->getMainBlockContent($this->getPOST()['objectId'])
			: $this->getDomainBlockContent($this->getPOST()['objectId'], $this->getREQUEST()['domainAlias']);
	}

	protected function getDomainBlockContent($catalogId, $domainAlias)
	{
		if (isset($catalogId)) {
			$good = \modules\catalog\CatalogFactory::getInstance()->getGoodById($catalogId);
			$object = $good->getDomainInfoByDomainAlias($domainAlias);
		}

		$objects = $good->getDomainsInfo();

		$tabs = array('editConstruction' => 'Общая информация');

		$this->setContent('object', $object)
			 ->setContent('objects', $objects)
			 ->setContent('good', $good)
			 ->setContent('domainAlias', $domainAlias)
			 ->setContent('tabs', $tabs)
			 ->includeTemplate($objects->getConfig()->getAdminTemplateDir().'content');
	}


	protected function editDomainInfo()
	{
		$good = \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->getPOST()['id']);
		$domainInfo = $good->getDomainInfoByDomainAlias($this->getPOST()['domainAlias']);
		return ($this->isNoop($domainInfo))
			? $this->addDomainInfoAction($good, $this->getPOST()['domainAlias'], $this->getPOST())
			: $this->editDomainInfoAction($good, $this->getPOST()['domainAlias'], $this->getPOST());
	}

	protected function addDomainInfoAction($good, $domainAlias, $data)
	{
		$data['objectId']   = $good->id;
		$data['domainAlias'] = $domainAlias;
		unset($data['id']);
		return $this->setObject($good->getDomainsInfo())
					->ajax($this->modelObject->add($data));
	}

	protected function editDomainInfoAction($good, $domainAlias, $data)
	{
		$data['objectId'] = $good->id;
		return $this->setObject($good->getDomainInfoByDomainAlias($domainAlias))
					->ajax($this->modelObject->edit($data));
	}

	protected function getImagesBlock()
	{
	    $object = new \core\Noop();
	    if (isset($this->getPOST()['objectId'])) {
			$good = \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->getPOST()['objectId']);
		    $object = $good->getDomainInfoByDomainAlias($this->getPOST()['domainAlias']);;
	    }

	    $objects = $good->getDomainsInfo();
	    $this->setContent('object', $object) // Need for images template
		     ->setContent('objects', $objects) // Need for images template
		     ->includeTemplate('newImagesForm');
	}

	protected function ajaxGetCategoryDomainBlock()
	{
		return $this->getDomainCategoryBlockContent($this->getPOST()['objectId'], $this->getREQUEST()['domainAlias']);
	}

	private function getDomainCategoryBlockContent($categoryId, $domainAlias)
	{
		if (isset($categoryId)) {
			$category = new \modules\catalog\categories\CatalogCategory($categoryId, new \modules\catalog\catalog\lib\CatalogItemConfig);
			$object = $category->getDomainInfoByDomainAlias($domainAlias);
		}

		$objects = $category->getDomainsInfo();

		$tabs = array('editConstruction' => 'Общая информация');

		$this->setContent('object', $object)
			 ->setContent('objects', $objects)
			 ->setContent('category', $category)
			 ->setContent('domainAlias', $domainAlias)
			 ->setContent('tabs', $tabs)
			 ->includeTemplate($objects->getConfig()->getAdminTemplateDir().'content');
	}

	public function editDomainCategoryInfo()
	{
		$category = new \modules\catalog\categories\CatalogCategory($this->getPOST()['id'], new \modules\catalog\catalog\lib\CatalogItemConfig);
		$domainInfo = $category->getDomainInfoByDomainAlias($this->getPOST()['domainAlias']);
		return ($this->isNoop($domainInfo))
			? $this->addDomainCategoryInfoAction($category, $this->getPOST()['domainAlias'], $this->getPOST())
			: $this->editDomainCategoryInfoAction($category, $this->getPOST()['domainAlias'], $this->getPOST());
	}

	private function addDomainCategoryInfoAction($category, $domainAlias, $data)
	{
		$data['objectId']   = $category->id;
		$data['domainAlias'] = $domainAlias;
		unset($data['id']);
		return $this->setObject($category->getDomainsInfo())
					->ajax($this->modelObject->add($data));
	}

	private function editDomainCategoryInfoAction($category, $domainAlias, $data)
	{
		$data['objectId'] = $category->id;
		return $this->setObject($category->getDomainInfoByDomainAlias($domainAlias))
					->ajax($this->modelObject->edit($data));
	}
}