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

	public function filterActive()
    {
        $config = $this->getObjectConfig();
        $this->setSubquery('AND `statusId`=?d', $config::ACTIVE_STATUS_ID);
        return $this;
    }

	public function filterByDomainInfoId($domainInfoId)
    {
        $this->setSubquery('AND `domainInfoId`=?d', $domainInfoId);
        return $this;
    }
}