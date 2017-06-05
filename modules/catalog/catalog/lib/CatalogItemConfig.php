<?php
namespace modules\catalog\catalog\lib;
class CatalogItemConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\adapters\Date,
		\core\traits\adapters\Base,
		\core\traits\outAdapters\OutDate,
		\modules\catalog\CatalogValidators,
		\core\traits\validators\Sitemap,
		\core\traits\adapters\Sitemap;

	const ACTIVE_STATUS_ID  = 1;
	const NEW_STATUS_ID = 3;
	const SUPER_PRICE_STATUS_ID = 4;
	const TOP_SELL_ID = 5;
    const AKCIA_ID = 6;
    const SALE_ID = 7;
	const BLOCKED_STATUS_ID = 9;
	const REMOVED_STATUS_ID = 10;

    const MATERIAL_PARAMETERS_ID= 48;
    const CORPUS_PARMETERS_ID = 53;
    const FASAD_PARAMETERS_ID = 54;

	protected $objectClass  = '\modules\catalog\catalog\lib\CatalogItem';
	protected $objectsClass = '\modules\catalog\catalog\lib\Catalog';

	public $templates  = 'modules/catalog/catalog/tpl/';
	public $shopcartTemplate  = 'shopcart/standartShopcartItem';
	public $orderGoodAdminTemplate  = 'standartGoods';
	public $imagesPath = 'files/catalog/images/';
	public $imagesUrl  = 'data/images/catalog/';
	public $filesPath = 'files/catalog/files/';
	public $filesUrl  = 'data/files/catalog/';

	protected $table = 'catalog_catalog'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'categoryId',
		'statusId',
		'description',
		'text',
		'priority',
		'date',
		'lastUpdateTime',
		'sitemapPriority',
		'changeFreq',
		'fabricatorId',
		'seriaId',
		'video',
		'card',
		'onMainDanaPage',
        'onMainMeriPage'
	);

    public $checkboxFields = array(
        'card',
		'onMainDanaPage'
    );

	public function rules()
	{
		return array(
			'name' => array(
				'validation' => array('_validNotEmpty'),
				'adapt' => '_adaptHtml',
			),
			'alias' => array(
				'adapt' => '_adaptAlias',
			),
			'categoryId, statusId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'seriaId' => array(
				'validation' => array('_validInt'),
			),
			'fabricatorId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'date' => array(
				'adapt' => '_adaptRegDate',
			),
			'lastUpdateTime' => array(
				'validation' => array('_validLastUpdateTime'),
				'adapt' => '_adaptLastUpdateTime',
			),
			'sitemapPriority' => array(
				'validation' => array('_validSitemapPriority'),
				'adapt' => '_adaptSitemapPriority',
			),
			'changeFreq' => array(
				'validation' => array('_validChangeFreq'),
				'adapt' => '_adaptChangeFreq',
			),
			'card, onMainDanaPage, onMainMeriPage' => array(
				'adapt' => '_adaptBool',
			)
		);
	}

	public function outputRules()
	{
		return array(
			'date' => array('_outDate'),
			'lastUpdateTime' => array('_outDateTime'),
		);
	}

	public function getNewStatusId(){return self::NEW_STATUS_ID;}
	public function getSuperPriceStatusId(){return self::SUPER_PRICE_STATUS_ID;}
	public function getTopSellStatusId(){return self::TOP_SELL_ID;}
    public function getSaleStatusId(){return self::SALE_ID;}
    public function getAkciaStatusId(){return self::AKCIA_ID;}
    public function getMaterialParametersId(){return self::MATERIAL_PARAMETERS_ID;}
    public function getCorpusParametersId(){return self::CORPUS_PARMETERS_ID;}
    public function getFasadParametersId(){return self::FASAD_PARAMETERS_ID;}
}