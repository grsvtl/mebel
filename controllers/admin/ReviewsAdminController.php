<?php
namespace controllers\admin;

use modules\catalog\reviews\lib\ReviewConfig;

class ReviewsAdminController extends \controllers\base\Controller
{
    use	\core\traits\controllers\Templates;

    protected $permissibleActions = array(
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

    protected function getReviewsTable()
    {
        $this->includeTemplate('reviewsTable');
    }

    protected function addReviewBlock()
    {
        $this->includeTemplate('addReviewBlock');
    }


}