<?php
namespace controllers\front;
class CabinetFrontController extends \controllers\base\Controller
{
	use	\core\traits\controllers\Meta,
		\core\traits\controllers\Templates,
		\core\traits\controllers\Authorization;

	protected $permissibleActions = array(
		'current',
		'archive',
		'order',
		'personal',
		'authorization',
		'ajaxGetPersonalDataBlockContent',
		'enter'
	);

	public function __construct()
	{
		parent::__construct();
	}

	public function __call($name, $arguments)
	{
		if($this->getController('Authorization')->isGuest()){
			if(isset($_REQUEST[0])) {
				return $this->redirect404 ();
			}
			return $this->enter();
		}

		$this->pageDetect($name, $arguments);
	}

	protected function pageDetect($name, $arguments)
	{
		if($this->validateOrderUrl())
			return $this->order();
		if(isset($_REQUEST[0]))
			return $this->redirect404 ();

		if ($this->setAction($name)->isPermissibleAction()){
			return $this->callAction($arguments);
		}
		else
			return $this->current();
	}

	protected function current(){
		$this->setTitle('Личный кабинет - Активные заказы')
			->setDescription('Личный кабинет - Активные заказы')
			->setKeywords('Личный кабинет - Активные заказы')
			->setContent('content', $this->getContent(__FUNCTION__))
			->includeTemplate('/cabinet/cabinet');
	}

	protected function archive(){
		$this->setTitle('Личный кабинет - Архивные заказы')
			->setDescription('Личный кабинет - Архивные заказы')
			->setKeywords('Личный кабинет - Архивные заказы')
			->setContent('content', $this->getContent(__FUNCTION__))
			->includeTemplate('/cabinet/cabinet');
	}

	protected function order(){
		$this->setTitle('Личный кабинет - Просмотр заказа')
			->setDescription('Личный кабинет - Просмотр заказа')
			->setKeywords('Личный кабинет - Просмотр заказа')
			->setContent('content', $this->getContent(__FUNCTION__))
			->includeTemplate('/cabinet/cabinet');
	}

	protected function personal(){
		$this->setTitle('Личный кабинет - Личные данные')
			->setDescription('Личный кабинет - Личные данные')
			->setKeywords('Личный кабинет - Личные данные')
			->setContent('content', $this->getContent(__FUNCTION__))
			->includeTemplate('/cabinet/cabinet');
	}

	protected function authorization(){
		$this->setTitle('Личный кабинет - Авторизация')
			->setDescription('Личный кабинет - Авторизация')
			->setKeywords('Личный кабинет - Авторизация')
			->setContent('content', $this->getContent(__FUNCTION__))
			->includeTemplate('/cabinet/cabinet');
	}

	private function getContent($action)
	{
		ob_start();
		$this->includeTemplate('/cabinet/'.$action);
		$contents = ob_get_contents();
		ob_end_clean();
		return $contents;
	}

	private function validateOrderUrl()
	{
		if( isset($_REQUEST[1]))
			return false;
		if( ! isset($_REQUEST[0]))
			return false;
		if($this->action != 'current'   &&   $this->action != 'archive')
			return false;
		return $this->isOrderBelongsToClientByNr($_REQUEST[0]);
	}

	private function isOrderBelongsToClientByNr($nr)
	{
		$order = $this->getController('Order')->getOrderByNr($nr);
		return $order  ?  $order->clientId == $this->getAuthorizatedUser()->id  :  false;
	}

	protected function ajaxGetPersonalDataBlockContent($clientType = null)
	{
		return $this->setContent('client', $this->getAuthorizatedUser())
				->includeTemplate('/cabinet/personalData'.ucfirst(isset($clientType) ? $clientType : $this->getPOST()['clientType']));
	}

	protected function enter()
	{
		$this->setTitle('Личный кабинет - Вход')
			->setDescription('Личный кабинет - Вход')
			->setKeywords('Личный кабинет - Вход')
			->setContent('content', $this->getContent(__FUNCTION__))
			->includeTemplate('/cabinet/cabinet');
	}


}