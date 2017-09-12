<?php
namespace modules\catalog\additionalGoods\lib;
class AdditionalGoods extends \core\modules\base\ModuleObjects
{
    protected $configClass     = '\modules\catalog\additionalGoods\lib\AdditionalGoodConfig';
    protected $objectClassName = '\modules\catalog\additionalGoods\lib\AdditionalGood';

    function __construct()
    {
        parent::__construct(new $this->configClass);
    }
}
