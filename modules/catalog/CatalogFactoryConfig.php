<?php
namespace modules\catalog;
class CatalogFactoryConfig extends \core\modules\base\ModuleConfig
{
	use	\modules\catalog\CatalogValidators,
		\core\traits\adapters\Base;

	protected  $table = 'catalog'; // set value without preffix!

	protected $objectFields = array(
		'id',
		'code',
		'name',
		'class',
	);

	public function rules()
	{
		return array(
			'code' => array(
				'validation' => array('_validCode'),
			),
			'name' => array(
				'validation' => array('_validName'),
				'adapt' => '_adaptHtml',
			),
			'class' => array(
				'validation' => array('_validClass'),
			),
		);
	}
}