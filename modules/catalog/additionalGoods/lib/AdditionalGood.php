<?php
namespace modules\catalog\additionalGoods\lib;
class AdditionalGood extends \core\modules\base\ModuleObject
{
    protected $configClass = '\modules\catalog\additionalGoods\lib\additionalGoodConfig';
    protected $good;

    function __construct($objectId)
    {
        parent::__construct($objectId, new $this->configClass);
    }

    public function getGood()
    {
        if (!$this->good)
            $this->good = \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->additionalGoodId);
        return $this->good;
    }

    public function getCost()
    {
        return $this->getGood()->getPriceByQuantity(1);
    }

    public function getBaseCost()
    {
        return  $this->getGood()->getBasePriceByQuantity(1);
    }

    public function getBaseCostByPartner($partnerId)
    {
        return  $this->getGood()->getBasePriceByQuantityForPartner(1, $partnerId);
    }

    public function getIncome()
    {
        return $this->getCost() - $this->getBaseCost();
    }
}