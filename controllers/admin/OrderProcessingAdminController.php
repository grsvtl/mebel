<?php
namespace controllers\admin;
class OrderProcessingAdminController extends \controllers\base\Controller
{
	use	\core\traits\controllers\Rights,
		\core\traits\controllers\Templates,
		\core\traits\controllers\Authorization;

	protected $permissibleActions = array(
		'ajaxGetGoodsByName',
		'newOrder',
		'firstAddingGoods',
		'secondAddingGoods',
		'getOrderGoodsTable',
		'continueOrder',
		'editGood',
		'deleteGood',
		'editOrder',
		'getDeliveryTable',
		'getDeliveryDataByDeliveryId',
		'saveClientInOrder'
	);

	private $statusIncomplete = 1;
	private $statusComplete   = 2;
	private $statusDelete	  = 3;

	public function  __construct()
	{
		parent::__construct();

		$this->_config          = new \modules\orderProcessing\lib\OrderProcessingItemConfig();
		$this->objectClass      = $this->_config->getObjectClass();
		$this->objectsClass     = $this->_config->getObjectsClass();
		$this->objectClassName  = $this->_config->getObjectClassName();
		$this->objectsClassName = $this->_config->getObjectsClassName();
	}

	public function defaultAction()
	{
		$this->newOrder();
	}


	protected function newOrder()
	{
		$this->checkUserRightAndBlock('order_add');

		$this->setContent('order', $this->getNoop())
			 ->includeTemplate('newOrder');
	}

	protected function continueOrder()
	{
		$this->checkUserRightAndBlock('order_add');
		$order = $this->getNoop();

		if ($this->getREQUEST()[0])
			$order = $this->getOrderObject($this->getREQUEST()[0]);
		else
			$this->defaultAction();

		$this->setContent('order', $order)
			 ->includeTemplate('newOrder');
	}

	private function getOrderObject($orderId = null)
	{
		return ($orderId) ? $this->getObject($this->objectClass, $orderId) : $this->getNoop();
	}

	protected function ajaxGetGoodsByName()
	{

		$objects = \modules\catalog\CatalogFactory::getInstance()->getGoodsByNameOrCode($this->getGET()->q);

		foreach ($objects as $object) {
			try {
				$json = array();
				$json['value'] = $object->id;
				$json['name'] = $object->getName();
				$json['code'] = $object->getCode();
				$json['class'] = $object->getClass();
				$json['price'] = is_object($object->getPriceByMinQuantity()) ? 'no price' : $object->getPriceByMinQuantity();
				$json['basePrice'] = is_object($object->getBasePriceByMinQuantity()) ? 'no basePrice' : $object->getBasePriceByMinQuantity();
				if($json['basePrice'] == null)
					$json['basePrice'] = '0';
				$json['availability'] = $object->getTotalAvailability();
				$json['name'] .= ' ('.$json['code'] = $object->getCode().') '.$json['price'].' / <font color="#999">'.$json['basePrice'].'</font>, <font color="magenta">в наличии '.$json['availability'].' шт.</font>';
			} catch (\exceptions\ExceptionPrice $exc) {
				$json['price'] =  'no price';
				$json['basePrice'] =  'no basePrice';
			}
			$data[] = $json;
		}

		if (!isset($data)) {
			$data[0]['value'] = 'no value';
			$data[0]['name'] = 'Результатов не найдено';
			$data[0]['code'] = 'no code';
			$data[0]['price'] = 'no price';
			$data[0]['basePrice'] = 'no basePrice';
		}

		echo json_encode($data);
	}

	protected function addOrder($post)
	{
		$orderItems = new $this->objectsClass();
		$moduleId = $this->getModuleIdByGood($post);
		$domain = $this->getDomainsByModuleId($moduleId)->current();
		$data = array(
			'statusId'  => 1,
			'managerId' => $this->getAuthorizatedUser()->id,
			'moduleId'  => $moduleId,
			'domain'    => $domain
		);
		return $orderItems->add($data);
	}

	private function getModuleIdByGood($post)
	{
		$modules = $this->getObject('\modules\modulesDomain\lib\ModulesDomain');
		$modules->setSubquery(' AND `objectClass` = \'?s\' ', $post->class);

		return ($modules->count() == 1 ) ? $modules->current()->id : 0 ;
	}

	protected function addGood($orderId, $post)
	{
		$catalogGood = $this->getObject($post->class, $post->goodId);
		$orderGoods = $this->getObject('\modules\orderProcessing\orderProcessingGoods\lib\OrderProcessingGoods');
		$data = array(
			'orderId'   => $orderId,
			'goodId'    => $catalogGood->id,
			'quantity'  => $catalogGood->getMinQuantity(),
			'price'     => $catalogGood->getPriceByQuantity($catalogGood->getMinQuantity()),
			'basePrice' => $catalogGood->getBasePriceByQuantity($catalogGood->getMinQuantity()),
			'class'     => $post->class,
		);
		return $orderGoods->add($data);
	}

	protected function firstAddingGoods()
	{
		$orderId = $this->addOrder($this->getPOST());
		$order = $this->getOrderObject($orderId);
		if (is_int($order->id)) {
			$this->addGood($order->id, $this->getPOST());
		} else
			throw new Exception ('Error with adding good in order');

		$this->ajaxResponse($orderId);
	}

	protected function secondAddingGoods()
	{
		$this->ajaxResponse($this->addGood($this->getPOST()->orderId, $this->getPOST()));
	}

	protected function getOrderGoodsByOrderId($orderId)
	{
		$orderGoods = $this->getObject('\modules\orderProcessing\orderProcessingGoods\lib\OrderProcessingGoods');
		$orderGoods->setSubquery( ' AND `orderId` = ?d ', $orderId );
		return $orderGoods;
	}

	protected function getOrderGoodsTable($orderId)
	{
		$this->setContent('goods', $this->getOrderGoodsByOrderId($orderId))
			 ->setContent('order', $this->getObject($this->objectClass, $orderId))
			 ->includeTemplate('orderGoods');
	}

	public function ajaxGetOrderGoodsTable()
	{
		echo $this->getOrderGoodsTable($this->getGET()->orderId);
	}

	protected function getIncompleteOrders()
	{
		$orders = $this->getObject($this->objectsClass);
		$orders->setSubquery(' AND `statusId` = ?d ', $this->statusIncomplete)->setOrderBy(' `date` DESC ');
		return $orders;
	}

	protected function getIncompleteOrdersTable()
	{
		$this->setContent('orders', $this->getIncompleteOrders())
			 ->includeTemplate('incompleteOrders');
	}

	public function ajaxGetIncompleteOrdersTable()
	{
		echo $this->getIncompleteOrdersTable();
	}

	public function getIncompleteOrderLink()
	{
		$this->setContent('orders', $this->getIncompleteOrders())
			 ->includeTemplate('incompleteOrdersInTop');
	}

	protected function editGood()
	{
		$post  = $this->getPOST();
		$order = $this->getObject($this->objectClass, $this->getGET()->orderId);
		$good  = $order->getGoods()->getObjectById($this->getGET()->goodId);
		$this->ajaxResponse($good->edit($post));
	}

	protected function deleteGood()
	{
		$order = $this->getObject($this->objectClass, $this->getGET()->orderId);
		$good  = $order->getGoods()->getObjectById($this->getGET()->goodId);
		$this->ajaxResponse($good->delete());
	}

	protected function addPromo($post){
		$order = $this->getOrderObject($post->orderId);
		$promoCodes = new \modules\promoCodes\lib\PromoCodes();
		$promoObject = $promoCodes->getPromoCodeByCode((string)$post->promoCode);
		return $order->edit(array('promoCodeId'=>$promoObject->id, 'promoCodeDiscount'=>$promoObject->discount));
	}

	public function ajaxAddPromo()
	{
		$this->ajaxResponse($this->addPromo($this->getPOST()));
	}

	protected function deletePromo($orderId)
	{
		$order = $this->getOrderObject($orderId);
		return $order->edit(array('promoCodeId'=>0, 'promoCodeDiscount'=>0));
	}

	public function ajaxDeletePromo()
	{
		$this->ajaxResponse($this->deletePromo($this->getGET()->orderId));
	}

	protected function editOrder()
	{
		$order = $this->getObject($this->objectClass, $this->getGET()->orderId);
		$this->ajaxResponse($order->edit($this->getPOST()));
	}

	protected function getDomainsTable($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$moduleDomains = $this->getDomainsByModuleId($order->moduleId);
		$this->setContent('moduleDomains', $moduleDomains)
			 ->setContent('order', $order)
			 ->includeTemplate('domains');
	}

	private function getDomainsByModuleId($moduleId)
	{
		$domains = $this->getController('ModulesDomain')->getDomainsByDomainId($moduleId);
		return ($domains)
						? new \core\ArrayWrapper($domains)
						: $this->getAllDomains();
	}

	private function getAllDomains()
	{
		$domains = $this->getController('ModulesDomain')->getAllDomains();
		foreach($domains as $domain=>$alias)
			$domainsArray[] = $domain;
		return new \core\ArrayWrapper($domainsArray);
	}

	public function ajaxGetDomainsTable()
	{
		echo $this->getDomainsTable($this->getGET()->orderId);
	}

	protected function getDeliveryTable($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$deliveries = new \modules\deliveries\lib\Deliveries;
		$categories = $deliveries->getCategories();
		if ($order->domain)
			$categories->setSubquery(' AND `parentId` = ( SELECT `id` FROM `'.$categories->mainTable().'` WHERE `alias` = \'?s\' ) ', $order->domain);

		$this->setContent('deliveriesCategories', $categories)
			 ->setContent('order', $order)
			 ->includeTemplate('deliveries');
	}

	public function ajaxGetDeliveryTable()
	{
		echo $this->getDeliveryTable($this->getGET()->orderId);
	}

	protected function getDeliveryContentByDeliveryCategoryId($categoryId, $orderId)
	{
		$order = $this->getOrderObject($orderId);
		$deliveries = new \modules\deliveries\lib\Deliveries();
		$deliveries->setSubquery(' AND `categoryId`=?d ', $categoryId);
		$this->setContent('deliveries', $deliveries)
			 ->setContent('order', $order)
			 ->setContent('categoryId', $categoryId)
			 ->includeTemplate('delivery');
	}

	protected function getDeliveryDataByDeliveryId()
	{
		$order = $this->getOrderObject($this->getGET()->orderId);
		$delivery = $this->getPOST()->deliveryId ? $this->getObject('\modules\deliveries\lib\Delivery', $this->getPOST()->deliveryId) : $this->getNoop() ;

		$data = array(
			'deliveryId' => $delivery->id,
			'deliveryPrice' => $delivery->price
		);
		$order->edit($data);

		if (!$this->getPOST()->deliveryId){
			echo '';
			return;
		}

		$this->setContent('order', $order)
			 ->setContent('delivery', $delivery)
			 ->includeTemplate('deliveryDetails');
	}

	protected function getDeliveryDataByOrderId($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$delivery = $this->getObject('\modules\deliveries\lib\Delivery', $order->deliveryId);

		$this->setContent('order', $order)
			 ->setContent('delivery', $delivery)
			 ->includeTemplate('deliveryDetails');
	}

	protected function getResultPriceBlock($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$this->setContent('order', $order)
			 ->includeTemplate('resultPriceBlock');
	}

	public function ajaxGetResultPriceBlock()
	{
		echo $this->getResultPriceBlock($this->getGET()->orderId);
	}

	protected function getClientDataBlock($orderId)
	{
		$order = $this->getOrderObject($orderId);
		if ( !$order->deliveryId ) {
			return '';
		}
		$this->setContent('order', $order)
			 ->includeTemplate('clientDataBlock');
	}

	public function ajaxGetClientDataBlock()
	{
		echo $this->getClientDataBlock($this->getGET()->orderId);
	}

	protected function getClientDetailsBlock($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$this->setContent('order', $order)
			 ->includeTemplate('clientDetailsBlock');
	}

	public function ajaxGetClientDetailsBlock()
	{
		echo $this->getClientDetailsBlock($this->getGET()->orderId);
	}

	public function ajaxSearchClient()
	{
		$search = explode(' ', $this->getGET()->q);
		$clients = $this->getObject('\modules\clients\lib\Clients');
		$query = ' AND (';
		foreach ( $search as $word ) {
			$query .= '
					(
					 (
						`phone` LIKE \'%'.$word.'%\' OR
						`company` LIKE \'%'.$word.'%\' OR
						`surname` LIKE \'%'.$word.'%\' OR
						`name` LIKE \'%'.$word.'%\' OR
						`patronimic` LIKE \'%'.$word.'%\'
					 ) OR
					`id` IN (
						SELECT `id` FROM `tbl_user_logins` WHERE `login`  LIKE \'%'.$word.'%\'
					 )
				)
			AND';

		}
		$query = substr($query, 0, -3);
		$query .=')';
		$clients->setSubquery($query);

		foreach ($clients as $object) {
			try {
				$json = array();
				$json['value'] = $object->id;
				$json['name'] = $object->getLogin();
				$json['code'] = $object->getAllName().' ['.$object->phone.'] ';
				if( empty($json['basePrice']) )
					$json['basePrice'] = '0';
			} catch (\exceptions\ExceptionPrice $exc) {
				$json['price'] =  'no price';
				$json['basePrice'] =  'no basePrice';
			}
			$data[] = $json;
		}

		if (!isset($data)) {
			$data[0]['value'] = 'no value';
			$data[0]['name'] = 'Результатов не найдено';
			$data[0]['code'] = 'no code';
			$data[0]['price'] = 'no price';
			$data[0]['basePrice'] = 'no basePrice';
		}

		echo json_encode($data);
	}

	protected function saveClientInOrder()
	{
		$order = $this->getObject($this->objectClass, $this->getPOST()->orderId);
		$user  = $this->getObject('\modules\clients\lib\Client', $this->getPOST()->clientId);

		$data = array(
			'clientId' => $user->id,

			'company' => $user->company,
			'email'   => $user->getLogin(),
			'phone'   => $user->phone,
			'mobile'  => $user->mobile,

			'surname'    => $user->surname,
			'name'       => $user->name,
			'patronimic' => $user->patronimic,

			'country' => $user->deliveryCountry,
			'region'  => $user->deliveryRegion,
			'city'    => $user->deliveryCity,
			'street'  => $user->deliveryStreet,
			'home'    => $user->deliveryHome,
			'block'   => $user->deliveryBlock,
			'flat'    => $user->deliveryFlat,
			'index'   => $user->deliveryIndex,
		);
		$this->ajaxResponse($order->edit($data));
	}

	protected function getClientFound($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$client = ($order->clientId) ? $this->getObject('\modules\clients\lib\Client', $order->clientId) : $this->getNoop();

		$this->setContent('client', $client)
			 ->includeTemplate('clientFound');

	}

	public function ajaxGetClientFound()
	{
		echo $this->getClientFound($this->getGET()->orderId);
	}

	public function ajaxDeleteClient()
	{
		$this->ajaxResponse($this->deleteClient($this->getGET()->orderId));
	}

	protected function deleteClient($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$orderData = array(
			'clientId' => 0,
			'company' => '', 'email'   => '', 'phone'      => '', 'mobile'  => '',
			'surname' => '', 'name'    => '', 'patronimic' => '', 'index'   => '',
			'country' => '', 'region'  => '', 'city'       => '', 'street'  => '',
			'home'    => '', 'block'   => '', 'flat'       => ''
		);

		return $order->edit($orderData);
	}

	public function ajaxSaveOrder()
	{
		$this->checkoutOrder($this->getGET()->orderId);
	}

	public function checkoutOrder($orderId)
	{
		$orderProcessing = $this->getOrderObject($orderId);
		$orders = $this->getObject('\modules\orders\lib\Orders');

		$orderData = array_merge(array(
			'categoryId'      => 3,
			'statusId'        => 1,
			'paymentStatusId' => 1,
			'moduleId' => $orderProcessing->moduleId,
			'domain'   => $orderProcessing->domain,
			'clientId' => $this->getClientId($orderId),
			'person'  => $orderProcessing->surname.' '.$orderProcessing->name.' '.$orderProcessing->patronimic,

			'phone'   => $orderProcessing->phone,
			'date' => date('d-m-Y'),

			'deliveryId'    => $orderProcessing->deliveryId,
			'deliveryPrice' => $orderProcessing->deliveryPrice,
			'deliveryDate'  => $orderProcessing->deliveryDate,
			'deliveryTime'  => $orderProcessing->deliveryTime,

			'promoCodeId'    => $orderProcessing->promoCodeId,
			'promoCodeDiscount' => $orderProcessing->promoCodeDiscount,
			'nr' => '',
			'type'     => 'fromAdmin',
			'addedBy'     => $this->getAuthorizatedUser()->getLogin()
		),  $this->getAddressData($orderProcessing->id));

		$orderId = $this->setObject($orders)->modelObject->add($orderData);
		if(is_int($orderId)) {
			if($this->addGoodsToFinalOrder($orderId, $orderProcessing))
				$order = $this->getObject('\modules\orders\lib\Order', $orderId)->mailNewOrderToManagers();
			$orderProcessing->edit(array('statusId'=>$this->statusComplete));
		}

		$this->ajax($orderId, 'ajax', true);
	}

	private function getAddressData($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$deliveryData = array(
			'country' => $order->country,
			'region'  => $order->region,
			'city'    => $order->city,
			'street'  => $order->street,
			'home'    => $order->home,
			'block'   => $order->block,
			'flat'    => $order->flat,
			'index'   => $order->index,
		);
		if (!$order->getDelivery()->flexibleAddress) {
			$deliveryData['country'] = $order->country?$order->country:'---';
			$deliveryData['region']  = $order->region?$order->region:'---';
			$deliveryData['block']   = $order->block?$order->block:'---';
			$deliveryData['flat']    = $order->flat?$order->flat:'---';
			$deliveryData['city']    = $order->city?$order->city:'---';
			$deliveryData['street']    = $order->street?$order->street:'---';
			$deliveryData['home']    = $order->home?$order->home:'---';
		}

		return $deliveryData;
	}


	private function addGoodsToFinalOrder($orderId, $orderProcessing)
	{
		$orderGoods = new \modules\orders\orderGoods\lib\OrderGoods();
		foreach($orderProcessing->getGoods() as $good){
			$goodData['orderId']   = $orderId;
			$goodData['goodId']    = $good->goodId;
			$goodData['quantity']  = $good->getQuantity();
			$goodData['price']     = $good->getPrice();
			$goodData['basePrice'] = ( $good->getBasePrice() ) ? $good->getBasePrice() : 0.0000001;

			if(!is_int($orderGoods->add($goodData)))
				return false;
		}
		return true;
	}

	public function ajaxCheckoutOrder()
	{
		$clientId = $this->getClientId($this->getGET()->orderId);

		if ( !is_object($clientId) ) {
			$this->ajaxResponse((int)$clientId);
		}
	}

	private function getClientId($orderId)
	{
		$order = $this->getOrderObject($orderId);
		return ( $order->clientId ) ? $order->clientId : $this->createClient($order->id);
	}

	private function createClient($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$clients = $this->getObject('\modules\clients\lib\Clients');
		$nextId = $clients->getNextId();

		$data = array_merge(
					array_merge(
						array(
							'statusId'   => 1,
							'name'       => $order->name,
							'company'    => $order->company,
							'patronimic' => $order->patronimic,
							'surname'    => ($order->surname)?$order->surname:' ',
							'phone'      => $order->phone,
							'mobile'     => $order->mobile,
						), $this->getAddressData($orderId)
					), $this->getDeliveryData($orderId)
				);

		$login = ($order->email)?$order->email:'client'.$nextId.'@test.test';

		$objectId =  $this->setObject($clients)->modelObject->setLogin($login)
							 ->setPassword($nextId, $nextId)
							 ->add($data);

		$order->edit(array('clientId'=>$objectId));

		return $this->ajax($objectId, 'ajax', true);
	}

	private function getDeliveryData($orderId)
	{
		$order = $this->getOrderObject($orderId);
		$deliveryData = array(
			'deliveryPerson'  => $order->surname.' '.$order->name.' '.$order->patronimic,
			'deliveryCountry' => $order->country,
			'deliveryRegion'  => $order->region,
			'deliveryCity'    => $order->city,
			'deliveryStreet'  => $order->street,
			'deliveryHome'    => $order->home,
			'deliveryBlock'   => $order->block,
			'deliveryFlat'    => $order->flat,
			'deliveryIndex'   => $order->index,
			'deliveryDate'    => $order->deliveryDate,
			'deliveryTime'    => $order->deliveryTime,
		);
		if (!$order->getDelivery()->flexibleAddress) {
			$deliveryData['deliveryCountry'] = $order->country?$order->country:'---';
			$deliveryData['deliveryRegion']  = $order->region?$order->region:'---';
			$deliveryData['deliveryBlock']   = $order->block?$order->block:'---';
			$deliveryData['deliveryFlat']    = $order->flat?$order->flat:'---';
			$deliveryData['deliveryCity']    = $order->city?$order->city:'---';
			$deliveryData['deliveryStreet']  = $order->street?$order->street:'---';
			$deliveryData['deliveryHome']    = $order->home?$order->home:'---';
		}

		return $deliveryData;
	}

	protected function getOrderSummary($orderId)
	{
		$order = $this->getOrderObject($orderId);
		if ( !$order->clientId ) {
			return '';
		}
		$this->setContent('order', $order)
			 ->includeTemplate('summary/totalSummary');

	}

	public function ajaxGetOrderSummary()
	{
		echo $this->getOrderSummary($this->getGET()->orderId);
	}

	private function getGoodsSummaryBlock()
	{
		$this->includeTemplate('summary/goodsSummary');
	}

	private function getDeliverySummaryBlock()
	{
		$this->includeTemplate('summary/deliverySummary');
	}

	private function getContactsSummaryBlock()
	{
		$this->includeTemplate('summary/contactsSummary');
	}

	protected function deleteOrder($orderId)
	{
		return $this->getOrderObject($orderId)->delete();
	}

	public function ajaxDeleteOrder()
	{
		$this->ajaxResponse($this->deleteOrder($this->getREQUEST()[0]));
	}
}