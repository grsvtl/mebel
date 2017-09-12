<?php
namespace modules\catalog\additionalGoods\lib;
class AdditionalGoodConfig extends \core\modules\base\ModuleConfig
{
    use \core\traits\validators\Base,
        \core\traits\adapters\Base,
        \core\traits\outAdapters\OutBase;

    const ACTIVE_STATUS_ID = 1;
    const BLOCKED_STATUS_ID = 2;

    protected $objectClass  = '\modules\catalog\additionalGoods\lib\AdditionalGood';
    protected $objectsClass = '\modules\catalog\additionalGoods\lib\AdditionalGoods';

    public $templates  = 'modules/catalog/additionalGoods/tpl/';

    protected $table = 'catalog_additional_goods'; // set value without preffix!
    protected $idField = 'id';
    protected $objectFields = array(
        'id',
        'additionalGoodId',
        'catalogItemId',
    );

    public function rules()
    {
        return array(
            'additionalGoodId, catalogItemId' => array(
                'validation' => array('_validInt', array('notEmpty'=>true)),
            )
        );
    }

}
