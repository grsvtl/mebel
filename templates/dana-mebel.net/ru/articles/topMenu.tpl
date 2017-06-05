<?if($topMenu->count()):?>
	<div class="mainMenu">
		<div class="mainMenuCenter">
			<div class="menuButton">Меню</div>
			<div class="closeButton"></div>
			<nav>
				<?foreach($topMenu as $item):?>
				<a href="<?=$item->getPath()?>" class="<?//= $this->getFirstUriElement()==$item->alias ? 'active' : ''?>">
					<?=$item->getName()?>
				</a>
				<?endforeach;?>
			</nav>
			<div class="clear"></div>
		</div>
	</div>
<?endif?>