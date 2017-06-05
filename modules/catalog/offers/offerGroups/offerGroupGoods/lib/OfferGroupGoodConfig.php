<?php
namespace modules\catalog\offers\offerGroups\offerGroupGoods\lib;
class OfferGroupGoodConfig extends \core\modules\base\ModuleConfig
{
	public $objectClass  = '\modules\catalog\offers\offerGroups\offerGroupGoods\lib\OfferGroupGood';
	protected $objectsClass = '\modules\catalog\offers\offerGroups\offerGroupGoods\lib\OfferGroupGoods';


	protected $table = 'catalog_offerGroup_goods'; // set value without preffix!
	protected $idField = 'id';

	protected $objectFields = array(
		'id',
		'offerGroupId',
		'goodId'
	);

	public $templates  = 'modules/catalog/offers/offerGroups/offerGroupGoods/tpl/';

	public function rules()
	{
		return array(
			'offerGroupId, goodId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			)
		);
	}
}