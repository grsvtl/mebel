<?php
namespace controllers\admin;

use modules\catalog\domainsInfo\lib\DomainInfo;
use modules\catalog\reviews\lib\Review;
use modules\catalog\reviews\lib\ReviewConfig;

class ReviewsAdminController extends \controllers\base\Controller
{
    use	\core\traits\controllers\Rights,
        \core\traits\controllers\Authorization,
        \core\traits\controllers\Templates;

    protected $permissibleActions = array(
        'add',
        'edit',
        'delete',
        'getReviewsTable',
        'ajaxGetReviewsTableContent'
    );

    public function  __construct()
    {
        parent::__construct();
        $this->_config = new ReviewConfig();
        $this->objectClass = $this->_config->getObjectClass();
        $this->objectsClass = $this->_config->getObjectsClass();
    }

    protected function add()
    {
        $this->checkUserRightAndBlock('construction_edit');
        $objectId =  $this->setObject($this->_config->getObjectsClass())->modelObject->add($this->getPOST(), $this->modelObject->getConfig()->getObjectFields());
        $this->ajax($objectId);
    }

    protected function edit()
    {
        $this->checkUserRightAndBlock('construction_edit');
        $object = $this->setObject($this->_config->getObjectClass(), (int)$this->getPOST()['id']);
        $edit = $this->modelObject->edit($this->getPOST());
        $object->ajax($edit);
    }

    protected function delete()
    {
        $this->checkUserRightAndBlock('construction_edit');
        $this->ajaxResponse( (new Review($this->getPOST()['id']))->delete() );
    }

    protected function getReviewsTable($domainInfo)
    {
        $this->setContent('domainInfo', $domainInfo)
            ->includeTemplate('reviewsTable');
    }

    protected function getReviewsTableContent($domainInfo)
    {
        $this->setContent('domainInfo', $domainInfo)
            ->includeTemplate('reviewsTableContent');
    }

    protected function ajaxGetReviewsTableContent()
    {
        echo $this->getReviewsTableContent( (new DomainInfo( $this->getPost()['domainInfoId'] )) );
    }
}