<?php
namespace controllers\front\order;

class MeriMebelOrderFrontController extends \controllers\front\order\MainOrderFrontController
{
    protected $permissibleActions = array(
        'add',
        'sendOrderByOneClick'
    );

    protected function add()
    {
        $shopcart = $this->getController('shopcart')->getShopcart();
        $mail = new \modules\shopcart\lib\MailShopcart($shopcart);

        $res = $this->setObject($mail)
            ->modelObject->MailShopcartToAdmin();

        if($res == 1){
            $this->getController('shopcart')->resetShopcart();
            return $this->ajaxResponse(1);
        }

        return $this->ajaxResponse($this->modelObject->getErrors());
    }
}
