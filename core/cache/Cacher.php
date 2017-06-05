<?php
namespace core\cache;
class Cacher
{
	static protected $instance = null;
	
	protected $enginesPool = array();
	protected $config      = array();
	
	protected function __construct(){
		$this->loadConfig();
	}
	
	protected function loadConfig()
	{
		$this->config = \core\Configurator::getInstance()->getArrayByKey('cache');
	}
	
	public static function init()
	{
		if (is_null(self::$instance))
			self::$instance = new Cacher();
		return self::$instance;
	}
	
	/**
     * Get cache engine object
     *
     * @return \core\cache\ICacheEngine Instance cache engine
	 * 
     */
	public static function getInstance($engine = null)
	{
		$cacher = self::init();
		if ($cacher->isEnable()){
			$engineName = empty($engine)
				? $cacher->getDefaultEngineName()
				: (string)$engine;
		} else {
			$engineName = 'Noop';
		}
		return $cacher->getEngine($engineName);
	}
	
	public function isEnable()
	{
		return !!$this->config['config']['enable'];
	}
	
	public function getEngine($engineName)
	{
		if (!$this->checkEngineInPool($engineName))
			$this->instanceEngineToPool($engineName);
		return $this->enginesPool[$engineName];
	}
	
	private function checkEngineInPool($engineName)
	{
		return isset($this->enginesPool[$engineName]);
	}
	
	private function instanceEngineToPool($engineName)
	{
		$class = '\\core\\cache\\engines\\'.$engineName;
		if ($this->checkEngineClass($class)) {
			$this->enginesPool[$engineName] = new $class();
			return true;
		}
		throw new Exception('Unknown cache engine "'.$engineName.'" in class '.get_class($this).'!');
	}
	
	private function checkEngineClass($class)
	{
		return class_exists($class, true);
	}
	
	private function getDefaultEngineName()
	{
		return $this->config['config']['defaultEngine'];
	}
}