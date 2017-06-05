<?php
namespace modules\catalog\reviews\lib;
class ReviewConfig extends \core\modules\base\ModuleConfig
{
    use \core\traits\validators\Base,
        \core\traits\adapters\Base,
        \core\traits\outAdapters\OutBase;

	const ACTIVE_STATUS_ID = 1;
	const BLOCKED_STATUS_ID = 2;

	protected $objectClass  = '\modules\review\lib\Review';
	protected $objectsClass = '\modules\reviews\lib\Reviews';

	public $templates  = 'modules/catalog/reviews/tpl/';

	protected $table = 'catalog_reviews'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'statusId',
		'domainInfoId',
		'name',
		'date',
		'email',
		'adventages',
		'disadventages',
		'estimate',
		'text'
	);

	public function rules()
	{
		return array(
			'name' => array(
				'validation' => array('_validNotEmpty'),
			),
			'statusId, estimate, domainInfoId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'date' => array(
				'adapt' => '_adaptRegDate',
			),
//            'email'
		);
	}

	public function outputRules()
	{
		return array(
			'date' => array('_outDate'),
			'lastUpdateTime' => array('_outDateTime'),
		);
	}

//    public function validLogin ($login, $notEmpty = false) {
//        return ( $this->_validEmail($login, array('notEmpty'=>$notEmpty, 'key'=>'login')) == 'true' );
//    }

}
