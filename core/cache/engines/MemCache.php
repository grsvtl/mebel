<?php
namespace core\cache\engines;
class MemCache implements \core\cache\ICacheEngine
{
	protected $host = 'localhost';
	protected $port = 11211;

	protected $config = array();

	private $_cacher;
	
	public function __construct()
	{
		$this->config = \core\Configurator::getInstance()->cache->engines->getArrayByKey('MemCache');
	}
	
	/**
     * Get cache engine object
     *
     * @return \Memcache Memcache Instance Object
	 * 
     */
	protected function getCacher()
	{
		if (empty($this->_cacher))
			$this->instanceMemCacheObject();
		return $this->_cacher;
	}
	
	private function instanceMemCacheObject()
	{
		$this->_cacher = new \Memcache();
		$this->_cacher->addServer($this->config['host'], $this->config['port']);
	}
	
	public function set($data, $key, $group = 'default')
	{
		return $this->getCacher()->add($this->getSerialize($key).$group, $this->getSerialize($data));
	}
	
	protected function getSerialize($key)
	{
		return serialize($key);
	}
	
	public function get($key, $group = 'default')
	{
		return unserialize($this->getCacher()->get($this->getSerialize($key).$group));
	}
	
	public function remove($key, $group = 'default')
	{
		return $this->getCacher()->delete($this->getSerialize($key).$group);
	}
	
	public function removeGroup($group)
	{
		return $this->getCacher()->removeGroup($group);
	}
	
	public function removeAll()
	{
		return $this->getCacher()->flush();
	}
}