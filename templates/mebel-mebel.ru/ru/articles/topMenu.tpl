<nav>
	<?foreach($topMenu as $item):?>

	<?if($this->getRequest()['controller']=='shopcart'):?>
		<a href="<?=$item->getPath()?>"><?=$item->getName()?></a>
	<?else:?>
		<? if ($this->getRequest()['action']==str_replace("/","",$item->getPath())): ?>
		<span><?=$item->getName()?></span>
		<?else:?>
		<a href="<?=$item->getPath()?>"><?=$item->getName()?></a>
		<?endif?>
	<?endif?>

	<?endforeach?>
</nav>