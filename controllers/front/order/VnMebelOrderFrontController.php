<?php
namespace controllers\front\order;

class VnMebelOrderFrontController extends \controllers\front\order\MainOrderFrontController
{
    protected $permissibleActions = array(
        'add',
        'sendOrderByOneClick',
    );

    protected function add()
    {
        $shopcart = $this->getController('shopcart')->getShopcart();
        $returnArray = [
            'orderSum' => $shopcart->getTotalPrice(),
            'orderName' => $this->getPOST()['family'].' '.$this->getPOST()['name'].' '.$this->getPOST()['parentName'],
            'orderPhone' => $this->getPOST()['phone'],
            'orderEmail' => $this->getPOST()['email']
        ];

        $mail = new \modules\shopcart\lib\MailShopcart($shopcart);

        $res = $this->setObject($mail)
            ->modelObject->MailShopcartToAdmin();

        if($res == 1){
            $this->getController('shopcart')->resetShopcart();
            return $this->ajaxResponse($returnArray);
        }

        return $this->ajaxResponse($this->modelObject->getErrors());
    }
}
