<?php
namespace controllers\front\order;

class LeromMebelOrderFrontController extends \controllers\front\order\MainOrderFrontController
{
    protected $permissibleActions = array(
        'add',
        'sendOrderByOneClick'
    );
}