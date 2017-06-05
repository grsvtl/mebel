<?php
namespace modules\clients\lib;
class OrdersDecorator extends \core\modules\base\ModuleDecorator
{
	private $orders;

	function __construct($object)
	{
		parent::__construct($object);
	}

	public function getOrders()
	{
		if (empty($this->orders)){
			$this->orders =  new \modules\orders\lib\Orders();
			$this->orders->setSubquery(' AND `clientId` = ?d ', $this->id);
		}
		return $this->orders;
	}
}
