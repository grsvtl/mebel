<?php
namespace modules\catalog\categories;
class CatalogCategoryDecorator extends \core\modules\base\ModuleDecorator
{
	protected $category;
	protected $categories;
	protected $mainCategories;
	function __construct($object)
	{
		parent::__construct($object);
	}

	public function getCategory()
	{
		if(empty($this->category))
			$this->category = $this->getObject('\modules\catalog\categories\CatalogCategory', $this->getParentObject()->categoryId, $this->getParentObject());
		return $this->category;
	}

	public function getCategories()
	{
		if(empty($this->categories)){
			$this->categories = new \modules\catalog\categories\CatalogCategories($this->getParentObject());
			$this->categories->setOrderBy('`priority` ASC');
		}

		return $this->categories;
	}

	public function getMainCategories($statusesArray = array())
	{
		if (!is_array($statusesArray))
			$statusesArray = array((int)$statusesArray);

		if(empty($this->mainCategories)){
			$this->mainCategories = new \modules\catalog\categories\CatalogCategories($this->getParentObject());
			$this->mainCategories->setSubquery('AND `parentId`=?d', 0)
							->setOrderBy('`priority` ASC');
			if(!empty($statusesArray))
				$this->mainCategories->setSubquery(' AND `statusId` IN (?s)',  implode(',', $statusesArray));
		}
		return $this->mainCategories;
	}

	public function getMainCategoriesIdString($statusesArray = array())
	{
		if(!$this->getMainCategories($statusesArray)->count())
			return '';
		return \core\utils\Utils::getCountableObjectPropertiesString($this->getMainCategories($statusesArray), 'id');
	}
}
