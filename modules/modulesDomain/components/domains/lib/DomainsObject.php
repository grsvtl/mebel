<?php
namespace modules\modulesDomain\components\domains\lib;
class DomainsObject extends \core\modules\base\ModuleObjects
{
	protected $configClass     = '\modules\modulesDomain\components\domains\lib\DomainConfig';
	protected $objectClassName = '\modules\modulesDomain\components\domains\lib\Domain';

	function __construct()
	{
		parent::__construct(new $this->configClass);
	}
}
