<?php
namespace core\modules\categories;
class CategoriesAliasesRules
{
	private $rules = array(
		'/dana/news/' => '/news/',
        '/ug/news_ug/'   => '/news_ug/',
        '/akcii/new-lerom-products/' => '/new-lerom-products/'
	);

	public function useRules($alias)
	{
		return str_replace(array_keys($this->rules), array_values($this->rules), $alias);
	}
}