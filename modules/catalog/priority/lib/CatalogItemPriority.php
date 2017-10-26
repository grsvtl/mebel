<?php
namespace modules\catalog\priority\lib;

use modules\catalog\catalog\lib\CatalogItem;

class CatalogItemPriority
{
    /**
     * @var CatalogItem
     */
    private $good;

    /**
     * @var string
     */
    private $domainAlias;

    /**
     * @var int
     */
    private $categoryId;

    public function __construct(CatalogItem $good, $domainAlias, $categoryId)
    {
        $this->_setGood($good)
             ->_setDomainAlias($domainAlias)
            ->_setCategoryId($categoryId);
    }

    /**
     * @param CatalogItem $good
     *
     * @return $this
     */
    private function _setGood( CatalogItem $good )
    {
        $this->good = $good;
        return $this;
    }

    /**
     * @param $domainAlias
     *
     * @return $this
     */
    private function _setDomainAlias( $domainAlias )
    {
        $this->domainAlias = $domainAlias;
        return $this;
    }

    /**
     * @param $categoryId
     *
     * @return $this
     */
    private function _setCategoryId( $categoryId )
    {
        $this->categoryId = $categoryId;
        return $this;
    }

    public function getPriority()
    {
        $priorities = new CatalogPriorities();
        $priorities->setSubquery(' AND `goodId`=?d AND `domainAlias`=\'?s\' AND `categoryId`=?d ', $this->good->id, $this->domainAlias, $this->categoryId );

        return $priorities->current();
    }
}