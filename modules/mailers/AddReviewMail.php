<?php
namespace modules\mailers;
class AddReviewMail extends \core\mail\MailBase
{
	use \core\traits\validators\Base;

	function __construct($data)
	{
		parent::__construct();
		$this->templates = TEMPLATES.\core\url\UrlDecoder::getInstance()->getDomainAlias().'/'.$_REQUEST['lang'].'/emails/';
		$this->data = $data;
	}

	public function MailToAdmin()
	{
		return $this->From($this->noreplyEmail)
                    ->To($this->adminEmail)
                    ->Bcc($this->bccEmail)
                    ->Subject('Новый отзыв с сайта  '.SEND_FROM)
                    ->Content('data', $this->data)
                    ->Content('review', $this->data['review'])
                    ->Content('catalogObject', $this->data['cataloObject'])
                    ->BodyFromFile('reviewMail.tpl')
                    ->Send();
	}
}
