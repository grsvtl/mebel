<?php
namespace modules\properties\lib;
class PropertyConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\validators\Base,
		\core\traits\adapters\Date,
		\core\traits\adapters\Alias,
		\core\traits\adapters\Priority,
		\core\traits\adapters\Base,
		\core\traits\outAdapters\OutDate;

	const ACTIVE_STATUS_ID = 1;
	const BLOCKED_STATUS_ID = 2;

	const PROPERTY_SIZESANDWEIGHT_ID = 1;
	const PROPERTY_DELIVERY_ID = 7;
	const PROPERTY_LIFTING_ID = 8;
	const PROPERTY_FITTING_ID = 9;

	const PROPERTY_MEBEL_CATEGORY_ID = 10;

	protected $objectClass  = '\modules\properties\lib\Property';
	protected $objectsClass = '\modules\properties\lib\Properties';

	public $templates  = 'modules/properties/tpl/';

	protected $table = 'properties'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'statusId',
		'measurementId',
		'name',
		'alias',
		'description',
		'priority',
		'date',
		'imagePath'
	);

	public function rules()
	{
		return array(
			'name' => array(
				'validation' => array('_validNotEmpty'),
			),
			'alias' => array(
				'adapt' => '_adaptAlias',
			),
			'priority' => array(
				'adapt' => '_adaptPriority',
			),
			'statusId' => array(
				'adapt' => '_adaptStatus',
			),
			'measurementId' => array(
				'validation' => array('_validInt'),
			),
			'date' => array(
				'adapt' => '_adaptRegDate',
			),
			'description' => array(
				'adapt' => '_adaptHtml',
			),
			'imagePath' => array(
				'adapt' => '_adaptHtml',
			),
		);
	}

	public function outputRules()
	{
		return array(
			'date' => array('_outDate'),
		);
	}

	public function relations()
	{
		$relations = array(
			'tbl_catalog_catalog_properties_values_relation' => array('idField'=>'propertyValueId')
		);
		return $relations;
	}
}
