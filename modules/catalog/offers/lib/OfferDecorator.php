<?php
namespace modules\catalog\offers\lib;
class OfferDecorator extends \core\modules\base\ModuleDecorator
{
	function __construct($object)
	{
		parent::__construct($object);
	}

	public function getOffer()
	{
        $offers = new \modules\catalog\offers\lib\Offers;
        return $offers->getValidOfferByGoodId($this->id);
	}
}
