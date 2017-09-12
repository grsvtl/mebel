<?php
namespace modules\catalog\additionalGoods\lib;
class AdditionalGoodsDecorator extends \core\modules\base\ModuleDecorator
{
    public $additionalGoods;

    function __construct($object)
    {
        parent::__construct($object);
    }

    public function getAdditionalGoods()
    {
        if(empty($this->additionalGoods)) {
            $this->additionalGoods = new \modules\catalog\additionalGoods\lib\AdditionalGoods();
            $this->additionalGoods = $this->filterByParent($this->additionalGoods, $this->getParentObject());
        }
        return $this->additionalGoods;
    }

    public function isAdditionalGoodsExists()
    {
        return $this->getAdditionalGoods()->count() != 0;
    }

    private function filterByParent($additionalGoods, $parentObject)
    {
        return $additionalGoods->setSubquery('AND `catalogItemId` = ?d', $parentObject->id);
    }
}