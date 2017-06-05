<?php
namespace modules\orders\lib;
class Order extends \core\modules\base\ModuleDecorator
{
	use \core\traits\RequestHandler;

	private $orderGoods;

	function __construct($objectId)
	{
		$object = new OrderObject($objectId);
		$object = new \core\modules\categories\CategoryDecorator($object);
		$object = new \core\modules\statuses\StatusDecorator($object);
		$object = new \modules\paymentStatuses\PaymentStatusDecorator($object);
		$object = new \core\modules\filesUploaded\FilesDecorator($object);
		parent::__construct($object);
	}

	public function remove ()
	{
		return ($this->delete()) ? (int)$this->id : false ;
	}

	public function getOrderGoods()
	{
		if (empty($this->orderGoods)){
			$orderGoods = new \modules\orders\orderGoods\lib\OrderGoods($this->getParentObject()->promoCodeDiscount);
			$this->orderGoods = $orderGoods->getGoodsByOrderId($this->id);
		}
		return $this->orderGoods;
	}

	public function getClient()
	{
		return $this->clientId
			? $this->getObject('\modules\clients\lib\Client', $this->clientId)
			: $this->getNoop();
	}

	public function getModule()
	{
		return $this->moduleId
			? $this->getObject('\modules\modulesDomain\lib\ModuleDomain', $this->moduleId)
			: $this->getNoop();
	}

	public function getManager()
	{
		return $this->managerId
			? $this->getObject('\modules\administrators\lib\Administrator', $this->managerId)
			: $this->getNoop();
	}

	public function getPartner()
	{
		return $this->partnerId
			? $this->getObject('\modules\partners\lib\Partner', $this->partnerId)
			: $this->getNoop();
	}

	public function getPromoCode()
	{
		return $this->promoCodeId
			? $this->getObject('\modules\promoCodes\lib\PromoCode', $this->promoCodeId)
			: $this->getNoop();
	}

	public function getPromoCodeDiscount()
	{
		return $this->promoCodeDiscount;
	}

	protected function mailNewOrderToManagers()
	{
		$mail = new \modules\mailers\NewOrderManagersMail($this);
		$mail->sendNewOrderManagersMail();
	}

	public function addPromoCode($promoCode)
	{
		$promoCode = (string)$promoCode;
		$promoCodes = new \modules\promoCodes\lib\PromoCodes();
		$promoCode = $promoCodes->getPromoCodeByCode($promoCode);
		if ($this->isNoop($promoCode)){
			$this->setError('promoCode', $this->getErrorsList()['code_failed']);
			return false;
		}
		if ($promoCode->statusId != \modules\promoCodes\lib\PromoCodeConfig::STATUS_ACTIVE){
			$this->addError('promoCode', $this->getErrorsList()['code_blocked']);
			return false;
		}

		return $this->setValue('promoCodeId',       $promoCode->id)
					->setValue('promoCodeDiscount', $promoCode->discount)
					->edit();
	}

	public function removePromoCode()
	{
		return $this->setValue('promoCodeId',       0)
					->setValue('promoCodeDiscount', 0)
					->edit();
	}

	public function getDelivery()
	{
		return $this->deliveryId
			? $this->getObject('\modules\deliveries\lib\Delivery', $this->deliveryId)
			: $this->getNoop();
	}

	public function addDelivery($post)
	{
		$delivery = (int)$post->deliveryId ? new \modules\deliveries\lib\Delivery((int)$post->deliveryId) : $this->getNoop();
		if ($this->isNoop($delivery)){
			$this->setError('deliveryId', $this->getErrorsList()['deliveryId_failed']);
			return false;
		}
		if ($delivery->statusId != \modules\deliveries\lib\DeliveryConfig::ACTIVE_STATUS_ID){
			$this->addError('deliveryId', $this->getErrorsList()['deliveryId_blocked']);
			return false;
		}
		if ( $post->flexibleAddress ) {
			$this->setValue('country', $post->country)
				 ->setValue('region', $post->region)
				 ->setValue('city', $post->city)
				 ->setValue('street', $post->street)
				 ->setValue('home', $post->home)
				 ->setValue('block', $post->block)
				 ->setValue('flat', $post->flat)
				 ->setValue('index', $post->index);
		}

		return $this->setValue('deliveryId',    $delivery->id)
					->setValue('deliveryPrice', $post->deliveryPrice)
					->setValue('deliveryBasePrice', $post->deliveryBasePrice)
					->edit();
	}

	public function removeDelivery()
	{
		return $this->setValue('deliveryId',    0)
				->setValue('deliveryPrice', 0)
				->setValue('deliveryBasePrice', 0)
				->edit();
	}

	public function getTotalSum()
	{
		return  $this->getTotalSumForGoods()+ $this->deliveryPrice;
	}

	public function getTotalSumForGoods()
	{
		return $this->getOrderGoods()->getTotalSum();
	}

	public function getTotalQuantity()
	{
		return $this->orderGoods->getTotalGoodsQuantity();
	}

	public function getTotalBaseSum()
	{
		return round($this->getOrderGoods()->getTotalGoodsBaseSum() + $this->getDeliveryBasePrice());
	}

	private function getDeliveryBasePrice()
	{
		return $this->deliveryBasePrice;
	}

	public function getIncome()
	{
		return round($this->getIncomeWithoutCashRate() - $this->getCashRatePrice());
	}

	public function getIncomeWithoutCashRate()
	{
		return round($this->getTotalSum() - $this->getTotalBaseSum());
	}

	public function getCashRatePrice()
	{
		return round($this->getIncomeWithoutCashRate() / 100 * ($this->cashRate));
	}

	public function getDaysFromRegistration()
	{
		return ($this->date)? \core\utils\Dates::daysBetweenDates($this->date, \core\utils\Dates::getCurrentSimpleDate()):false;
	}

	public function getDaysToDelivery()
	{
		return ($this->deliveryDate && !$this->isCompleted())? \core\utils\Dates::daysBetweenDates(\core\utils\Dates::getCurrentSimpleDate(), $this->deliveryDate):false;
	}

	public function isDelivered()
	{
		return ( $this->deliveryDate && $this->isCompleted() );
	}

	public function isCompleted()
	{
		return $this->statusId == $this->getConfig()->completedStatus;
	}

	public function isPaid()
	{
		return $this->paymentStatusId == $this->getConfig()->paidStatus;
	}

	public function getDeliveryAddressString()
	{
		if ( $this->getDelivery()->flexibleAddress ) {
			$region = $this->region?', '.$this->region:'';
			$city   = $this->city?', '.$this->city:'';
			$index  = $this->index?', индекс '.$this->index:'';
			$street = $this->street?', '.$this->street:'';
			$home   = $this->home?', д. '.$this->home:'';
			$block  = $this->block?', корпус '.$this->block:'';
			$flat   = $this->flat?', кв. '.$this->flat:'';

			$address = $this->country.$region.$city.$index.$street.$home.$block.$flat;
		} else {
			$address = $this->getDelivery()->getCategory()->name .' - '. $this->getDelivery()->getName();
		}

		return $address;
	}
}
