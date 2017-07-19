<?php
namespace modules\catalog\prices\lib;
class PriceObject extends \core\modules\base\ModuleObject
{
	protected $configClass = '\modules\catalog\prices\lib\PriceConfig';
	
	function __construct($objectId, $configObject)
	{
		parent::__construct($objectId, new $this->configClass($configObject));
	}
	
	public function getOldPrice()
	{
		$this->loadObjectInfo();
		$price = empty($this->objectInfo['oldPrice']) ? $this->getDefaultOldPrice() : $this->objectInfo['oldPrice'];
		return $price;
	}

	public function getDefaultOldPrice()
    {
        $config = $this->getConfig();
        return round($this->price * $config::OLD_PRICE_COEFFICIENT, $config::PRICE_ROUND_PRECISION);
    }

	public function getDiscount()
	{
		return ($this->getOldPrice() - $this->price);
	}
	
	public function isDefaultDiscount()
	{
		return empty($this->objectInfo['oldPrice']);
	}
}