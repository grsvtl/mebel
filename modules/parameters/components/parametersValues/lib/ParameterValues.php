<?php
namespace modules\parameters\components\parametersValues\lib;
class ParameterValues extends \core\modules\base\ModuleDecorator
{
	function __construct()
	{
		$object = new ParameterValuesObject();
		parent::__construct($object);
	}

    public function orderByPriority($type)
    {
        if(!in_array($type, array('ASC', 'DESC')))
            throw new \Exception('Type should be ASC or DESC in '.__CLASS__);
        return $this->setOrderBy('`priority` '.$type);
    }
}