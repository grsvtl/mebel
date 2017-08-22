<?php
namespace controllers\front;

use modules\catalog\domainsInfo\lib\DomainInfo;
use modules\catalog\reviews\lib\Review;
use modules\mailers\AddReviewMail;

class ReviewFrontController extends \controllers\front\order\MainOrderFrontController
{
    protected $permissibleActions = array(
        'ajaxAdd'
    );

    public function  __construct()
    {
        parent::__construct();
        $this->_config = new \modules\catalog\reviews\lib\ReviewConfig();
        $this->objectClass = $this->_config->getObjectClass();
        $this->objectsClass = $this->_config->getObjectsClass();
        $this->objectClassName = $this->_config->getObjectClassName();
        $this->objectsClassName = $this->_config->getObjectsClassName();
    }

    protected function ajaxAdd()
    {
        $config = $this->_config;
        $post = $this->getPOST();
        $post['statusId'] = $config::BLOCKED_STATUS_ID;
        $objectId =  $this->setObject($config->getObjectsClass())->modelObject->add($post, $this->modelObject->getConfig()->getObjectFields());
        if(!$objectId)
            return $this->ajaxResponse($this->modelObject->getErrors());
        $post['review'] = new Review($objectId);
        $post['catalogObjectInfo'] = new DomainInfo($post->domainInfoId);
        $post['cataloObject'] = $post['catalogObjectInfo']->getGood();
        $this->ajaxResponse( $this->setObject(new AddReviewMail($post))->modelObject->MailToAdmin() );
    }
}
