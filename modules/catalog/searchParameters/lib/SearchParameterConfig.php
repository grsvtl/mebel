<?php
namespace modules\catalog\searchParameters\lib;
class SearchParameterConfig extends \core\modules\base\ModuleConfig
{
    use \core\traits\validators\Base,
        \core\traits\adapters\Base,
        \core\traits\outAdapters\OutBase;

    const ACTIVE_STATUS_ID = 1;
    const BLOCKED_STATUS_ID = 2;

    protected $objectClass  = '\modules\catalog\searchParameters\lib\SearchParameter';
    protected $objectsClass = '\modules\catalog\searchParameters\lib\SearchParameters';

    public $templates  = 'modules/catalog/searchParameters/tpl/';

    protected $table = 'catalog_search_parameters'; // set value without preffix!
    protected $idField = 'id';
    protected $objectFields = array(
        'id',
        'parameterValueId',
        'priority',
        'statusId',
    );

    public function rules()
    {
        return array(
            'priority, statusId,' => array(
                'validation' => array('_validInt', array('notEmpty' =>true)),
            )
        );
    }

}
