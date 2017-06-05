<?php
namespace core\cache\interfaces;namespace core\cache;
interface ICacheEngine
{
	public function set($data, $key, $group = 'default'); // return bool;
	public function get($key, $group = 'default'); // return Mixed-data
	public function remove($key, $group = 'default'); // return bool;
	public function removeGroup($group); // return bool;
	public function removeAll(); // return bool;
}