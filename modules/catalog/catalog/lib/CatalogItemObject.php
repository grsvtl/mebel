<?php
namespace modules\catalog\catalog\lib;
class CatalogItemObject extends \modules\catalog\CatalogGoodObject
{
	protected $configClass = '\modules\catalog\catalog\lib\CatalogItemConfig';

	function __construct($objectId)
	{
		parent::__construct($objectId, new $this->configClass);
	}
}