<?php
namespace core\traits\objects;
trait SiteMapPriority
{
	private $priorityByDepth = array(
		'default'=>'0',
		'1'=> '1.0',
		'2'=> '0.8',
		'3'=> '0.6',
		'4'=> '0.4',
		'5'=> '0.2'
	);

	protected function getSitemapPriorityByPath($path)
	{
		$depth = substr_count($path, '/') == array_search(substr_count($path, '/'), $this->priorityByDepth) ? 'default' : substr_count($path, '/');
		return isset($depth, $this->priorityByDepth) ? $this->priorityByDepth[$depth] : $this->priorityByDepth['default'];
	}
}