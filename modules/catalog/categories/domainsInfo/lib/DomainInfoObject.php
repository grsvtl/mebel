<?php
namespace modules\catalog\categories\domainsInfo\lib;
class DomainInfoObject extends \core\modules\base\ModuleObject
{
	protected $configClass = '\modules\catalog\categories\domainsInfo\lib\DomainInfoConfig';

	function __construct($objectId)
	{
		parent::__construct($objectId, new $this->configClass);
	}
}