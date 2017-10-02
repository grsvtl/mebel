<?php
namespace modules\catalog\searchParameters\lib;

class SearchParametersObject extends \core\modules\base\ModuleObjects
{
    protected $configClass     = '\modules\catalog\searchParameters\lib\SearchParameterConfig';
    protected $objectClassName = '\modules\catalog\searchParameters\lib\SearchParameter';

    function __construct()
    {
        parent::__construct(new $this->configClass);
    }

}
