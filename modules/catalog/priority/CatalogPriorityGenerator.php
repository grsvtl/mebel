<?php
namespace modules\catalog\priority;

use modules\catalog\catalog\lib\CatalogItem;
use modules\catalog\priority\lib\CatalogItemPriority;
use modules\catalog\priority\lib\CatalogPriorities;

/**
 * Class CatalogPriorityGenerator
 *
 * @package modules\catalog\priority
 */
class CatalogPriorityGenerator
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

    /**
     * @var int
     */
    private $priority;

    private $priorities;

    /**
     * CatalogPriorityGenerator constructor.
     *
     * @param CatalogItem $good
     * @param             $domainAlias
     * @param             $categoryId
     * @param             $priority
     */
    public function __construct(CatalogItem $good, $domainAlias, $categoryId, $priority)
    {
        $this->_setGood($good)
             ->_setDomainAlias($domainAlias)
             ->_setCategoryId($categoryId)
             ->_setPriority($priority);

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

    /**
     * @param $priority
     *
     * @return $this
     */
    private function _setPriority( $priority )
    {
        $this->priority = $priority;
        return $this;
    }

    /**
     * @return bool
     */
    private function removeExists()
    {
        $priority = new CatalogItemPriority($this->good, $this->domainAlias, $this->categoryId);
        if ( !$priority->getPriority() ) {
            return true;
        }

        return $priority->getPriority()->delete();
    }

    /**
     * @return bool
     */
    private function storeNew()
    {
        $this->priorities = new CatalogPriorities();
        $data = array(
            'goodId'      => $this->good->id,
            'domainAlias' => $this->domainAlias,
            'categoryId'  => $this->categoryId,
            'priority'    => $this->priority
        );

        return $this->priorities->add($data);
    }

    /**
     * @return bool
     * @throws \Exception
     */
    public function execute()
    {
        if ( !$this->removeExists() ) {
            throw new \Exception('Catalog item priority not removed');
        }

        if ( !$this->storeNew() ) {
            throw new \Exception('Catalog item priority removed, but not stored new one');
        }

        return true;
    }

}