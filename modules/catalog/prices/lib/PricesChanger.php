<?php
namespace modules\catalog\prices\lib;
use core\db\Db;
use modules\catalog\subGoods\lib\SubGoodConfig;

class PricesChanger
{
    use \core\traits\RequestHandler;

    private $config;
    private $subGoodConfig;
    private $mainTable = 'tbl_catalog_catalog_prices';
    private $dumpFileName = 'catalogPricesDump';
    private $dumpFileExtension = 'sql';
    private $sessionMark = 'dumpPriceChangeFileTime';

    public function __construct()
    {
        $this->config = new PriceConfig();
        $this->subGoodConfig = new SubGoodConfig();
    }

    public function execute($data)
    {
        $config = $this->config;
        $query = 'UPDATE `'.$this->mainTable.'` SET ';
        if( in_array('price', array_keys($data['prices'])) ){
            if($data['changePriceCurrency'] == '%')
                $query .= ' price = price '.$data['changePriceSign'].' round( price * '.$data['changePriceValue'].' / 100) ';
            else
                $query .= ' price = price '.$data['changePriceSign'].' round( '.$data['changePriceValue'].' ) ';
        }

        if( in_array('price', array_keys($data['prices']))  &&  in_array('oldPrice', array_keys($data['prices'])) )
            $query .= ' , ';

        if( in_array('oldPrice', array_keys($data['prices'])) ){
            if($data['changePriceCurrency'] == '%')
                $query .= ' oldPrice = CASE WHEN oldPrice = 0 THEN oldPrice
                    ELSE oldPrice '.$data['changePriceSign']. ' round( oldPrice * '.$data['changePriceValue'].' / 100)
                    END';
            else
                $query .= ' oldPrice = CASE WHEN oldPrice = 0
                    THEN 
                         round( price * '.$config::OLD_PRICE_COEFFICIENT.', '.$config::PRICE_ROUND_PRECISION.' ) '
                            .$data['changePriceSign'].
                        ' round( '.$data['changePriceValue'].' )                     
                    ELSE oldPrice '.$data['changePriceSign']. ' round( '.$data['changePriceValue'].' )
                    END';
        }

        $ids = '';
        foreach($data['group'] as $item)
            $ids .= $item.',';
        $ids = substr($ids, 0, -1);

        $query .= ' WHERE `objectId` IN ( '.$ids.' ) AND `quantity` = 1 ';
        $query .= ' AND (`objectId` NOT IN (SELECT `goodId` FROM `'.$this->subGoodConfig->mainTable().'` WHERE `goodId` IN ( '.$ids.') ))';
        $query .= ' ; ';

        return Db::getMysql()->query($query);
    }

    public function saveDump()
    {
        $time = date("Y_m_d_H:i:s");
        $_SESSION[$this->sessionMark] = $time;
        $fileName = $this->getDumpFileName($time);
        if(!Db::getMysql()->export($fileName, $this->mainTable))
            throw new \Exception ('Error while trying to export table in '.__CLASS__.'!');
        return $this;
    }

    private function getDumpFileName($timeString)
    {
        return $this->dumpFileName.'_'.$timeString.'.'.$this->dumpFileExtension;
    }

    public function rollback()
    {
        $fileName = $this->getDumpFileName($this->getSession()[$this->sessionMark]);
        $this->checkDumpFileExists($fileName);
        if(Db::getMysql()->import($fileName))
            return $this->deleteDumpFile();
        else
            throw new \Exception ('Error while trying to import table in '.__CLASS__.'!');
    }

    private function checkDumpFileExists()
    {
        $fileName = $this->getDumpFileName($this->getSession()[$this->sessionMark]);
        if(Db::getMysql()->isDumpFileExists($fileName))
            return $this;
        throw new \Exception ('Dump file does not exists or has expired date in '.__CLASS__.'!');
    }

    public function deleteDumpFile()
    {
        $fileName = $this->getDumpFileName($this->getSession()[$this->sessionMark]);
        $this->checkDumpFileExists($fileName);
        if(Db::getMysql()->deleteDumpFile($fileName)){
            unset($_SESSION[$this->sessionMark]);
            return 1;
        }
        return 'Error while trying to delete dump file in '.__CLASS__.'!';
    }
}