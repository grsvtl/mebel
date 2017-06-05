<?php
namespace controllers\admin;
use modules\catalog\complects\lib\Complects;

class OrderGoodsAdminController extends \controllers\base\Controller
{
	use	\core\traits\controllers\Rights,
		\core\traits\controllers\Templates,
		\core\traits\controllers\Authorization;

	protected $permissibleActions = array(
		'add',
		'edit',
		'remove',
		'ajaxAddOrderGood',
		'ajaxDeleteOrderGood',
		'getOrderGoodsTableByOrderId',
		'ajaxEditOrderGood',
		'ajaxGetAutosuggestGoods',
		'ajaxGetAutosuggestGoodById',
		'goodsSalesChart',
		'categoriesSalesChart'
	);

	public function  __construct()
	{
		parent::__construct();
		$this->_config = new \modules\orders\orderGoods\lib\OrderGoodConfig();
		$this->objectClass = $this->_config->getObjectClass();
		$this->objectsClass = $this->_config->getObjectsClass();
		$this->objectClassName = $this->_config->getObjectClassName();
		$this->objectsClassName = $this->_config->getObjectsClassName();
	}

	protected function defaultAction()
	{
		return $this->redirect404();
	}

	protected function add()
	{
		$this->checkUserRightAndBlock('orderGoods_add');
		$this->checkUserRightAndBlock('order_edit');
		$objectId =  $this->setObject($this->_config->getObjectsClass())->modelObject->add($this->getPOST(), $this->modelObject->getConfig()->getObjectFields());
		if ($objectId)
			$this->setObject($this->_config->getObjectClass(), $objectId);
		$this->ajax($objectId, 'ajax', true);
	}

	protected function edit()	{

		$this->setObject($this->_config->getObjectClass(), (int)$this->getPOST()['id'])->ajax($this->modelObject->edit($this->getPOST(), $this->modelObject->getConfig()->getObjectFields()), 'ajax', true);
	}


	protected function remove()	{

		if (isset($this->getREQUEST()[0]))
			$objectId = (int)$this->getREQUEST()[0];

		if (!empty($objectId)) {
			$object = $this->getObject($this->objectClass, $objectId);
			$this->ajaxResponse($object->remove());
		}
	}

	protected function ajaxAddOrderGood()
	{
		$this->add();
	}

	protected function ajaxDeleteOrderGood()
	{
		$this->checkUserRightAndBlock('orderGoods_delete');
		$this->getREQUEST()[0] = $this->getPost()['goodId'];
		$this->remove();
	}

	protected function getOrderGoodsTableByOrderId($orderId = null)
	{
		$orderId = empty($orderId) ? $this->getPOST()['orderId'] : $orderId;
		$order = $this->getObject('\modules\orders\lib\Order', $orderId);
		$this->setContent('order', $order)
			 ->setContent('orderGoods', $order->getOrderGoods())
			 ->includeTemplate('orderGoodsTable');
	}

	protected function ajaxEditOrderGood()
	{
		$this->checkUserRightAndBlock('orderGoods_edit');
		$orderGood = $this->getObject($this->objectClass, $this->getPOST()['id']);
		$this->ajaxResponse($orderGood->edit($this->getPost()));
	}

	protected function ajaxGetAutosuggestGoods()
	{
		$objects = \modules\catalog\CatalogFactory::getInstance()->getGoodsByNameOrCode($_GET["q"]);

		foreach($objects as $object){
		    if( !in_array( $object->id, (new Complects())->getIdArrayInModuleObjects() ) ){
                try {
                    $json = array();
                    $json['value'] = $object->id;
                    $json['name'] = $object->getName();
                    $json['code'] = $object->getCode();
                    $json['price'] = $object->getPriceByMinQuantity() ? $object->getNativePriceByMinQuantity() : 'no price' ;
                    $json['basePrice'] = $object->getBasePriceByMinQuantity() ? $object->getBasePriceByMinQuantity() : 'no basePrice';
                    $json['availability'] = $object->getTotalAvailability();
                    if($json['basePrice'] == null)
                        $json['basePrice'] = '0';
                } catch (\exceptions\ExceptionPrice $exc) {
                    $json['price'] =  'no price';
                    $json['basePrice'] =  'no basePrice';
                }
                $data[] = $json;
            }
		}

		if(!isset($data)){
			$data[0]['value'] = 'no value';
			$data[0]['name'] = 'Результатов не найдено';
			$data[0]['code'] = 'no code';
			$data[0]['price'] = 'no price';
			$data[0]['basePrice'] = 'no basePrice';
		}

		echo json_encode($data);
	}

	protected function ajaxGetAutosuggestGoodById()
	{
		$object = \modules\catalog\CatalogFactory::getInstance()->getGoodById($this->getPOST()['goodId']);
		try {
			$json = array();
			$json['quantity'] = $object->getMinQuantity();
			$json['price'] = $object->getPriceByMinQuantity() ? $object->getNativePriceByMinQuantity() : 'no price' ;
			$json['basePrice'] = $object->getBasePriceByMinQuantity() ? $object->getBasePriceByMinQuantity() : 'no basePrice';
			if($json['basePrice'] == null)
				$json['basePrice'] = '0';
		} catch (\exceptions\ExceptionPrice $exc) {
			$json['quantity'] = 'no quantity';
			$json['price'] =  'no price';
			$json['basePrice'] =  'no basePrice';
		}
		echo json_encode($json);
	}

	protected function goodsSalesChart()
	{
		$this->checkUserRightAndBlock('goodsSalesChart');

		$start_date = $this->getGet()['start_date'];
		$end_date = $this->getGet()['end_date'];
		$goodsIds = $this->getGet()['ids'];

		if(empty($start_date)  || empty($end_date)  || empty($goodsIds))
			return $this->setContent('title', 'Динамика продаж по товарам')
					->setContent('noDataRecevied', true)
					->includeTemplate('/reports/goodsSalesChart');

		$this->setObject($this->objectsClass);
		$orderConfig = $this->getObject('\modules\orders\lib\Orders')->getConfig();
		$this->modelObject->setSubquery('AND `orderId` IN (
												SELECT `id`  FROM `'.$this->getObject('\modules\orders\lib\Orders')->mainTable().'`
													WHERE `date` >= ?d
													AND `date` <= ?d
													AND `statusId` != ?d
													AND `statusId` != ?d
											)
											AND  `goodId` IN (?s)
											ORDER BY `goodId`'
									,\core\utils\Dates::convertDate($start_date),
									\core\utils\Dates::convertDate($end_date),
									$orderConfig->canceledStatus,
									$orderConfig->removedStatus,
									$goodsIds
								);

		if(!$this->modelObject->count())
			return $this->setContent('title', 'Динамика продаж c '.$start_date.' по '.$end_date.' по товарам')
					->setContent('noData', true)
					->includeTemplate('/reports/goodsSalesChart');

		$goodId = $this->modelObject->current()->goodId;
		$data = " [' ".$this->getGoodNameById($goodId)." ',  ";
		$count = 0;
		$countAll = 0;
		$orderGoodsIdsAll = '';
		$array = array(
			array(
				'id'=>$goodId,
				'name'=>$this->getGoodNameById($goodId),
				'category'=>$this->getGoodById($goodId)->getCategory()->name,
				'quantity'=>0,
				'orders'=>array(),
				'totalSum'=>0,
				'totalIncome'=>0
			)
		);

		foreach($this->modelObject as $element){
			$countAll += $element->quantity;
			$orderGoodsIdsAll .= $element->id.', ';
			if($element->goodId == $goodId){
				$count += $element->quantity;
				$array[count($array)-1]['quantity'] += $element->quantity;
				$array[count($array)-1]['orders'][] = array('orderId'=>$element->orderId, 'quantity'=>$element->quantity);
				$array[count($array)-1]['totalSum'] += $this->getObject($this->objectClass, $element->id)->getPrice();
				$array[count($array)-1]['totalIncome'] += $this->getObject($this->objectClass, $element->id)->getIncome();
			}
			else{
				$goodId = $element->goodId;
				$data .= $count." ], [' ".$this->getGoodNameById($goodId)." ', ";
				$count = $element->quantity;
				$array[] = array(
					'id'=>$goodId,
					'name'=>$this->getGoodNameById($goodId),
					'category'=>$this->getGoodById($goodId)->getCategory()->name,
					'quantity'=>$element->quantity,
					'orders'=>array(array('orderId'=>$element->orderId, 'quantity'=>$element->quantity)),
					'totalSum'=>$this->getObject($this->objectClass, $element->id)->getPrice(),
					'totalIncome'=>$this->getObject($this->objectClass, $element->id)->getIncome()
				);
			}
		}
		$data .= $count.'] ';

		$this->modelObject->resetFilters()
					->setSubquery('AND `id` IN (?s)', substr($orderGoodsIdsAll, 0, strlen($orderGoodsIdsAll)-2));
		$totalSumAll = $this->modelObject->getTotalSum();
		$totalIncomeAll = $this->modelObject->getIncome();

		$this->setContent('title', 'Динамика продаж c '.$start_date.' по '.$end_date.' по товарам')
			->setContent('countAll', $countAll)
			->setContent('totalSumAll', $totalSumAll)
			->setContent('totalIncomeAll', $totalIncomeAll)
			->setContent('dataArray', $array)
			->setContent('data', $data)
			->includeTemplate('/reports/goodsSalesChart');

	}

	private function getGoodNameById($id)
	{
		return $this->getGoodById($id)->getName();
	}

	private function getGoodById($id)
	{
		return \modules\catalog\CatalogFactory::getInstance()->getGoodById($id);
	}

	protected function categoriesSalesChart()
	{
		$this->checkUserRightAndBlock('categoriesSalesChart');

		$start_date = $this->getGet()['start_date'];
		$end_date = $this->getGet()['end_date'];
		$categoriesIds = $this->getGet()['catids'];
		$catalogType = $this->getGet()['catalogType'];

		if(empty($start_date)  || empty($end_date)  || empty($categoriesIds))
			return $this->setContent('title', 'Динамика продаж по категориям')
					->setContent('noDataRecevied', true)
					->includeTemplate('/reports/goodsSalesChart');

		$this->setObject($this->objectsClass);
		$orderConfig = $this->getObject('\modules\orders\lib\Orders')->getConfig();
		$this->modelObject->setSubquery('AND `orderId` IN (
												SELECT `id`  FROM `'.$this->getObject('\modules\orders\lib\Orders')->mainTable().'`
													WHERE `date` >= ?d
													AND `date` <= ?d
													AND `statusId` != ?d
													AND `statusId` != ?d
											)
											AND  `goodId` IN (
												SELECT `id`  FROM `'.$this->getObject('\modules\catalog\\'.$catalogType.'\lib\\'.ucfirst($catalogType))->mainTable().'`
													WHERE `categoryId` IN (?s)
													ORDER BY `categoryId`
											)
											ORDER BY `goodId`'
									,\core\utils\Dates::convertDate($start_date),
									\core\utils\Dates::convertDate($end_date),
									$orderConfig->canceledStatus,
									$orderConfig->removedStatus,
									$categoriesIds
								);

		if(!$this->modelObject->count())
			return $this->setContent('title', 'Динамика продаж c '.$start_date.' по '.$end_date.' по категориям')
					->setContent('noData', true)
					->includeTemplate('/reports/goodsSalesChart');

		$countAll = 0;
		$orderGoodsIdsAll = '';
		$count = 0;
		$array = array();
		$data = array();
		foreach($this->modelObject as $element){
			$countAll += $element->quantity;
			$orderGoodsIdsAll .= $element->id.', ';
			$categoryId = $this->getGoodById($element->goodId)->getCategory()->id;
			if(isset($array[$categoryId])){
					$array[$categoryId]['quantity'] += $element->quantity;
					$array[$categoryId]['totalSum'] +=  $this->getObject($this->objectClass, $element->id)->getPrice();
					$array[$categoryId]['totalIncome'] +=  $this->getObject($this->objectClass, $element->id)->getIncome();
					$data[$categoryId]['quantity'] += $element->quantity;
//					$array[$categoryId]['orders'][$element->orderId] =  array('orderId'=>$element->orderId, 'quantity'=>$element->quantity);
					if(isset($array[$categoryId]['orders'][$element->orderId]))
						$array[$categoryId]['orders'][$element->orderId]['quantity'] += $element->quantity;
					else
						$array[$categoryId]['orders'][$element->orderId] =  array('orderId'=>$element->orderId, 'quantity'=>$element->quantity);
			}
			else{
				$array[$categoryId] = array(
					'id'=>$categoryId,
					'name'=>$this->getGoodById($element->goodId)->getCategory()->name,
					'category'=>$this->getGoodById($element->goodId)->getCategory()->getParent()->name,
					'quantity'=>$element->quantity,
					'orders'=>array($element->orderId=>array('orderId'=>$element->orderId, 'quantity'=>$element->quantity)),
					'totalSum'=>$this->getObject($this->objectClass, $element->id)->getPrice(),
					'totalIncome'=>$this->getObject($this->objectClass, $element->id)->getIncome()
				);
				$data[$categoryId] = array(
					'name' => $this->getGoodById($element->goodId)->getCategory()->name,
					'quantity' =>$element->quantity,
					'category'=>$this->getGoodById($element->goodId)->getCategory()->getParent()->name
				);
			}
		}

		$dataString = '';
		foreach($data as $key){
			$dataString = $dataString." [' ".$key['name']." (".$key['category'].") ',  ".$key['quantity']." ] ";
			if($key !== end($data))
				$dataString = $dataString.", ";
		}

		$this->modelObject->resetFilters()
					->setSubquery('AND `id` IN (?s)', substr($orderGoodsIdsAll, 0, strlen($orderGoodsIdsAll)-2));
		$totalSumAll = $this->modelObject->getTotalSum();
		$totalIncomeAll = $this->modelObject->getIncome();

		$this->setContent('title', 'Динамика продаж c '.$start_date.' по '.$end_date.' по категориям')
			->setContent('countAll', $countAll)
			->setContent('totalSumAll', $totalSumAll)
			->setContent('totalIncomeAll', $totalIncomeAll)
			->setContent('dataArray', $array)
			->setContent('data', $dataString)
			->includeTemplate('/reports/goodsSalesChart');
	}
}
