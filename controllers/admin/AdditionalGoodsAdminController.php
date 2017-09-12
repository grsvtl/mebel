<?php
namespace controllers\admin;
class AdditionalGoodsAdminController extends \controllers\base\Controller
{
    use \core\traits\controllers\Templates;

    protected $permissibleActions = array(
        'getAdditionalGoodsTable',
        'ajaxGetAdditionalGoodsTable',
        'ajaxAddAdditionalGood',
        'ajaxDeleteAdditionalGood'
    );

    public function __construct()
    {
        parent::__construct();
        $this->_config = new \modules\catalog\additionalGoods\lib\AdditionalGoodConfig();
        $this->objectClass = $this->_config->getObjectClass();
        $this->objectsClass = $this->_config->getObjectsClass();
        $this->objectClassName = $this->_config->getObjectClassName();
        $this->objectsClassName = $this->_config->getObjectsClassName();
    }

    protected function getAdditionalGoodsTable($goodId)
    {
        $good = \modules\catalog\CatalogFactory::getInstance()->getGoodById($goodId);
        $this->setContent('good', $good)
             ->setContent('additionalGoods', $good->getAdditionalGoods())
             ->includeTemplate('additionalGoodsTable');
    }

    protected function ajaxGetAdditionalGoodsTable()
    {
        echo $this->getAdditionalGoodsTable($this->getPost()->goodId);
    }

    protected function ajaxAddAdditionalGood()
    {
        $objectId =  $this->setObject($this->_config->getObjectsClass())->modelObject->add($this->getPOST(), $this->modelObject->getConfig()->getObjectFields());
        $this->ajax($objectId, 'ajax', true);
    }

    protected function ajaxDeleteAdditionalGood()
    {
        $additionalGood = $this->getObject($this->objectClass, $this->getPost()->additionalGoodId);
        $this->ajaxResponse($additionalGood->remove());
    }
}