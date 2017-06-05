<?php
namespace core;
class Noop
{
	use traits\ObjectPool;

	public function __get($variable)
	{
		return null;
	}

	public function __call($function, $args)
	{
		return $this->getNoop();
	}

	public function __toString()
	{
		return '';
	}

	public function count()
	{
		return 0;
	}
}