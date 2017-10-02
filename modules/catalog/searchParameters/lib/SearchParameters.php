<?php
namespace modules\catalog\searchParameters\lib;
use modules\catalog\catalog\lib\CatalogItemConfig;

class SearchParameters extends \core\modules\base\ModuleDecorator
{
    function __construct()
    {
        $object = new SearchParametersObject();
        $object = new \core\modules\statuses\StatusesDecorator($object);
        parent::__construct($object);
    }

    public function getCorpusParameters()
    {
        $parameterId = CatalogItemConfig::CORPUS_PARMETERS_ID;

        $parameters = (new \modules\parameters\lib\Parameters())
            ->setSubquery('AND `id` = (?d)', $parameterId)
            ->setOrderBy('`priority` ASC');

        return $parameters->current()->getParameterValues();
    }
}