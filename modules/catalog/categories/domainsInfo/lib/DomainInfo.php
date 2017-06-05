<?php
namespace modules\catalog\categories\domainsInfo\lib;
class DomainInfo extends \core\modules\base\ModuleDecorator
{
	function __construct($objectId)
	{
		$object = new DomainInfoObject($objectId);
		parent::__construct($object);
	}

	/* Start: Meta Methods */
	public function getMetaTitle()
	{
		return $this->metaTitle ? $this->metaTitle : $this->getName();
	}

	public function getMetaDescription()
	{
		return $this->metaDescription;
	}

	public function getMetaKeywords()
	{
		return $this->metaKeywords;
	}

	public function getHeaderText()
	{
		return $this->headerText;
	}
	/*   End: Meta Methods */

	/* Start: URL Methods */
//	public function getPath()
//	{
//		throw new \Exception('Method DomainInfo::getPath() was not finished!');
//	}
	/*   End: URL Methods */

//	public function isValidPath($path)
//	{
//		return $this->getPath() == rtrim($path,'/').'/';
//	}

	public function getName()
	{
		return $this->name;
	}

	public function getDescription()
	{
		return $this->description;
	}

	public function getText()
	{
		return $this->text;
	}

	public function getH1()
	{
		return $this->h1;
	}
}