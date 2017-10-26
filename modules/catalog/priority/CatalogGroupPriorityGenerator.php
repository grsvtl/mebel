<?php
namespace modules\catalog\priority;
use core\db\Db;
use modules\catalog\priority\lib\CatalogPriorityConfig;

class CatalogGroupPriorityGenerator
{
    private $domainAlias;
    private $categoryId;
    private $prioritiesArray;
    private $table;

    public function __construct($domainAlias, $categoryId, $prioritiesArray)
    {
        $this->domainAlias = $domainAlias;
        $this->categoryId = $categoryId;
        $this->prioritiesArray = $prioritiesArray;
        $this->table = (new CatalogPriorityConfig())->mainTable();
    }

    public function execute()
    {
        if ( !$this->removeExists() )
            throw new \Exception('Group catalog item priority not removed');
        if ( !$this->storeNew() )
            throw new \Exception('Group catalog item priority removed, but not stored new one');
        return true;
    }

    private function removeExists()
    {
        $query = 'DELETE FROM `'.$this->table.'` WHERE ';
        foreach ($this->prioritiesArray as $goodId=>$priority){
            $query .= '(
                            `goodId`='.$goodId.' 
                            AND `domainAlias`="'.$this->domainAlias.'" 
                            AND `categoryId`='.$this->categoryId.'
                        )  OR';
        }
        $query = substr($query, 0, -2);
        return (bool)Db::getMysql()->query($query);
    }

    private function storeNew()
    {
        $query = 'INSERT INTO `'.$this->table.'` (`goodId`, `domainAlias`, `categoryId`, `priority`) VALUES';
        foreach ($this->prioritiesArray as $goodId=>$priority)
            $query .= '('.$goodId.', "'.$this->domainAlias.'", "'.$this->categoryId.'",'.$priority.'),';
        $query = substr($query, 0, -1);
        return (bool)Db::getMysql()->query($query);
    }
}