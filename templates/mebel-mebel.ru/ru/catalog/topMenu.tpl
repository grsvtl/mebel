<div class="catalog">
<!--<section class="catalog">-->
	<!--<section class="catalog-inset">-->
	<div class="catalog-inset">
		<nav>
			<ul>
				<? $i=1; foreach($topMenu as $category):?>
				<li class="menu_item">
					<a <?= $i==1 ? 'id="first"' : ''?> <?= $i==count($topMenu) ? 'id="end"' : ''?> href="<?=$category->getPath()?>" class="<?= $this->getRequest()['action']==$category->alias ? 'active' : ''?>"><?=$category->getName()?></a>

					<div class="moreCategoris">
						<ul>
						<?foreach($category->getChildren(1) as $child):?>
							<?//$count = $this->getController('Catalog')->getObjectsByCategory($child)->count()?>
							<?//if($count):?>
							<li>
								<?if($child->image):?>
								<img src="<?=$child->image?>" alt="<?=$child->getName()?>">
								<?endif?>
								<a class="<?= $this->getRequest()[0]==$child->alias ? 'currentItem' : ''?>" href="<?=$child->getPath()?>">
									<?=$child->getName()?>
									<!--<span>(<?//=$count?>)</span>-->
								</a>
								<div class="clear"></div>
							</li>
							<?//endif?>
						<?endforeach?>
						</ul>
						<div class="clear"></div>
						<div class="bottomButton">
							<a href="<?=$category->getPath()?>" class="bottomButtonLinck">Все товары категории</a>
						</div>
					</div>

				</li>
				<? $i++; endforeach?>
			</ul>
			<div class="clear"></div>
		</nav>
	<!--</section>-->
	</div>
<!--</section>-->
</div>