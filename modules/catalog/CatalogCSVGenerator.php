<?php
namespace modules\catalog;
class CatalogCSVGenerator
{
	private $_partnerId;
	private $_fabricatorId;
	private $_catalogObjects = array();

	public function __construct($partnerId, $fabricatorId = null)
	{
		$this->setFabricatorId($fabricatorId)
			 ->setPartnerId($partnerId);
	}

	private function setPartnerId($partnerId)
	{
		$this->_partnerId = (int)$partnerId;
		if (empty($this->_partnerId))
			throw new \Exception('PartnerID is empty in class "'.  get_class($this).'"!');
		return $this;
	}

	private function setFabricatorId($fabricatorId)
	{
		$this->_fabricatorId = (int)$fabricatorId;
		return $this;
	}

	protected function getPartnerId()
	{
		return $this->_partnerId;
	}

	protected function getFabricatorId()
	{
		return $this->_fabricatorId;
	}

	public function setObjects(catalog\lib\Catalog $catalog)
	{
		$this->_catalogObjects[] = $catalog;
		return $this;
	}

	public function downloadCSVFile()
	{
		$now = gmdate("D, d M Y H:i:s");
		header("Cache-Control: max-age=0, no-cache, must-revalidate, proxy-revalidate");
		header("Last-Modified: ".$now." GMT");
		header("Content-Type: application/force-download");
		header("Content-Type: application/octet-stream");
		header("Content-Type: application/download");
		header("Content-Transfer-Encoding: binary");
		header("Content-Disposition: attachment; filename=\"".$this->getFilename()."\"");

		print($this->getCSVContent());
		return true;
	}

	protected function sendHeaders()
	{
		$now = gmdate("D, d M Y H:i:s");
		header("Cache-Control: max-age=0, no-cache, must-revalidate, proxy-revalidate");
		header("Last-Modified: ".$now." GMT");
		header("Content-Type: application/force-download");
		header("Content-Type: application/octet-stream");
		header("Content-Type: application/download");
		header("Content-Transfer-Encoding: binary");
		header("Content-Disposition: attachment; filename=\"".$this->getFilename()."\"");
	}

	protected function getFilename()
	{
		return 'catalog_export_partner-'.$this->getPartnerId().'_fabricator-'.$this->getFabricatorId().'.csv';
	}

	public function getCSVContent()
	{
		$row = array();
		$str = '';
		foreach($this->getCatalogObjects() as $catalog){
			foreach($catalog as $good){
				if ($good->isSubGoodsExists())
					continue;
				$row[] = $good->getCode();
				$row[] = str_replace('&quot;', '', $good->getName());
				$row[] = $good->getPrices()->getPriceByMinQuantity()->getPrice();
				$row[] = $good->getPrices()->getPriceByMinQuantity()->getBasePrices()->getBasePriceByPartnerId($this->getPartnerId())->getBasePrice();
				$row[] = $good->getAvailabilityList()->getAvailabilityByPartnerId($this->getPartnerId())->getQuantity();

				$str .= implode(";", $row);
				$str .= ";\r\n";
				$row = array();
			}
		}
		print(iconv("utf-8", "windows-1251", $str));
	}

	protected function getCatalogObjects()
	{
		return $this->_catalogObjects;
	}
}