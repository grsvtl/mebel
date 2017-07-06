<?php
namespace controllers\admin;

use modules\catalog\reviews\lib\ReviewConfig;

class ReviewsAdminController extends \controllers\base\Controller
{
    use	\core\traits\controllers\Rights,
        \core\traits\controllers\Authorization,
        \core\traits\controllers\Templates;

    protected $permissibleActions = array(
        'edit',
        'getReviewsTable',
        'addReviewBlock'
    );

    public function  __construct()
    {
        parent::__construct();
        $this->_config = new ReviewConfig();
        $this->objectClass = $this->_config->getObjectClass();
        $this->objectsClass = $this->_config->getObjectsClass();
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
        $order = $this->getObject($this->objectClass, $this->getGET()->orderId);
        $good  = $order->getGoods()->getObjectById($this->getGET()->goodId);
        $this->ajaxResponse($good->delete());
    }

    protected function getReviewsTable($domainInfo)
    {
        $this->setContent('reviews', $domainInfo->getReviews())
            ->includeTemplate('reviewsTable');
    }

    protected function addReviewBlock()
    {
        $this->includeTemplate('addReviewBlock');
    }


}