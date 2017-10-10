<?php
namespace modules\catalog\priority\lib;
class CatalogPriorityConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\adapters\Date,
		\core\traits\adapters\Base,
		\core\traits\outAdapters\OutDate,
		\modules\catalog\CatalogValidators;

	protected $objectClass  = '\modules\catalog\priority\lib\CatalogPriority';
	protected $objectsClass = '\modules\catalog\priority\lib\CatalogPriorities';

	public $templates  = '';

	protected $table = 'catalog_catalog_priorities'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'goodId',
		'domainAlias',
		'categoryId',
		'priority'
	);

	public function rules()
	{
		return array(
			'domainAlias' => array(
				'validation' => array('_validNotEmpty'),
				'adapt' => '_adaptHtml',
			),
			'priority, goodId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'categoryId' => array(
				'validation' => array('_validInt'),
			)
		);
	}
}