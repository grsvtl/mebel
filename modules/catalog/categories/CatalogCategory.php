<?php
namespace modules\catalog\categories;
class CatalogCategory extends \core\modules\base\ModuleDecorator implements \interfaces\IObjectToFrontend
{
	use \core\traits\objects\SiteMapPriority,
		\core\traits\RequestHandler;

	function __construct($objectId, $configObject)
	{
		$object = new CatalogCategoryObject($objectId, $configObject);
		$object = new \core\modules\base\ParentDecorator($object, $configObject);
		$object = new \modules\parameters\lib\ParametersRelationDecorator($object);
		$object = new \modules\catalog\categories\domainsInfo\lib\DomainsInfoDecorator($object);
		$object = new \core\modules\statuses\StatusDecorator($object);
		parent::__construct($object);
	}

	public function getParametersCategory ()
	{
		$parameters = new \modules\parameters\lib\Parameters();
		return (int)$this->parametersCategoryId
			? $parameters->getCategories()->getObjectById((int)$this->parametersCategoryId)
			: $this->getNoop();
	}

	public function edit($post, $fields=array())
	{
		return ($this->getParametersRelation()->edit($post->parameters)) ? $this->getParentObject()->edit($post, $fields) : false;
	}

	/* Start: Meta Methods */
	public function getMetaTitle()
	{
		$domainInfo = $this->getDomainInfo($this);
		return $this->isFilled($domainInfo->getMetaTitle()) ? $domainInfo->getMetaTitle() : $this->metaTitle;
	}

	public function getMetaDescription()
	{
		$domainInfo = $this->getDomainInfo($this);
		return $this->isFilled($domainInfo->getMetaDescription()) ? $domainInfo->getMetaDescription() : $this->metaDescription;
	}

	public function getMetaKeywords()
	{
		$domainInfo = $this->getDomainInfo($this);
		return $this->isFilled($domainInfo->getMetaKeywords()) ? $domainInfo->getMetaKeywords() : $this->metaKeywords;
	}
	public function getHeaderText()
	{
		$domainInfo = $this->getDomainInfo($this);
		return $this->isFilled($domainInfo->headerText()) ? $domainInfo->headerText() : $this->headerText;
	}
	/*   End: Meta Methods */

	/* Start: Main Data Methods */
	public function getName()
	{
		$domainInfo = $this->getDomainInfo($this);
		return $this->isFilled($domainInfo->getName()) ? $domainInfo->getName() : $this->name;
	}
	/*   End: Main Data Methods */

	/* Start: URL Methods */
	public function getPath()
	{
		$categoryRules = new \core\modules\categories\CategoriesAliasesRules;
		$res = $categoryRules->useRules($this->getParentObject()->getPath());

		$domainInfo = $this->getDomainInfo($this);
		if(!$this->isNoop($domainInfo))
			$res = str_replace('/'.$this->alias.'/', '/'.$domainInfo->alias.'/', $res);

		return $this->changePathByParentsAndDomain($res, $this);
	}
	/*   End: URL Methods */

	private function getDomainInfo($object)
	{
		return (new \modules\catalog\categories\domainsInfo\lib\DomainsInfo($object))->getDomainInfoByObjectIdAndDomainAlias($object->id, $this->getCurrentDomainAlias());
	}

	private function changePathByParentsAndDomain($path, $object)
	{
		if(!$this->isNoop($object->getParent())){
			$domainInfo = $this->getDomainInfo($object->getParent());
			if(!$this->isNoop($domainInfo))
				$path = str_replace('/'.$object->getParent()->alias.'/', '/'.$domainInfo->alias.'/', $path);
			$this->changePathByParentsAndDomain($path, $object->getParent());
		}
		return $path;
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
		return 'daily';
	}
	/*   End: Sitemap Methods */

	public function getDescription()
	{
		$domainInfo = $this->getDomainInfo($this);
		return $this->isFilled($domainInfo->getDescription()) ? $domainInfo->getDescription() : $this->description;
	}

	private function isFilled($objectProperty)
	{
		return !empty($objectProperty) && $this->isNotNoop($objectProperty);
	}

	public function getText()
	{
		$domainInfo = $this->getDomainInfo($this);
		return $this->isFilled($domainInfo->getText()) ? $domainInfo->getText() : $this->text;
	}

	public function getH1()
	{
		$domainInfo = $this->getDomainInfo($this);
		return $this->isFilled($domainInfo->getH1()) ? $domainInfo->getH1() : $this->h1;
	}

	public function isMain()
	{
		return $this->parentId == 0;
	}

	public function getSorting(){return $this->sorting;}
    public function getSortingKey(){return $this->sortingKey;}
}