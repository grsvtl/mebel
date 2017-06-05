<?php
namespace modules\catalog\offers\offerGroups\lib;
class OfferGroupConfig extends \core\modules\base\ModuleConfig
{
	use	\core\traits\adapters\Base;


	const ACTIVE_STATUS_ID = 1;
	const BLOCKED_STATUS_ID = 2;

	public $objectClass  = '\modules\catalog\offers\offerGroups\lib\OfferGroup';
	protected $objectsClass = '\modules\catalog\offers\offerGroups\lib\OfferGroups';

	protected $table = 'catalog_offerGroups'; // set value without preffix!
	protected $idField = 'id';

	protected $objectFields = array(
		'id',
		'offerId'
	);

	public function rules()
	{
		return array(
			'offerId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			)
		);
	}
}