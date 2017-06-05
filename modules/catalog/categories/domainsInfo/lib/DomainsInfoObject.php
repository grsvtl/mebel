<?php
namespace modules\catalog\categories\domainsInfo\lib;
class DomainsInfoObject extends \core\modules\base\ModuleObjects
{
	use \core\traits\ObjectPool;

	protected $configClass = '\modules\catalog\categories\domainsInfo\lib\DomainInfoConfig';
//	private $parentObject;

	function __construct($object)
	{
		parent::__construct(new $this->configClass());
//		$this->setParentObject($object)->setGoodFilters();
	}

//	private function setParentObject($object)
//	{
//		if (is_object($object)) {
//			$this->parentObject = $object;
//			return $this;
//		}
//		throw new \Exception('Category object must be passed in '.get_class($this).'::__constructor()!');
//	}

//	private function setGoodFilters()
//	{
//		$filtes = new \core\FilterGenerator();
//		$filtes->setSubquery('`objectId` = ?d', $this->parentObject->id);
//		return parent::setFilters($filtes);
//	}
//
//	public function setFilters($filterGenerator)
//	{
//		throw new \Exception('Filters are automatically assigned in '.  get_class($this).'!');
//	}
//
//	public function getDomainInfoByDomainAlias($domainAlias)
//	{
//		$id = $this->getFieldWhereCriteria($this->idField,$domainAlias,'domainAlias',$this->parentObject->id,'objectId');
//		return empty($id) ? $this->getNoop() : $this->getObjectById($id);
//	}
//
//	public function getDomainInfoByObjectId($objectId)
//	{
//		$id = $this->getFieldWhereCriteria($this->idField,$objectId,'objectId',$this->parentObject->id,'objectId');
//		return empty($id) ? $this->getNoop() : $this->getObjectById($id);
//	}
}