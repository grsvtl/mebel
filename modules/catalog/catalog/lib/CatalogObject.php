<?php
namespace modules\catalog\catalog\lib;
class CatalogObject extends \modules\catalog\CatalogRegistrator
{
	use \modules\catalog\traits\CatalogWordsSearch;
	protected $configClass = '\modules\catalog\catalog\lib\CatalogItemConfig';

	function __construct()
	{
		parent::__construct(new $this->configClass);
	}
}
