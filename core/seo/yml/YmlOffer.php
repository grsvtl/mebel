<?php
namespace core\seo\yml;
class YmlOffer
{
	private $mandatory = array(
		'id',
		'available',
		'url',
		'price',
		'currencyId',
		'categoryId',
		'name'
	);

	private $noMandatory = array(
		'bid',
		'cbid',
		'pictures',
		'description',
		'manufacturerWarranty',
		'delivery',
		'deliveryCost'
	);

	public function __construct($data)
	{
		$this->setFields($data);
		$this->validateFields();
	}

	private function setFields($data)
	{
		foreach($data as $key=>$value)
			$this->$key = $value;
	}

	private function validateFields()
	{
		foreach($this->getFields() as $field){
			if($this->isMandatory($field))
				$this->validateMandatoryField($field);
			else
				$this->validateNoMandatoryField($field);
		}
	}

	private function validateMandatoryField($field)
	{
		if(!property_exists($this, $field))
			throw new \Exception ('The field - '.$field.' -  is mandatory in '. __CLASS__ .'!');
	}

	private function validateNoMandatoryField($field)
	{
		if(!property_exists($this, $field))
			$this->$field = false;
	}

	private function getFields()
	{
		return array_merge($this->mandatory, $this->noMandatory);
	}

	private function isMandatory($field)
	{
		return in_array($field, $this->mandatory);
	}
}