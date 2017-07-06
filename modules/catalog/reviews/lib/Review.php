<?php
namespace modules\catalog\reviews\lib;
class Review extends \core\modules\base\ModuleDecorator
{
	function __construct($objectId)
	{
		$object = new ReviewObject($objectId);
		$object = new \core\modules\statuses\StatusDecorator($object);
        $object = new \core\modules\statuses\StatusesDecorator($object);
		parent::__construct($object);
	}

    public function getName(){return $this->name;}
    public function getAdventages(){return $this->adventages;}
    public function getDisadventages(){return $this->disadventages;}
    public function getText(){return $this->text;}
    public function getEstimate(){return $this->estimate;}
}