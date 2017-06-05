<?php
namespace core\traits;
trait UriHandler
{
	protected function getUriElement($position)
	{
		$position = (int)$position;
		if($position == 0) return false;

		$uriArray = $this->getUriArray();

		if($position < 0)
			$uriArray = array_reverse ($uriArray);

		if(isset($uriArray[abs($position) - 1]))
			return $uriArray[abs($position) - 1];

		return false;
	}

	private function getUriArray()
	{
		$uriArray = $this->getClearUriString();

		foreach($uriArray as $key=>$value)
			if(empty($value))
				unset($uriArray[$key]);

		return array_values($uriArray);
	}

	public function getClearUriString()
	{
		return explode('/', strtok($_SERVER["REQUEST_URI"],'?'));
	}

	protected function getLastUriElement()
	{
		return $this->getUriElement(-1);
	}

	protected function getFirstUriElement()
	{
		return $this->getUriElement(1);
	}

	public function getUriLength()
	{
		return count($this->getUriArray());
	}
}