<?php
namespace controllers\front\service;
class LeromMebelServiceFrontController extends \controllers\base\Controller
{
    use    \core\traits\controllers\ControllersHandler,
        \core\traits\controllers\Templates;

    private $actionsRedirects = array(
        'sitemap.xml' => 'sitemap',
        'robots.txt' => 'robots',
        'YML.xml' => 'yml'
    );

    public function __call($actionName, $arguments)
    {
        if (method_exists($this, $actionName))
            return call_user_func_array(array($this, $actionName), $arguments);
        elseif (isset($this->actionsRedirects[$actionName])) {
            $action = $this->actionsRedirects[$actionName];
            return $this->$action();
        } else {
            $defaultControllerName = \core\Configurator::getInstance()->controllers->defaultFrontController;
            return $this->getController($defaultControllerName)->$actionName();
        }
    }

    public function redirect404()
    {
        $this->getController('Article')->view404();
    }

    public function accessDenied($right)
    {
        $this->redirect404();
    }

    public function forbidden()
    {
        $this->redirect404();
    }

}