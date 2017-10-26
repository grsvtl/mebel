<?php
namespace modules\modulesDomain\components\domains\lib;
class DomainConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\validators\Base,
		\core\traits\adapters\Date,
		\core\traits\adapters\Alias,
		\core\traits\adapters\Base,
		\core\traits\outAdapters\OutDate;

	const ACTIVE_STATUS_ID = 1;
	const BLOCKED_STATUS_ID = 2;
	const STATUS_DELETED = 3;

	public $constructionsId = 9;
	public $devicesId = 21;

	protected $objectClass  = '\modules\modulesDomain\components\domains\lib\Domain';
	protected $objectsClass = '\modules\modulesDomain\components\domains\lib\Domains';

	public $templates  = '';

	protected $table = 'modules_domains'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'moduleId',
		'domainName'
	);

	public function rules()
	{
		return array(
			'domainName' => array(
				'validation' => array('_validNotEmpty'),
			),
			'moduleId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			)
		);
	}

	public function outputRules()
	{
		return array();
	}
}
