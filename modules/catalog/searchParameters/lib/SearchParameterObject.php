<?php
namespace modules\catalog\searchParameters\lib;
use modules\parameters\components\parametersValues\lib\ParameterValueObject;
use modules\parameters\components\parametersValues\lib\ParameterValuesObject;

class SearchParameterObject extends \core\modules\base\ModuleObject
{
    protected $configClass = '\modules\catalog\searchParameters\lib\SearchParameterConfig';

    function __construct($objectId)
    {
        parent::__construct($objectId, new $this->configClass);
    }
}