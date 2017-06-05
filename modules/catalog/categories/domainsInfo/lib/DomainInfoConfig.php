<?php
namespace modules\catalog\categories\domainsInfo\lib;
class DomainInfoConfig extends \core\modules\base\ModuleConfig
{
	use \core\traits\validators\Base,
		\core\traits\validators\DomainAlias,
		\core\traits\validators\Alias,
		\core\traits\adapters\Base,
		\core\traits\outAdapters\OutBase;

	const ACTIVE_STATUS_ID  = 1;
	const BLOCKED_STATUS_ID = 2;

	protected $objectClass  = '\modules\catalog\categories\domainsInfo\lib\DomainInfo';
	protected $objectsClass = '\modules\catalog\categories\domainsInfo\lib\DomainsInfo';

	public $templates  = 'modules/catalog/categories/domainsInfo/tpl/';

	protected $table = 'catalog_categories_domainsinfo'; // set value without preffix!
	protected $idField = 'id';
	protected $objectFields = array(
		'id',
		'domainAlias',
		'objectId',
		'alias',
		'name',
		'description',
		'h1',
		'text',
		'metaTitle',
		'metaKeywords',
		'metaDescription',
		'headerText',
		'image',
		'bigImage'
	);

	public function rules()
	{
		return array(
			'name' => array(
				'validation' => array('_validNotEmpty'),
			),
			'domainAlias' => array(
				'validation' => array('_validDomainAlias'),
			),
			'alias' => array(
				'validation' => array('_domainInfoAliasValidation')
			),
			'description, text, metaTitle, metaKeywords, metaDescription, headerText' => array(
				'adapt' => '_adaptHtml',
			),
			'objectId' => array(
				'validation' => array('_validInt', array('notEmpty'=>true)),
			),
		);
	}

	public function outputRules()
	{
		return array(
			'text' => array('_outHtml'),
			'description' => array('_outHtml'),
			'smallDescription' => array('_outHtml'),
		);
	}

	public function _domainInfoAliasValidation()
	{
		if(empty($_POST['alias']))
			return false;
		$res = \core\db\Db::getMysql()->row(
			'SELECT `objectId` FROM `'.$this->table.'` WHERE `domainAlias`="'.$_POST['domainAlias'].'" AND `alias`="'.$_POST['alias'].'"'
		);
		if(isset($res))
			return ($res['objectId']) == $_POST['id'];
		return true;
	}
}