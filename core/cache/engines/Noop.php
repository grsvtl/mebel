<?php
namespace core\cache\engines;
class Noop implements \core\cache\ICacheEngine
{
	public function set($data, $key, $group = 'default')
	{
		return true;
	}
	
	public function get($key, $group = 'default')
	{
		return false;
	}
	
	public function remove($key, $group = 'default')
	{
		return true;
	}
	
	public function removeGroup($group)
	{
		return true;
	}
	
	public function removeAll()
	{
		return true;
	}
}