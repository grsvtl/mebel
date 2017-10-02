<?php
namespace controllers\admin;
use modules\catalog\searchParameters\lib\SearchParameterConfig;

class SearchParametersAdminController extends \controllers\base\Controller
{
    use	\core\traits\controllers\Categories,
        \core\traits\controllers\Rights,
        \core\traits\controllers\Templates,
        \core\traits\controllers\Authorization,
        \core\traits\Pager,
        \controllers\admin\traits\ListActionsAdminControllerTrait;

    protected $permissibleActions = array(
        'searchParameters',
        'searchParameter',
        'edit',
        'changePriority'
    );

    public function __construct()
    {
        parent::__construct();
        $this->_config = new \modules\catalog\searchParameters\lib\SearchParameterConfig();
        $this->objectClass = $this->_config->getObjectClass();
        $this->objectsClass = $this->_config->getObjectsClass();
        $this->objectClassName = $this->_config->getObjectClassName();
        $this->objectsClassName = $this->_config->getObjectsClassName();
    }

    protected function defaultAction()
    {
        $this->boot();
        return $this->searchParameters();
    }

    protected function boot()
    {
        $this->setObject($this->objectsClass);
        $searchParametersCount = $this->modelObject->count();
        $parameters = (new $this->objectsClass)->getCorpusParameters();

        if ($searchParametersCount == 0) {
            $i = 1;
            foreach ($parameters as $parameter) {
                $this->modelObject->add(
                    [
                        'parameterValueId' => $parameter->id,
                        'priority' => $i,
                        'statusId' => SearchParameterConfig::ACTIVE_STATUS_ID
                    ], $this->modelObject->getConfig()->getObjectFields());
                $i++;
            }
        }
    }

    protected function searchParameters()
    {
        $this->checkUserRightAndBlock('articles');
        $this->rememberPastPageList($_REQUEST['controller']);

        $this->setObject($this->objectsClass);
        $value = (empty($this->getGET()['value'])) ? '' : \core\utils\DataAdapt::textValid($this->getGET()['value']);
        $status = (empty($this->getGET()['statusId'])) ? '' : \core\utils\DataAdapt::textValid($this->getGET()['statusId']);
        $itemsOnPage = (empty($this->getGET()['itemsOnPage'])) ? '' : \core\utils\DataAdapt::textValid($this->getGET()['itemsOnPage']);

        $this->modelObject->setOrderBy('`priority` ASC, `id` DESC')->setPager($itemsOnPage);

        $this->setContent('objects', $this->modelObject)
            ->setContent('pager', $this->modelObject->getPager())
            ->setContent('pagesList', $this->modelObject->getQuantityItemsOnSubpageListArray())
            ->includeTemplate($this->_config->getAdminTemplateDir().'searchParameters');
    }

    protected function searchParameter()
    {
        $this->checkUserRightAndBlock('article');
        $this->useRememberPastPageList();

        $searchParameter = new \core\Noop();
        if (isset($this->getREQUEST()[0]))
            $searchParameter = $this->getObject($this->_config->getObjectClass(), $this->getREQUEST()[0]);

        $tabs = array('editSearchParameter' => 'Параметры');

        $searchParameters = new $this->objectsClass;
        $this->setContent('searchParameter', $searchParameter)
            ->setContent('tabs', $tabs)
            ->setContent('statuses', $searchParameters->getStatuses())
            ->includeTemplate($this->_config->getAdminTemplateDir().'searchParameter');
    }

    protected function edit()
    {
        $this->checkUserRightAndBlock('article_edit');
        $this->setObject($this->_config->getObjectClass(), (int)$this->getPOST()['id'])->ajax($this->modelObject->edit($this->getPOST(), $this->modelObject->getConfig()->getObjectFields()), 'ajax', true);
    }

    protected function mb_ucfirst($string, $encoding = 'UTF-8')
    {
        $strlen = mb_strlen($string, $encoding);
        $firstChar = mb_substr($string, 0, 1, $encoding);
        $then = mb_substr($string, 1, $strlen - 1, $encoding);
        return mb_strtoupper($firstChar, $encoding) . $then;
    }
}