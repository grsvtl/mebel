<?php
namespace modules\catalog\availability\automaticUpdates;
class PartnerParser extends BaseParser
{
	private $file;
	protected $partnerId;

	public function __construct($filePath, $partnerId)
	{
		$this->file = new \core\files\uploader\File($filePath);
		$this->setPartner($partnerId)
			 ->setAvailabiliteUpdateGoods($this->parseFile());
	}

	private function setPartner($partnerId)
	{
		$this->partnerId = (int)$partnerId;
		if (empty($this->partnerId))
			throw new \Exception('Empty partnerID in class "'.get_class($this).'"');
		return $this;
	}

	public function getPartnerId(){
		return $this->partnerId;
	}

	private function parseFile()
	{
		$fileContent = $this->file->getFileContent();
		$rows = explode("\r\n", $fileContent);
		foreach ($rows as $key => $value){
			$rows[$key] =  explode(';', $value);
		}
		return $rows;
	}

	private function setAvailabiliteUpdateGoods($csvDataArray)
	{
		foreach($csvDataArray as $good){
			if (!empty($good[0]) && !empty($good[1]) && !empty($good[2])){
				if(!is_numeric($good[3]) || empty($good[3]))
					$good[3] = 0;
				$this->availabiliteUpdateGoods[] = new AvailabiliteUpdateGood($good[0], $good[3], $good[4], $good[2], $good[1]);
			}
		}
		return $this;
	}
}