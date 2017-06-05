<?php
namespace modules\catalog\categories;
class CatalogCategories extends \core\modules\base\ModuleDecorator
{
	use	\core\traits\RequestHandler;

	function __construct($configObject)
	{
		$object = new CatalogCategoriesObject($configObject);
		$object = new \core\modules\statuses\StatusesDecorator($object);

		parent::__construct($object);
	}

	public function getObjectByAlias($alias)
	{
		$domainInfo =  (new \modules\catalog\categories\domainsInfo\lib\DomainsInfo($this))->getDomainInfoByAliasAndDomainAlias($alias, $this->getCurrentDomainAlias());
		if(!$this->isNoop($domainInfo))
			return $this->getObjectById($domainInfo->getField('objectId', $domainInfo->id));
		return $this->getParentObject()->getObjectByAlias($alias);
	}
}