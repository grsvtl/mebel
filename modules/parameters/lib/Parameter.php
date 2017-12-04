<?php
namespace modules\parameters\lib;
class Parameter extends \core\modules\base\ModuleDecorator
{
	function __construct($objectId)
	{
		$object = new ParameterObject($objectId);
		$object = new \core\modules\statuses\StatusDecorator($object);
		$object = new \modules\parameters\components\chooseMethods\lib\ChooseMethodDecorator($object);
		$object = new \core\modules\categories\AdditionalCategoriesDecorator($object);
		parent::__construct($object);
	}

	/* Start: Main Data Methods */
	public function getName()
	{
		return $this->name;
	}

	public function getImagePath()
	{
		return $this->imagePath;
	}
	/*   End: Main Data Methods */

	public function getParameterValues($id = null)
	{
		$id = isset($id) ? $id : $this->id;
		$parameterValues = new \modules\parameters\components\parametersValues\lib\ParameterValues();
//		$parameterValues->setSubquery(' AND `parameterId`=?d ', (int)$id)->setOrderBy('`priority` ASC');
        $parameterValues->setSubquery(' AND `parameterId`=?d ', (int)$id)->setOrderBy('`value` ASC');
		return $parameterValues;
	}

	public function getParameterValuesByObjectParametersArray($objectParametersArray)
	{
//		$array = [];
//		foreach ($this->getParameterValues() as $value)
//			in_array($value->id, $objectParametersArray) ? $array[] = $value->getValue() : '';
//		return $array;

		$array = [];
		foreach ($this->getParameterValues() as $value)
			if(in_array($value->id, $objectParametersArray)){
				$temp = [];
                $temp['id'] = $value->id;
                $temp['alias'] = $value->getAlias();
				$temp['description'] = $value->description;
				$temp['name'] = $value->getValue();
				$array[] = $temp;
			}
		return $array;
	}

	public function edit ($data, $fields = array()) {
		return ($this->additionalCategories->edit($data->additionalCategories)) ? $this->getParentObject()->edit($data, $fields) : false;
	}

	public function remove () {
		return $this->delete();
	}

	public function delete () {
		return ( $this->deleteRelations() ) ? ( $this->getParameterValues()->delete() ) ? $this->additionalCategories->edit(array()) ? $this->getParentObject()->delete() : false : false : false ;
	}

	private function deleteRelations ()
	{
		foreach ($this->getConfig()->relations() as $table=>$field) {
			$query = ' DELETE FROM `'.$table.'` WHERE `'.$field['idField'].'`=?d ';
			if ( !\core\db\Db::getMysql()->query( $query, array($this->id) ) )  {
				return false;
			}
		}
		return true;
	}

	public function isCheckbox()
	{
		return (int)$this->chooseMethodId === 2;
	}
}