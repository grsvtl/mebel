<?php
namespace modules\catalog\availability\automaticUpdates;
class Updater
{
	use \core\traits\ObjectPool;

	private $updateUserId   = 130;
	private $resultUpdating = array();
	private $unknownGoods   = array();
	private $parser;

	public function __construct($parser)
	{
		$this->setParser($parser);
	}

	private function setParser($parser)
	{
		if (!is_subclass_of($parser, '\modules\catalog\availability\automaticUpdates\BaseParser'))
			throw new \Exception('Passed object is not implement abstract class Parser in class '.get_class($this).'!');
		$this->parser = $parser;
		return $this;
	}

	public function startAvailabilityUpdate()
	{
		return $this->baseUpdate();
	}

	protected function baseUpdate($type = 'availability')
	{
		foreach($this->parser as $updateGood){
			$good = \modules\catalog\CatalogFactory::getInstance()->getGoodByCode($updateGood->getCode());
			$resultArray = array(
				'goodCode'  => $updateGood->getCode(),
				'quantity'  => $updateGood->getQuantity(),
				'price'     => $updateGood->getPrice(),
				'salePrice' => $updateGood->getSalePrice(),
				'name'      => $updateGood->getName(),
			);

			if (is_object($good)) {
				$method = $type.'Update';
				$result = $this->$method($good, $updateGood);
				$this->setResult($updateGood->getCode(), $updateGood->getName(), $method, $result);
			} else {
				$this->setUnknownGood($updateGood->getCode(), $updateGood->getName());
			}
		}
		return $this;
	}

	protected function setResult($goodCode, $name, $action, $result)
	{
		$this->resultUpdating[$goodCode][$action] = (bool)$result;
		$this->resultUpdating[$goodCode]['name']  = iconv("windows-1251", "utf-8", $name);
		return $this;
	}

	protected function setUnknownGood($goodCode, $name)
	{
		$this->unknownGoods[$goodCode] = array(
			'name' => iconv("windows-1251", "utf-8", $name),
			'code' => $goodCode,
		);
		return $this;
	}

	protected function availabilityUpdate($good, $updateGood)
	{
		$availability = $good->getAvailabilityList()->getAvailabilityByPartnerId($this->parser->getPartnerId());
		$availability->quantity   = $updateGood->getQuantity();
		$availability->userId     = $this->updateUserId;
		$availability->lastUpdate = null;
		return $availability->edit();
	}

	protected function priceUpdate($good, $updateGood)
	{
		$basePrice = $good->getPrices()->getPriceByMinQuantity()->getBasePrices()->getBasePriceByPartnerId($this->parser->getPartnerId());

		if($this->isNoop($basePrice)){
			if($updateGood->getPrice() === 0)
				return;
			$basePrice = (new \modules\catalog\basePrices\lib\BasePrices($good->getPrices()))
				->add(
					array(
						'objectId'=>$good->getPrices()->getPriceByMinQuantity()->id,
						'partnerId'=>$this->parser->getPartnerId(),
						'price'=>$updateGood->getPrice(),
						'history'	=> 'from csv'
						)
					);
		}

		if($updateGood->getPrice() === 0)
			return $basePrice->delete();

		$basePrice->price = $updateGood->getPrice();
		return $basePrice->edit();
	}

	protected function salePriceUpdate($good, $updateGood)
	{
		$price = $good->getPrices()->getPriceByMinQuantity();
		$price->price = $updateGood->getSalePrice();
		return $price->edit();
	}

	public function startPriceUpdate()
	{
		return $this->baseUpdate('price');
	}

	public function startSalePriceUpdate()
	{
		return $this->baseUpdate('salePrice');
	}

	public function getResultUpdating()
	{
		return $this->resultUpdating;
	}

	public function getUnknownGoods()
	{
		return $this->unknownGoods;
	}

	public function startNameUpdate()
	{
		return $this->baseUpdate('name');
	}

	protected function NameUpdate($good, $updateGood)
	{
		return (new \modules\catalog\CatalogFactory($good->id))->edit( array(
			'id'=>$good->id,
			'name'=>iconv("windows-1251", "UTF-8", $updateGood->getName()),
			'code'=>$good->getCode(),
			'class'=>$good->getClass()
		));
	}
}