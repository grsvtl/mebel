<div class="bl">
	<div class="h4">Меню</div>
	<?foreach($footerMenu as $item):?>
	<a href="<?=$item->getPath()?>"><?=$item->getName()?></a>
	<?endforeach?>
</div>