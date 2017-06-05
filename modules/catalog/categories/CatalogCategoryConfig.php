<?php
namespace modules\catalog\categories;
class CatalogCategoryConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\adapters\Alias,
		\core\traits\adapters\Date,
		\core\traits\adapters\Base,
		\core\traits\outAdapters\OutDate,
		\modules\catalog\CatalogValidators,
		\core\traits\validators\Sitemap,
		\core\traits\adapters\Sitemap;

    const SPALNI_CATEGORY_ID = 104;
    const GOSTINNYE_CATEGORY_ID = 108;
    const DETSKIE_CATEGORY_ID = 107;
    const STENKI_CATEGORY_ID = 126;
    const SHKAFI_DLYA_SPALNI_CATEGORY_ID = 127;

	protected $objectClass = '\modules\catalog\categories\CatalogCategory';
	protected $objectsClass = '\modules\catalog\categories\CatalogCategories';

	protected $tablePostfix = '_categories'; // set value without preffix!\
	protected $idField = 'id';
	protected $removedStatus = 3;
	protected $objectFields = array(
		'id',
		'statusId',
		'parentId',
		'priority',
        'sorting',
        'sortingKey',
		'name',
		'h1',
		'alias',
		'description',
		'text',
		'date',
		'metaTitle',
		'metaKeywords',
		'metaDescription',
		'image',
		'bigImage',
		'template',
		'parametersCategoryId',
		'lastUpdateTime',
		'sitemapPriority',
		'changeFreq',
	);

    private $sortingValues = array(
//		'price' => array(
//			'up' => '(SELECT MAX( `tbl_catalog_catalog_prices`.`price` ) FROM `tbl_catalog_catalog_prices` WHERE `tbl_catalog_catalog_prices`.`objectId` = mt.`id`
//				) ASC',
//			'down' => '(SELECT MAX( `tbl_catalog_catalog_prices`.`price` ) FROM `tbl_catalog_catalog_prices` WHERE `tbl_catalog_catalog_prices`.`objectId` = mt.`id`
//				) DESC'
//		),

        'price' => array(
            'up' => '(SELECT getPriceById(mt.`id`)) ASC',
            'down' => '(SELECT getPriceById(mt.`id`)) DESC'
        ),

        'popularity' => array(
            'up' => '`priority` ASC',
            'down' => '`priority` DESC'
        ),
        'priority' => array(
            'up' => '`priority` ASC',
            'down' => '`priority` DESC'
        ),
        'novelty' => array(
            'up' => '`date` ASC',
            'down' => '`date` DESC'
        ),
    );

    private $sortingValuesTranslate = array(
        'priority'=>'популярности',
        'price'=>'цене',
        'novelty'=>'новизне'
    );

	public function rules()
	{
		return array(
			'name' => array(
				'validation' => array('_validNotEmpty'),
				'adapt' => '_adaptHtml',
			),
			'h1, template' => array(
				'adapt' => '_adaptHtml',
			),
			'alias' => array(
				'adapt' => '_adaptAlias',
			),
			'statusId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'parent_category, parametersCategoryId' => array(
				'validation' => array('_validInt'),
			),
			'date' => array(
				'adapt' => '_adaptRegDate',
			),
			'm_title, m_keywords, m_description, image, bigImage' => array(
				'adapt' => '_adaptHtml',
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
            'sorting, sortingKey' => array(
                'validation' => array('_validNotEmpty')
            ),
		);
	}

	public function _validNotEmpty($data)
	{
		return !empty($data);
	}

	public function outputRules()
	{
		return array(
			'date' => array('_outDate'),
			'lastUpdateTime' => array('_outDateTime'),
		);
	}

	public function _adaptRegDate($key)
	{
		$this->data[$key] = (!empty($this->data[$key])) ? \core\utils\Dates::convertDate($this->data[$key], 'mysql') : time() ;
	}

	public function getSortingValues(){return $this->sortingValues;}
	public function getSortingValuesTranslate(){return $this->sortingValuesTranslate;}
}