<?php
namespace core\cache\engines;
class Pear2CacheLite implements \core\cache\ICacheEngine
{
	protected $cacheDir = '/cache/CacheLite/';
	protected $fileLocking = true;
	protected $writeControl = true;
	protected $readControl = true;
	protected $readControlType = 'crc32';
	protected $fileNameProtection = true;
	protected $automaticCleaningFactor = 0;
	protected $nestedDirectoryLevel = 0;
	protected $nestedDirectoryUmask = 0700;

	protected $config = array();

	private $_cacher;

	public function __construct()
	{
		$this->config = \core\Configurator::getInstance()->cache->engines->getArrayByKey('Pear2CacheLite');
	}

	/**
     * Get cache engine object
     *
     * @return \PEAR2\Cache\Lite\Main PEAR2CacheLite Instance Object
	 *
     */
	protected function getCacher()
	{
		if (empty($this->_cacher))
			$this->instancePearObject();
		return $this->_cacher;
	}

	private function instancePearObject()
	{
		$this->_cacher = new \PEAR2\Cache\Lite\Main;
		$this->_cacher->setCacheDir(DIR.$this->cacheDir);
	}

	public function set($data, $key, $group = 'default')
	{
		return $this->getCacher()->save($this->getSerialize($data), $this->getSerialize($key), $group);
	}

	protected function getSerialize($key)
	{
		return serialize($key);
	}

	public function get($key, $group = 'default')
	{
		return unserialize($this->getCacher()->get($this->getSerialize($key), $group));
	}

	public function remove($key, $group = 'default')
	{
		return $this->getCacher()->remove($this->getSerialize($key), $group);
	}

	public function removeGroup($group)
	{
		return $this->getCacher()->removeGroup($group);
	}

	public function removeAll()
	{
//		$this->getCacher()->cleanOld();
		return $this->_deleteFiles(DIR . $this->cacheDir);
	}

	private function _deleteFiles($dir)
	{
		if($handle = opendir($dir)){
			while(false !== ($file = readdir($handle)))
				if($file != "." && $file != "..")
					unlink($dir.$file);
			closedir($handle);
		}
		return empty(array_diff(scandir($dir), array('..', '.')));
	}
}