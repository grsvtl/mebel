<?php
namespace modules\mailers;
class ModalAskMail extends \core\mail\MailBase
{
	use	\core\traits\RequestHandler,
		\core\traits\controllers\Authorization,
		\core\traits\ObjectPool;

	function __construct()
	{
		parent::__construct();
		$this->templates = TEMPLATES.\core\url\UrlDecoder::getInstance()->getDomainAlias().'/'.$_REQUEST['lang'].'/emails/';
	}

	public function sendModalAskToManagers($clientPhoneNumber)
	{
//		$managers = array('testdeloadm@gmail.com');
		foreach($this->getObject('modules\administrators\lib\Administrators')->getActiveManagers() as $manager)
			if( \core\utils\Utils::isEmail($manager->getUserData()['email']))
				$managers[] = $manager->getUserData()['email'];

		$managers[] = $this->adminEmail;
		$managers[] = $this->bccEmail;

		$res = $this->From($this->noreplyEmail)
				->To($managers)
				->Subject('Клиент заказал обратный звонок на номер '.$clientPhoneNumber.', с сайта '.SEND_FROM)
				->Content('clientPhoneNumber', $clientPhoneNumber)
				->Content('managers', $managers)
				->BodyFromFile('sendModalAsk.tpl')
				->Send();
		if($res)
			return 1;
		throw new Exception('Error mail() in '.get_class($this).'!');
	}

}
