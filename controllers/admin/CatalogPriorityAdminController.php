<?php
namespace controllers\admin;
use modules\catalog\catalog\lib\CatalogItem;
use modules\catalog\priority\CatalogPriorityGenerator;

class CatalogPriorityAdminController extends \controllers\base\Controller
{
	use	\core\traits\controllers\Rights,
		\core\traits\controllers\Templates,
		\core\traits\controllers\Authorization;

	protected $permissibleActions = array(
		'setPriority',
		'setGroupPriority'
	);

	public function  __construct()
	{
		parent::__construct();
	}

    protected function setPriority()
    {
        $good        = new CatalogItem($this->getGET()['goodId']);
        $domainAlias = $this->getGET()['domainAlias'];
        $categoryId  = $this->getGET()['categoryId'];
        $priority    = $this->getGET()['priority'];
        $generator   = new CatalogPriorityGenerator($good, $domainAlias, $categoryId, $priority);

        $this->ajaxResponse( $generator->execute() );
    }

    protected function setGroupPriority()
    {
        $domainAlias = $this->getGET()['domainAlias'];
        $categoryId  = $this->getGET()['categoryId'];

        if ( $this->getGET()['data'] ) {
            foreach ( $this->getGET()['data'] as $objectId=>$priority ) {
                $generator = new CatalogPriorityGenerator(new CatalogItem($objectId), $domainAlias, $categoryId, $priority);
                if ( $generator->execute() === false ) {
                    $this->ajaxResponse(false);
                    return;
                }
            }
        } else {
            $this->ajaxResponse(false);
            return;
        }
        $this->ajaxResponse( true );
    }
}