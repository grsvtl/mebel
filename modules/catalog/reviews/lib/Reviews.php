<?php
namespace modules\catalog\reviews\lib;
class Reviews extends \core\modules\base\ModuleDecorator
{
	function __construct()
	{
		$object = new ReviewsObject();
		$object = new \core\modules\statuses\StatusesDecorator($object);
		parent::__construct($object);
	}

	public function getReviews($domainInfoId)
    {
        return $this
//            ->setSubquery('AND `domainInfoId`=?d', $domainInfoId)
            ;
    }
}