<?php
namespace modules\parameters\components\parametersValues\lib;
class ParametersValuesRelationDecorator extends \core\modules\base\ModuleDecorator
{
	private $parametersValues;
	private $parametersValuesArray = array();
	private $parametersValuesForAlias;
	private $useCache = true;
	
	function __construct($object)
	{
		parent::__construct($object);
	}
	
	function getParameters()
	{
        if(!$this->useCache  ||  empty($this->parametersValues))
            $this->parametersValues = new ParametersValuesRelation($this->id, $this->_object);
		return $this->parametersValues;
	}
	
	function getParametersArray() 
	{
		if (!$this->useCache  ||  !$this->parametersValuesArray)
			foreach($this->getParameters() as $value) {
				$this->parametersValuesArray[] = $value->id;
			}
		return $this->parametersValuesArray;
	}
	
	function getParameter($alias) 
	{
		if(!$this->useCache  ||  empty($this->parametersValuesForAlias))
			$this->parametersValuesForAlias = new ParametersValuesRelation($this->id, $this->_object);
		return $this->parametersValuesForAlias->getParameterByAlias($alias);
	}

	function disableParameterCache()
    {
        $this->useCache = false;
        return $this;
    }
}