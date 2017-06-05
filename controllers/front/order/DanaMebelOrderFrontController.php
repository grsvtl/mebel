<?php
namespace controllers\front\order;
class DanaMebelOrderFrontController extends \controllers\front\order\MainOrderFrontController
{
    protected $permissibleActions = array(
        'add',
        'sendOrderByOneClick'
    );
}
