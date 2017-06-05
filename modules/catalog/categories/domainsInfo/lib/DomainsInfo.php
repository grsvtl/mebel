<?php
namespace modules\catalog\categories\domainsInfo\lib;
class DomainsInfo extends \core\modules\base\ModuleDecorator
{
	function __construct($object)
	{
		$object = new DomainsInfoObject($object);
		parent::__construct($object);
	}

	public function getDomainInfoByAliasAndDomainAlias($alias, $domainAlias)
	{
		$id = $this->getFieldWhereCriteria('id', $alias,'alias', $domainAlias,'domainAlias');
		return empty($id) ? $this->getNoop() : $this->getObjectById($id);
	}

	public function getDomainInfoByObjectIdAndDomainAlias($objectId, $domainAlias)
	{
		$id = $this->getFieldWhereCriteria('id', $objectId,'objectId', $domainAlias,'domainAlias');
		return empty($id) ? $this->getNoop() : $this->getObjectById($id);
	}
}