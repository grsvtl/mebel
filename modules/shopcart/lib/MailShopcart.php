<?php
namespace modules\shopcart\lib;
class MailShopcart extends \core\mail\MailBase
{
	use	\core\traits\RequestHandler,
		\core\traits\controllers\Authorization,
		\core\traits\ObjectPool;

	private $shopcart;

	private $rules = array(
			'name, family, parentName, phone, paymentType' => array(
				'validation' => array('_validNotEmpty'),
			),
			'email' => array(
				'validation' => array('_validEmail', array('key'=>'email', 'notEmpty'=>true)),
			)
	);
	private $shippingRules = array(
			'region, city, street, home' => array(
				'validation' => array('_validNotEmpty'),
			)
	);

	public function rules()
	{
		return $this->rules;
	}

	public function __construct($shopcart)
	{
		parent::__construct();
		$this->templates = TEMPLATES.\core\url\UrlDecoder::getInstance()->getDomainAlias().'/'.$_REQUEST['lang'].'/emails/';
		$this->data = $_POST;
		$this->shopcart = $shopcart;
	}

	public function MailShopcartToAdmin()
	{
	    if(isset($this->data['lift']))
            if($this->data['lift'] != 'null')
                $this->rules = array_merge ($this->rules, $this->shippingRules);

		if (!$this->_beforeChange($this->data, array_keys($this->data)))
			return false;

		//		$managers = array('testdeloadm@gmail.com');
		$managers = array();
		foreach($this->getObject('modules\administrators\lib\Administrators')->getActiveManagers() as $manager)
			if( \core\utils\Utils::isEmail($manager->getUserData()['email']))
				$managers[] = $manager->getUserData()['email'];

		$managers[] = $this->adminEmail;
		$managers[] = $this->bccEmail;

		$res = $this->From($this->noreplyEmail)
				->To($managers)
				->Subject('Новый заказ с сайта  '.SEND_FROM)
				->Content('data', $this->data)
				->Content('shopcart', $this->shopcart)
				->BodyFromFile('shopcartMailToAdmin.tpl')
				->Send();
//		if($res)
//			return $this->resetMail();
//		throw new \Exception('Error mail() in '.get_class($this).'!');
		return $res;
	}

	public function MailShopcartToClient()
	{
		$res = $this->From($this->noreplyEmail)
				->To($this->data['email'])
				->Subject('Заказ с сайта  '.SEND_FROM)
				->Content('data', $this->data)
				->Content('shopcart', $this->shopcart)
				->BodyFromFile('shopcartMailToClient.tpl')
				->Send();
		if($res)
			return 1;
		throw new \Exception('Error mail() in '.get_class($this).'!');
	}
}
