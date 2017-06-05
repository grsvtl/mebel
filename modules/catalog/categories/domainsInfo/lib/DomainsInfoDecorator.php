<?php
namespace modules\catalog\categories\domainsInfo\lib;
class DomainsInfoDecorator extends \core\modules\base\ModuleDecorator
{
	use \core\traits\RequestHandler;

	private $domainsInfo;

	function __construct($object)
	{
		parent::__construct($object);
	}

	function getDomainsInfo()
	{
		if (empty($this->domainsInfo))
			$this->domainsInfo = new DomainsInfo($this->getParentObject());
		return $this->domainsInfo;
	}

	function getDomainInfoByDomainAlias($domainAlias)
	{
		return $this->getDomainsInfo()->getDomainInfoByObjectIdAndDomainAlias($this->id, $domainAlias);
	}
}