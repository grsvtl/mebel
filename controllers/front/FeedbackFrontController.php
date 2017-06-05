<?php
namespace controllers\front;
class FeedbackFrontController extends \controllers\base\Controller
{
	use \core\traits\controllers\Templates,
        \core\traits\validators\Capcha;

	protected $permissibleActions = array(
		'ajaxAsk',
		'getFeedbackBlock',
		'ajaxModalAsk',
        'ajaxGenerateCapchaString'
	);

	public function __construct()
	{
		parent::__construct();
	}

	protected function ajaxAsk()
	{
		$feedback = new \modules\mailers\ContactsFeedback($this->getPOST());
		$this->setObject($feedback)
			->ajax($this->modelObject->sendFeedbackMail(), 'ajax');
	}

	protected function getFeedbackBlock()
	{
//		$this->getObject('\core\capcha\CapchaString')->generate();
		$this->includeTemplate('catalog/feedbackBlock');
	}

	protected function ajaxGenerateCapchaString()
    {
        $this->getObject('\core\capcha\CapchaString')->generate();
        echo json_encode( array('res'=>true, 'capcha'=>$this->getSESSION()['capchaString']) );
    }

	protected function ajaxModalAsk()
	{
		$post = $this->getPOST();
		if ( $post->phoneNumberAsk ) {
			if ( !strripos($post->phoneNumberAsk, '_') &&  $this->_validCorrectCapcha($this->getPOST()['capcha']) === true) {
				$modalAsk = new \modules\mailers\ModalAskMail();
				$result = $modalAsk->sendModalAskToManagers($post->phoneNumberAsk);
			} else {
				$result = array( 'phoneNumberAsk' => 'Вы ввели неверный номер телефона, попытайтесь пожалуйста еще раз' );
			}
		} else {
			$result = array( 'phoneNumberAsk' => 'Пожалуйста введите свой номер телефона' );
		}

		if( $this->_validCorrectCapcha($this->getPOST()['capcha']) !== true )
            $result['capcha'] = 'Укажите верный результат';

		$this->ajaxResponse($result);
	}
}
