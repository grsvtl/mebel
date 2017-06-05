<?php
namespace modules\catalog;
class CatalogRegistrator extends \core\modules\base\ModuleObjects
{
	protected $code;
	protected $name;
	protected $class;

	protected function addGood()
	{
		if ($this->getErrors())
			return false;
		return CatalogFactory::getInstance()->add($this->code, $this->name, $this->class);
	}

	public function setCode($code)
	{
		$code = (string)$code;
		if ($this->getConfig()->_validCode($code)) {
			if (CatalogFactory::getInstance()->codeExists($code))
				$this->setError('code', 'Товар с кодом "'.$code.'" уже существует!');
			else
				$this->code = $code;
		} else
			$this->setError('code', 'Код не валиден!');
		return $this;
	}

	public function setName($name)
	{
		$name = (string)$name;
		if ($this->getConfig()->_validName($name)) {
			$this->name = $name;
		} else
			$this->setError('name', 'Name is not valid!');
		return $this;
	}

	protected function setClass($class)
	{
		if ($this->getConfig()->_validClass($class))
			$this->class = $class;
		else
			$this->setError('class', 'Non-existent good class!');
		return $this;
	}

	public function add($data, $fields = NULL)
	{
		$this->setClass($this->getConfig()->getObjectClass());
		$this->_beforeChangeWithoutAdapt($data, $this->getConfig()->getObjectFields());
		if ($this->getErrors()) {
			return false;
		} else {
			$data['id'] = $this->addGood();
			parent::add($data);
			return $data['id'];
		}
	}
}