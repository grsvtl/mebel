<?if(!empty($catalogLeftMenu)):?>
<div class="catalogMenu">
	<div class="titleCatalogMenu">Каталог</div>
	<nav>
		<ul>
			<?foreach($catalogLeftMenu as $item):?>
			<li class="<?= $this->getFirstUriElement()==$item->alias ? 'active' : ''?>">
				<a href="<?=$item->getPath()?>" >
					<?=$item->getName()?>
				</a>
			</li>
			<?endforeach?>
            <li class="<?= $this->getFirstUriElement()=='types' ? 'active' : ''?>"><a href="/types/" >По типу</a></li>
		</ul>
	</nav>
</div>
<?endif?>