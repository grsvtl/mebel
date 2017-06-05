<?php
namespace modules\articles\lib;
class ArticleConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\validators\Base,
		\core\traits\adapters\Date,
		\core\traits\adapters\Alias,
		\core\traits\adapters\Base,
		\core\traits\outAdapters\OutDate,
		\core\traits\validators\Sitemap,
		\core\traits\adapters\Sitemap;

	const ACTIVE_STATUS_ID = 1;
	const BLOCKED_STATUS_ID = 2;

	const TOP_MENU_CATEGORY_ID = 102;
	const NEWS_CATEGORY_ID = 103;
	const INFO_CATEGORY_ID = 104;

	const TOP_MENU_DANA_CATEGORY_ID = 106;
	const REVIEWS_DANA_CATEGORY_ID = 107;
	const NEWS_DANA_CATEGORY_ID = 103;
	const DEFAULT_META_DANA_ARTICLE_ALIAS = 'defaultmetafordanadomain';
	const META_DANA_CATEGORY_ID = 108;

    const TOP_MENU_MERI_CATEGORY_ID = 115;
    const REVIEWS_MERI_CATEGORY_ID = 116;
    const DEFAULT_META_MERI_ARTICLE_ALIAS = 'defaultmetaformeridomain';
    const META_MERI_CATEGORY_ID = 114;

    const TOP_MENU_UG_CATEGORY_ID = 119;
    const DEFAULT_META_UG_ARTICLE_ALIAS = 'defaultmetaforugdomain';
    const META_UG_CATEGORY_ID = 114;
    const NEWS_UG_CATEGORY_ID = 120;

    const IMAGES_SMALL_MAIN_MEBEL = 757;
    const IMAGES_BIG_MAIN_MEBEL = 758;

	protected $objectClass  = '\modules\articles\lib\Article';
	protected $objectsClass = '\modules\articles\lib\Articles';

	public $templates  = 'modules/articles/tpl/';
	public $imagesPath = 'files/articles/images/';
	public $imagesUrl  = 'data/images/articles/';
	public $filesPath = 'files/articles/files/';
	public $filesUrl  = 'data/files/articles/';

	protected $table = 'articles'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'categoryId',
		'statusId',
		'blank',
		'redirect',
		'priority',
		'name',
		'h1',
		'alias',
		'description',
		'text',
		'date',
		'metaTitle',
		'metaKeywords',
		'metaDescription',
		'headerText',
		'lastUpdateTime',
		'sitemapPriority',
		'changeFreq',
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
			'statusId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'categoryId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
			'date' => array(
				'adapt' => '_adaptRegDate',
			),
			'metaTitle, metaKeywords, metaDescription, headerText' => array(
				'adapt' => '_adaptHtml',
			),
			'blank' => array(
				'adapt' => '_adaptBool',
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
		);
	}

	public function outputRules()
	{
		return array(
			'date' => array('_outDate'),
			'lastUpdateTime' => array('_outDateTime'),
		);
	}

}
