<?php
namespace modules\mailers;
class ContactsFeedback extends \core\mail\MailBase
{
	use \core\traits\validators\Base,
		\core\traits\validators\Capcha;

	function __construct($data)
	{
		parent::__construct();
		$this->templates = TEMPLATES.\core\url\UrlDecoder::getInstance()->getDomainAlias().'/'.$_REQUEST['lang'].'/emails/';
		$this->data = $data->getArray();
	}

	public function rules()
	{
		return array(
			'askName, askPhone, askText' => array(
				'validation' => array('_validNotEmpty'),
			),
			'askEmail' => array(
				'validation' => array('_validEmail', array('key'=>'askEmail', 'notEmpty'=>true)),
			),
			'capcha' => array(
				'validation' => array('_validCorrectCapcha', array('not_empty'=>true)),
			),
		);
	}

	public function sendFeedbackMail()
	{
		if (!$this->_beforeChange($this->data, array_keys($this->data)))
			return false;
		$res = $this->From($this->noreplyEmail)
				->To($this->adminEmail)
				->Bcc($this->bccEmail)
				->Subject('Письмо с сайта  '.SEND_FROM)
				->Content('data', $this->data)
				->BodyFromFile('feedback.tpl')
				->Send();
		return $res;
	}
}
