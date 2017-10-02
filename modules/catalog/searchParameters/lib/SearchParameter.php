<?php
namespace modules\catalog\searchParameters\lib;
use modules\parameters\components\parametersValues\lib\ParameterValueObject;
use modules\parameters\components\parametersValues\lib\ParameterValuesObject;

class SearchParameter extends \core\modules\base\ModuleDecorator
{
    use \core\traits\objects\SiteMapPriority,
        \core\traits\RequestHandler,
        \core\traits\controllers\ServiceRequests;

    function __construct($objectId)
    {
        $object = new SearchParameterObject($objectId);
        $object = new \core\modules\statuses\StatusDecorator($object);
        parent::__construct($object);
    }

    public function getId()
    {
        return $this->id;
    }

    public function getParameterValueId()
    {
        return $this->parameterValueId;
    }

    public function getParameterValue()
    {
        $parameterValues = new ParameterValuesObject();
        if ($parameterValues->isExist($this->getParameterValueId())) {
            $parameterValue = new ParameterValueObject($this->getParameterValueId());
            return $parameterValue;
        }
    }

    public function getParameterPriority()
    {
        return $this->parameterPriority;
    }

    public function getStatusId()
    {
        return $this->statusId;
    }
}