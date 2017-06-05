<?php
namespace modules\catalog;
trait CatalogValidators
{
	use \core\traits\validators\Base;

	public function _validCode($code)
	{
		return $this->_validNotEmpty($code);
	}

	public function _validName($name)
	{
		return $this->_validNotEmpty($name);
	}

	public function _validClass($class)
	{
		return class_exists($class, true);
	}

}